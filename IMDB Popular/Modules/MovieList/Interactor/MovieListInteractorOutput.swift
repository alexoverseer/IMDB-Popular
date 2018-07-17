import Foundation

protocol MovieListInteractorOutput: class {
    func didRetrieveMovies(_ movies: [MovieModel])
    func didRetrieveMovieDetails(_ currentPage: Int, totalPages: Int)
    func onError(_ error: ErrorType)
}
