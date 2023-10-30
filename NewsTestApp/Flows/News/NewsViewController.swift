import Foundation
import UIKit
import SnapKit
import Combine

class NewsViewController: NiblessViewController {
    
    var filteredArticles: [NewsCellViewModel] = []

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tableView
    }()

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        
        return searchController
    }()
    
    private let viewModel: NewsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = Asset.textColor.color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Asset.textColor.color, .font: UIFont.boldSystemFont(ofSize: 20.0)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "News"
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        view.backgroundColor = .white
        
        activityIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(activityIndicator)
        
        setupBindings()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        setupBindings()
        sender.endRefreshing()
    }
    
    private func setupBindings() {
        activityIndicator.startAnimating()
        viewModel.reloadInfoData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setupViews()
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }.store(in: &subscriptions)
    }
    
}

extension NewsViewController {
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        tableView.accessibilityIdentifier = "tableView"
        tableView.snp.makeConstraints { make in
            make.top.equalTo((navigationController?.navigationBar.snp.bottom)!)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let info = viewModel.cellViewModels
        filteredArticles = info.filter({(news: NewsCellViewModel) -> Bool in
            return news.author.contains(searchText) || news.title.contains(searchText) || news.description.contains(searchText) || news.source.contains(searchText)
        })
        tableView.reloadData()
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArticles.count
        }
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewModels: NewsCellViewModel
        if isFiltering {
            viewModels = filteredArticles[indexPath.row]
        } else {
            viewModels = viewModel.cellViewModels[indexPath.row]
        }
        
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.setup(viewModels)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension NewsViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("performDropWith")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModels: NewsCellViewModel
        if isFiltering {
            viewModels = filteredArticles[indexPath.row]
            viewModels.onSelect()
        } else {
            viewModels = viewModel.cellViewModels[indexPath.row]
            viewModels.onSelect()
        }
    }
    
}

extension NewsViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        [UIDragItem(itemProvider: NSItemProvider())]
    }
    
}

extension NewsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
