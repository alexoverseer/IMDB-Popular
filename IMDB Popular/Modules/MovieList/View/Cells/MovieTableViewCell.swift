import Kingfisher
import Reusable
import UIKit

class MovieTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    
    func setupCell(withModel model: MovieModel) {
        movieTitleLabel.text = model.title
        movieYearLabel.text = "Year: \(model.releaseDate)"
        movieRatingLabel.text = "Rating: \(model.voteAverage)"
        loadPosterImage(posterPath: "https://image.tmdb.org/t/p/w500\(model.posterPath)")
    }
    
    private func loadPosterImage(posterPath: String) {
        movieImageView?.kf.indicatorType = .activity
        movieImageView?.kf.setImage(with: URL(string: posterPath),
                                    placeholder: #imageLiteral(resourceName: "MoviePlaceHolder"),
                                    options: [.transition(ImageTransition.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: { [weak self] (image, _, _, _) in
                                        
                                        self?.movieImageView.image = image
        })
    }
}