import UIKit
import Kingfisher
import ParallaxHeader

final class MovieDetailViewController: UIViewController, StoryboardInstantiable {
    static var storyboardName: String = "MovieDetailViewController"
    var output: MovieDetailViewOutput!
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var movieTitleLabel: UILabel!
    @IBOutlet fileprivate weak var movieRatingLabel: UILabel!
    @IBOutlet fileprivate weak var movieDurationLabel: UILabel!
    @IBOutlet fileprivate weak var movieBudgetLabel: UILabel!
    @IBOutlet fileprivate weak var movieReleaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var movieOverviewLabel: UILabel!
    @IBOutlet fileprivate weak var movieGenresLabel: UILabel!
    @IBOutlet fileprivate weak var movieRevenueLabel: UILabel!
    @IBOutlet fileprivate weak var movieProductionCompaniesLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieDetailsScrollView: UIScrollView! {
        didSet {
            movieDetailsScrollView.parallaxHeader.view = UIView()
            movieDetailsScrollView.parallaxHeader.height = 200
            movieDetailsScrollView.parallaxHeader.minimumHeight = 0
            movieDetailsScrollView.parallaxHeader.mode = .topFill
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            output.isClosingCurrentController()
        }
    }
}

// MARK: - MovieDetailViewInput

extension MovieDetailViewController: MovieDetailViewInput {
    
    func setupInitialState() {
        self.title = "Details"
    }
    
    func didGetCoverImage(_ coverImage: UIImage) {
        DispatchQueue.main.async {
            let posterImage = UIImageView(image: coverImage)
            posterImage.contentMode = .scaleAspectFill
            posterImage.alpha = 0
            self.movieDetailsScrollView.parallaxHeader.view = posterImage
            UIView.animate(withDuration: 0.3, animations: {
                self.movieDetailsScrollView.parallaxHeader.view.alpha = 1
            })
        }
    }
    
    func didGetPosterImage(_ posterImage: UIImage) {
        DispatchQueue.main.async {
            self.moviePosterImageView.image = posterImage
        }
    }
    
    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
            let okAction = AlertAction(onSelect: {}, name: "OK", style: .default)
            let alert = UIAlertController(info: AlertInfo(title: "Error", message: errorMessage, actions: [okAction]))
            self.present(alert, animated: true)
        }
    }
    
    func isLoadingMovieDetail(loading status: Bool) {
        DispatchQueue.main.async {
            if status {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func setupMovieDetails(_ details: MovieDetailModel?) {
        guard let movieDetails = details else { return }
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movieDetails.title
            self.movieRatingLabel.text = String(format: "%.1f", movieDetails.voteAverage)
            self.movieDurationLabel.text = "\(movieDetails.runtime) minutes"
            self.movieBudgetLabel.text = "$ \(movieDetails.budget.withCommas())"
            self.movieReleaseDateLabel.text = movieDetails.releaseDate
            self.movieOverviewLabel.text = movieDetails.overview
            self.movieRevenueLabel.text = "$ \(movieDetails.revenue.withCommas())"
            self.movieGenresLabel.text = movieDetails.genres.map {$0.name}.joined(separator: ", ")
            self.movieProductionCompaniesLabel.text = movieDetails.productionCompanies.map {$0.name}.joined(separator: "\n")
        }
    }
}
