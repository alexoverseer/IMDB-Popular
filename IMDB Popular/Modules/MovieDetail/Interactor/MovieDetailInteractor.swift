import Foundation
import Kingfisher

final class MovieDetailInteractor: MovieDetailInteractorInput {
    
    weak var output: MovieDetailInteractorOutput!
    
    let movieServiceAPI: MoviesProtocol
    
    init(api service: MoviesProtocol = MovieService()) {
        self.movieServiceAPI = service
    }
    
    func requestMovieDetails(for movie: MovieModel) {
        movieServiceAPI.requestMovieDetails(movie: movie, onSuccess: { [weak self] movieDetailsModel in
            self?.output.didRetrieveMovieDetails(movieDetailsModel)
        }, onFailure: { [weak self] error in
            self?.output.onError(error)
        })
    }
    
    func requestMoviePoster(for movie: MovieDetailModel?) {
        guard let movieDetails = movie else { return }
        guard let posterPath = movieDetails.backdropPath else { return }
        let posterPathURL = posterPath.getImageURL(quality: .high)
        ImageDownloadManager.shared.fetchImage(with: posterPathURL) { [weak self] image in
            if let downloadedImage = image {
                self?.output.didRetrieveMovieCover(cover: downloadedImage)
            } else {
                self?.output.didRetrieveMovieCover(cover: #imageLiteral(resourceName: "MoviePlaceHolder"))
            }
        }
    }
    
    func requestMoviePosterThumbnail(for movie: MovieDetailModel?) {
        guard let movieDetails = movie else { return }
        guard let posterPath = movieDetails.posterPath else { return }
        let posterPathURL = posterPath.getImageURL(quality: .low)
        ImageDownloadManager.shared.fetchImage(with: posterPathURL) { [weak self] image in
            if let downloadedImage = image {
                self?.output.didRetrieveMoviePoster(poster: downloadedImage)
            } else {
                self?.output.didRetrieveMoviePoster(poster: #imageLiteral(resourceName: "MoviePlaceHolder"))
            }
        }
    }
}
