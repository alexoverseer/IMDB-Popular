import UIKit

final class MovieListViewController: UIViewController, StoryboardInstantiable {
	static var storyboardName: String = "MovieListViewController"
    
    var output: MovieListViewOutput!

    // MARK: - Outlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
}

// MARK: - MovieListViewInput

extension MovieListViewController: MovieListViewInput {
    
    func setupInitialState() {
        moviesTableView?.tableFooterView = UIView()
        moviesTableView?.register(cellType: MovieTableViewCell.self)
        self.title = "IMDB Popular"
    }
    
    func updateMoviesList() {
        DispatchQueue.main.async {
            self.moviesTableView?.reloadData()
        }
    }
    
    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
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
    }
}

// MARK: - UIScrollViewDelegate

extension MovieListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maximumOffset - currentOffset) <= 100 && (currentOffset > 0) {
            print("DOWNLOAD 1111")
        }
    }
}
