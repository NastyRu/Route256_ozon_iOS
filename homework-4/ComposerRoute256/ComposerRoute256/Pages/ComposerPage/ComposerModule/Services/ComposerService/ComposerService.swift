//
//  ComposerService.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Разбить на методы, класс очень сложный
final class ComposerService {

    // MARK: Private Properties

    private var task: URLSessionDataTask?

    // MARK: Dependencies

    private let composerConfig: ComposerConfig
    private let widgetParsingLogger: IWidgetParsingLoggingService

    // MARK: Initialization

    init(composerConfig: ComposerConfig,
         widgetParsingLogger: IWidgetParsingLoggingService) {
        self.composerConfig = composerConfig
        self.widgetParsingLogger = widgetParsingLogger
    }
}

// MARK: - Methods

extension ComposerService {
    func fetchPage(from url: URL, completion: @escaping (Result<ComposerPage, Error>) -> Void) {
        task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            // 1 — декодируем composerResponse из data
            guard let self = self, let data = data else {
                completion(.failure(ComposerError.decodeFailed(error)))
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
                completion(.failure(ComposerError.deserialization(data)))
                return
            }

            let composerResponse: ComposerResponse
            do {
                composerResponse = try JSONDecoder().decode(ComposerResponse.self, from: data)
            } catch {
                completion(.failure(ComposerError.decodeFailed(error)))
                return
            }

            // 2 — подготавливаем массив для полученных моделей и проходим по каждому layoutComponent из composerResponse
            var widgetModelsResults: [ComposerWidgetModelResult] = []
            for layoutComponent in composerResponse.layout {
                // 3 — собираем модель виджета и сохраняем ее в массив моделей
                let widgetModel = self.makeWidgetModel(from: layoutComponent, json: json)
                widgetModelsResults.append(widgetModel)
            }

            // Обрабатываем пустую композерную страницу, чтобы отображать емпти стейт
            guard !widgetModelsResults.isEmpty else {
                completion(.failure(ComposerError.emptyPage))
                return
            }

            // Обрабатываем нераспарсенные виджеты
            let widgetModels = widgetModelsResults.compactMap { $0.widgetModel }
            let unparsedWidgets = widgetModelsResults.compactMap { $0.unparsedWidget }
            guard !widgetModels.isEmpty else {
                completion(.failure(ComposerError.parsingError(unparsedWidgets)))
                return
            }

            DispatchQueue.main.async {
                // 4 — возвращаем полученный массив моделей
                completion(.success(ComposerPage(unparsedWidgets: unparsedWidgets,
                                                 widgetModels: widgetModels,
                                                 nextURL: composerResponse.nextURL)))
            }
        })
        task?.resume()
    }
}

// MARK: - Private

private extension ComposerService {
    func makeWidgetModel(from layoutComponent: LayoutComponent, json: [String: Any]) -> ComposerWidgetModelResult {
        let meta = layoutComponent.meta

        // MARK: Этап 1 — Работа с JSON
        // 1 — достаем из JSON verticalState
        let verticalState = json[meta.vertical] as? [String: Any]

        // 2 - из vertical state достаем componentState
        let componentState = verticalState?[meta.component] as? [String: Any]

        // 3 - достаем
        guard let stateJSON = componentState?[layoutComponent.stateID] else {
            let unparsedWidget = buildUnparsedWidget(component: layoutComponent,
                                                     stateData: nil,
                                                     reason: .notFound)
            return .init(widgetModel: nil, unparsedWidget: unparsedWidget)
        }

        // MARK: Этап 2 - Парсим JSON
        // 1 - достаем assembly по meta (vertical и component) виджета
        guard let assembly = self.composerConfig.widgetAssembly(for: meta) else {
            let unparsedWidget = buildUnparsedWidget(component: layoutComponent,
                                                     stateData: nil,
                                                     reason: .assemblyNotFound)
            return .init(widgetModel: nil, unparsedWidget: unparsedWidget)
        }

        // 2 - Серелизуем JSON для парсинга в виджете (хотя можно было бы и продолжить работать с dict)
        let stateData: Data
        do {
            stateData = try JSONSerialization.data(withJSONObject: stateJSON, options: [])
        } catch {
            let unparsedWidget = buildUnparsedWidget(component: layoutComponent,
                                                     stateData: nil,
                                                     reason: .parsing(error))
            return .init(widgetModel: nil, unparsedWidget: unparsedWidget)
        }

        // 3 - Передаем в assembly stateData на парсинг
        let widgetModel: WidgetModel
        do {
            widgetModel = try assembly.buildWidgetModel(meta: layoutComponent.meta, data: stateData)
        } catch {
            let unparsedWidget = buildUnparsedWidget(component: layoutComponent,
                                                     stateData: stateData,
                                                     reason: .custom(error))
            return .init(widgetModel: nil, unparsedWidget: unparsedWidget)
        }

        return .init(widgetModel: widgetModel, unparsedWidget: nil)
    }

    func buildUnparsedWidget(component: LayoutComponent,
                             stateData: Data?,
                             reason: UnparsedWidget.Reason) -> UnparsedWidget {

        logUnparsedWidget(component: component, reason: reason, stateData: stateData)

        return .init(vertical: component.meta.vertical,
                     component: component.meta.component,
                     version: component.meta.version,
                     stateID: component.stateID,
                     reason: reason)
    }

    func logUnparsedWidget(component: LayoutComponent, reason: UnparsedWidget.Reason, stateData: Data?) {
        var userInfo: [String: Any] = [:]

        if let stateData = stateData,
           let json = try? JSONSerialization.jsonObject(with: stateData, options: []) as? [String: Any] {
            userInfo[ErrorLogKeys.state] = json
        }

        let errorDescription: String
        let error: Error?
        switch reason {
        case .notFound:
            errorDescription = "State Not Found\nStateID: \(component.stateID)\nWidget: \(component.meta.component)"
            error = nil
        case .assemblyNotFound:
            errorDescription = "Assembly Not Found\nVertical: \(component.meta.vertical)\nWidget: \(component.meta.component)"
            error = nil
        case let .parsing(parsingError):
            errorDescription = "Parsing Failed"
            error = parsingError
        case let .custom(underlyingError):
            errorDescription = "Custom Error"
            error = underlyingError
        }
        userInfo[ErrorLogKeys.errorDescription] = errorDescription

        if let error = error {
            userInfo[ErrorLogKeys.underlyingError] = (error as NSError).debugDescription

            if let decodingError = error as? DecodingError {
                let decodingErrorDescription: String
                switch decodingError {
                case let .dataCorrupted(context):
                    decodingErrorDescription = "Data Corrupted\nDetails: \(context.debugDescription)"
                case let .keyNotFound(key, context):
                    decodingErrorDescription = "Key Not Found\nKey: \(key)\nDetails: \(context.debugDescription)"
                case let .typeMismatch(type, context):
                    decodingErrorDescription = "Type Mismatch\nType: \(type)\nDetails: \(context.debugDescription)"
                case let .valueNotFound(value, context):
                    decodingErrorDescription = "Value Not Found\nValue: \(value)\nDetails\(context.debugDescription)"
                @unknown default:
                    decodingErrorDescription = "Unknown"
                }
                userInfo[ErrorLogKeys.decodingError] = decodingErrorDescription
            }
        }

        let incident = WidgetParsingIncident(vertical: component.meta.vertical,
                                             widgetName: component.meta.component,
                                             widgetVersion: "v\(component.meta.version)",
                                             userInfo: userInfo)
        widgetParsingLogger.logIncident(incident)
    }
}
