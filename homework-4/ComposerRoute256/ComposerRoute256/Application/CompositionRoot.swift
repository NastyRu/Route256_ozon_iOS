//
//  CompositionRoot.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 02.06.2022.
//

/// God-object. Представим, что это наш суперкрутой и умный DI.
final class CompositionRoot {

    // MARK: Singleton

    static let shared = CompositionRoot()

    // MARK: Public Properties

    let pageAssembliesContainer: PageAssemblyContainer
    let transitionHandler: TransitionHandler
    let deeplinkHandler: DeeplinkHandler
    let atomActionHandlersPool: IAtomActionHandlersPool
    let composerService: ComposerService
    let composerConfig: ComposerConfig
    let widgetParsingService: IWidgetParsingLoggingService
    let atomViewFactory: IAtomViewFactory

    // MARK: Singleton Initialization

    private init() {
        let container = PageAssemblyContainer()
        pageAssembliesContainer = container

        transitionHandler = .init(pageAssembliesContainer: pageAssembliesContainer)
        deeplinkHandler = .init(transitionHandler: transitionHandler)
        atomActionHandlersPool = AtomActionHandlersPool(deeplinkHandler: deeplinkHandler)
        widgetParsingService = WidgetParsingLoggingService.shared
        atomViewFactory = AtomViewFactory()

        composerConfig = .init(pool: atomActionHandlersPool,
                               atomViewFactory: atomViewFactory)
        composerService = .init(composerConfig: composerConfig,
                                widgetParsingLogger: widgetParsingService)


        // Используем немного грязный способ инджекта зависимостей,
        // чтобы мы могли создать все зависимости,
        // минуя циклические связи
        container.composerConfig = composerConfig
        container.composerService = composerService
        container.registerAssemblies()
    }
}

