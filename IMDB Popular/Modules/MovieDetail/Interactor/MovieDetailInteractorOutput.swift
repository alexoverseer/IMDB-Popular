import UIKit

protocol MovieDetailInteractorOutput: class {
    func didRetrieveMovieDetails(_ movieDetails: MovieDetailModel)
    func onError(_ error: ErrorType)
    func didRetrieveMovieCover(cover movieCover: UIImage)
    func didRetrieveMoviePoster(poster moviePoster: UIImage)
}
