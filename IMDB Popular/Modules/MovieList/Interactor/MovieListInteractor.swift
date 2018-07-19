import Foundation

final class MovieListInteractor: MovieListInteractorInput {

    weak var output: MovieListInteractorOutput!
    
    let movieServiceAPI: MoviesProtocol
    
    init(api service: MoviesProtocol = MovieService()) {
        self.movieServiceAPI = service
    }
    
    func requestMoviesList(for page: Int?) {
        movieServiceAPI.requestMovies(page: page, onSuccess: { [weak self] movies in
            self?.output.didRetrieveMovieDetails(movies.page, totalPages: movies.totalPages)
            self?.output.didRetrieveMovies(movies.results)
        }, onFailure: { [weak self] error in
            self?.output.onError(error)
        })
    }
}
