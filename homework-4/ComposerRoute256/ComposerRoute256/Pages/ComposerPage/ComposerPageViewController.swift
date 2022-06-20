//
//  ComposerPageViewController.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

final class ComposerPageViewController: UIViewController {

    // MARK: Private Properties

    private let dequeuer: ComposerDequeuer

    private var widgetViewModels: [IWidgetViewModel] = []

    private var startURL: URL?
    private var nextURL: URL?
    private var isLoading: Bool = false

    // MARK: Subviews

    private let collectionView: UICollectionView

    // MARK: Dependencies

    private let composerService: ComposerService
    private let composerConfig: ComposerConfig

    // MARK: Initialization

    init(composerService: ComposerService,
         composerConfig: ComposerConfig,
         startURL: URL? = nil) {
        self.composerService = composerService
        self.composerConfig = composerConfig
        self.startURL = startURL ?? .startUrl

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dequeuer = ComposerDequeuer(collectionView: collectionView)
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let startURL = startURL else { return }
        fetchData(url: startURL)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

// MARK: - UICollectionViewDataSource

extension ComposerPageViewController: UICollectionViewDataSource {
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

extension ComposerPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = widgetViewModels[indexPath.item]

        let containerSize = collectionView.bounds.size

        if let viewModelWithSizing = viewModel as? IWidgetViewModelWithAutoLayoutSizing {
            return viewModelWithSizing.sizeThatFits(composerConfig: composerConfig,
                                                    containerSize: containerSize)
        } else {
            return viewModel.sizeFor(composerSize: containerSize)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == widgetViewModels.count - 1 {
            fetchNextPageIfNeeded()
        }
    }
}

// MARK: - Private

private extension ComposerPageViewController {
    func setupUI() {
        title = "ComposerPage"
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.refreshControl = .init()
        collectionView.refreshControl?.tintColor = .black
        collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
    }

    func fetchData(url: URL) {
        hideEmptyState()
        collectionView.refreshControl?.beginRefreshing()

        composerService.fetchPage(from: url) { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false

            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }

            switch result {
            case .success(let page):
                self.nextURL = page.nextURL

                if !page.unparsedWidgets.isEmpty {
                    let notificationView = NotificationView(type: .error,
                                                            message: "Не смогли отобразить виджет(-ы)",
                                                            action: nil)
                    notificationView?.show()
                }

                let newWidgetViewModels = page.widgetModels.compactMap {
                    self.composerConfig.widgetAssembly(for: $0.meta)?.buildWidgetViewModel(model: $0)
                }

                self.widgetViewModels.append(contentsOf: newWidgetViewModels)
                self.collectionView.reloadData()
            case .failure(let error):
                self.nextURL = nil
                self.showEmptyState(error)
            }
        }
    }

    func fetchNextPageIfNeeded() {
        guard !isLoading, let nextURL = nextURL else { return }
        fetchData(url: nextURL)
    }

    @objc
    func refresh() {
        guard let startURL = startURL else { return }
        fetchData(url: startURL)
    }
}

// MARK: - EmptyStateActionDelegate

extension ComposerPageViewController: EmptyStateActionDelegate {
    func emptyViewDidInvokeAction() {
        collectionView.refreshControl?.endRefreshing()
        refresh()
    }
}

// MARK: - Constants

private extension URL {
    static let startUrl = URL(string: "https://api.ozon.ru/composer-api.bx/")
}
