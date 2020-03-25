import Kingfisher
import Reusable
import UIKit

class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.2) {
            if highlighted {
                self.movieTitleLabel.textColor = UIColor.appOrange
            } else {
                if #available(iOS 13, *) {
                    self.movieTitleLabel.textColor = UIColor.label
                } else {
                    self.movieTitleLabel.textColor = UIColor.black
                }
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
        let url = URL(string: posterPath)
        
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "MoviePlaceHolder"),
            options: [
//                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ]
        )
    }
}
