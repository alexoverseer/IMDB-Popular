import Kingfisher
import Reusable
import UIKit

class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.addShadow()
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.2) {
            if highlighted {
                self.movieTitleLabel.textColor = UIColor.appOrange
            } else {
                self.movieTitleLabel.textColor = UIColor.black
            }
        }
    }
    
    func setupCell(withModel model: MovieModel) {
        movieTitleLabel.text = model.title
        movieYearLabel.text = "Year: \(model.releaseDate)"
        movieRatingLabel.text = "Rating: \(model.voteAverage)"
        movieDescriptionLabel.text = model.overview
        guard let posterPath = model.posterPath else { return }
        loadPosterImage(posterPath: posterPath.getImageURL(quality: .low))
    }
    
    private func loadPosterImage(posterPath: String) {
        movieImageView?.kf.indicatorType = .activity
        movieImageView?.kf.setImage(with: URL(string: posterPath),
                                    placeholder: #imageLiteral(resourceName: "MoviePlaceHolder"),
                                    options: [.transition(ImageTransition.fade(0.5))],
                                    progressBlock: nil,
                                    completionHandler: nil)
    }
}
