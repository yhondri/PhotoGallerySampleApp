import UIKit
import Combine

class PhotoGalleryViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoRowTVCellView.self, forCellReuseIdentifier: PhotoRowTVCellView.cellIdentifier)
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var loadMore: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load More"
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { [unowned self] _ in
            self.viewModel.loadNextPage()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: PhotoGalleryViewModel
    private var bindings = Set<AnyCancellable>()

    init(photosDIContainer: PhotosDIContainer) {
        viewModel = PhotoGalleryViewModel(photosDIContainer: photosDIContainer)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Photo Gallery List"
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(loadMore)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            loadMore.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadMore.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            loadMore.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadMore.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.reloadData
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
                self?.reloadData()
            })
            .store(in: &bindings)
    }
    
    private func reloadData() {
        loadMore.isHidden = !viewModel.hasMorePages
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PhotoGalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoRowTVCellView.cellIdentifier, for: indexPath) as? PhotoRowTVCellView else  {
            fatalError("Couldn't reuse cell")
        }
        let photoData = viewModel.photos[indexPath.row]
        cell.delegate = viewModel
        cell.configureCell(photoData: photoData)
        return cell
    }
}
