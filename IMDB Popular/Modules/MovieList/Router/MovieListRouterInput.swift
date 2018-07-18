import Foundation

protocol MovieListRouterInput {
    func showMovieDetailScreen(from view: MovieListViewInput, for movie: MovieModel)
}
