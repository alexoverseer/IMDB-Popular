import UIKit
import Kingfisher

final class MovieListViewController: UIViewController, StoryboardInstantiable {
	static var storyboardName: String = "MovieListViewController"
    
    var output: MovieListViewOutput!

    // MARK: - Outlets
    
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    fileprivate lazy var tableFooterSpiner: UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: moviesTableView.bounds.size.width, height: 50)
        
        return spinner
    }()
    
    fileprivate lazy var moviesRefreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(MovieListViewController.refreshMovies), for: .valueChanged)
        
        return refreshControll
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Functional
    
    @objc func refreshMovies() {
        output.resetMovies()
    }
}

// MARK: - MovieListViewInput

extension MovieListViewController: MovieListViewInput {
    
    func setupInitialState() {
        self.title = "IMDB Popular"
        
        moviesTableView?.register(cellType: MovieTableViewCell.self)
        moviesTableView?.tableFooterView = tableFooterSpiner
        
        if #available(iOS 10.0, *) {
            moviesTableView?.refreshControl = moviesRefreshControll
        } else {
            moviesTableView?.addSubview(moviesRefreshControll)
        }
        
        KingfisherManager.shared.cache.maxMemoryCost = 1
    }
    
    func updateMoviesList() {
        DispatchQueue.main.async {
            self.moviesTableView?.reloadData()
        }
    }
    
    func isLoadingMovies(loading status: Bool) {
        DispatchQueue.main.async {
            if status {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
                self.moviesRefreshControll.endRefreshing()
            }
        }
    }
    
    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
            
            self.moviesTableView.tableFooterView?.isHidden = true
            
            let okAction = AlertAction(onSelect: {}, name: "OK", style: .default)
            let alert = UIAlertController(info: AlertInfo(title: "Error", message: errorMessage, actions: [okAction]))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource,

extension MovieListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfCells()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = output.cellViewModel(index: indexPath)
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.setupCell(withModel: cellModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.openMovieDetails(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex) {
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? MovieTableViewCell)!.movieImageView?.kf.cancelDownloadTask()
    }
}

// MARK: - UIScrollViewDelegate

extension MovieListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maximumOffset - currentOffset) <= 100 && (currentOffset > 0) {
            if !output.isLoadingNewMovies() {
                output.getNextMovies()
            }
        }
    }
}
