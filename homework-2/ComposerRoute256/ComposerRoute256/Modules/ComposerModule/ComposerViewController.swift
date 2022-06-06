//
//  ComposerViewController.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

class ComposerViewController: UIViewController {

    // MARK: Private Properties

    private let composerService = ComposerService(widgetParsingLogger: WidgetParsingLoggingService.shared)
    private let composerConfig = ComposerConfig.shared
    private let dequeuer: ComposerDequeuer

    private var widgetViewModels: [IWidgetViewModel] = []

    private var startURL: URL? = .startUrl
    private var nextURL: URL?
    private var isLoading: Bool = false

    // MARK: Subviews

    private let collectionView: UICollectionView

    // MARK: Initialization

    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dequeuer = ComposerDequeuer(collectionView: collectionView)
        super.init(coder: coder)
    }

    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

// MARK: - UICollectionViewDataSource

extension ComposerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgetViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = widgetViewModels[indexPath.item]

        // Получаем Cell по viewModel.reuseId
        let cell: ComposerCell = dequeuer.dequeueReusableCell(withReuseIdentifier: viewModel.reuseId, for: indexPath)

        if let widgetView = cell.widgetView {
            // Если переиспользуем view виджета
            widgetView.bind(viewModel: viewModel)
        } else {
            // Если создаем новую view
            let meta = viewModel.model.meta
            cell.widgetView = composerConfig.widgetAssembly(for: meta)?.buildWidgetView()
            cell.widgetView?.bind(viewModel: viewModel) // refactor
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ComposerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = widgetViewModels[indexPath.item]
        return viewModel.sizeFor(composerSize: collectionView.bounds.size)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == widgetViewModels.count - 1 {
            fetchNextPageIfNeeded()
        }
    }
}

// MARK: - Private

private extension ComposerViewController {
    func setupUI() {
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        guard let startURL = startURL else { return }
        fetchData(url: startURL)
    }

    func fetchData(url: URL) {
        composerService.fetchPage(from: url) { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            switch result {
            case .success(let page):
                self.nextURL = page.nextURL

                let newWidgetViewModels = page.widgetModels.compactMap {
                    self.composerConfig.widgetAssembly(for: $0.meta)?.buildWidgetViewModel(model: $0)
                }

                self.widgetViewModels.append(contentsOf: newWidgetViewModels)
                self.collectionView.reloadData()

                if !page.unparsedWidgets.isEmpty {
                    print(page.unparsedWidgets)
                    NotificationView(
                        type: NotificationView.NotificationType.error,
                        message: "Не смогли отобразить виджет(ы)"
                    )?.show()
                }
            case .failure(let error):
                self.showEmptyState(error)
                self.nextURL = nil
            }
        }
    }

    func fetchNextPageIfNeeded() {
        guard !isLoading, let nextURL = nextURL else { return }
        fetchData(url: nextURL)
    }
}

// MARK: - Constants

private extension URL {
    static let startUrl = URL(string: "https://api.ozon.ru/composer-api.bx/")
}
