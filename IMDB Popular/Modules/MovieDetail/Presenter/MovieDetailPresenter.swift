import UIKit

final class MovieDetailPresenter {

    weak var view: MovieDetailViewInput!
    var interactor: MovieDetailInteractorInput!
    var router: MovieDetailRouterInput!
    
    var movie: MovieModel?
    var movieDetails: MovieDetailModel?
    
    func viewIsReady() {
        if let movie = movie {
            interactor.requestMovieDetails(for: movie)
        }
        view.setupInitialState()
    }
}

// MARK: - MovieDetailModuleInput

extension MovieDetailPresenter: MovieDetailModuleInput {
    
    func didSetMovie(_ movie: MovieModel) {
        self.movie = movie
    }
}

// MARK: - MovieDetailViewOutput

extension MovieDetailPresenter: MovieDetailViewOutput {
    
    func isClosingCurrentController() {
        router.exitMazafaka(from: view)
    }
}

// MARK: - MovieDetailInteractorOutput

extension MovieDetailPresenter: MovieDetailInteractorOutput {
    
    func didRetrieveMovieCover(cover movieCover: UIImage) {
        view.didGetCoverImage(movieCover)
    }
    
    func didRetrieveMoviePoster(poster moviePoster: UIImage) {
        view.didGetPosterImage(moviePoster)
    }
    
    func didRetrieveMovieDetails(_ movieDetails: MovieDetailModel) {
        self.movieDetails = movieDetails
        view.setupMovieDetails(self.movieDetails)
        view.isLoadingMovieDetail(loading: false)
        interactor.requestMoviePoster(for: self.movieDetails)
        interactor.requestMoviePosterThumbnail(for: self.movieDetails)
    }
    
    func onError(_ error: ErrorType) {
        view.showError(error.message)
        view.isLoadingMovieDetail(loading: false)
    }
}
