import UIKit

final class MovieListRouter: MovieListRouterInput {
    
    func showMovieDetailScreen(from view: MovieListViewInput, for movie: MovieModel) {
        
        let movieDetailViewController = MovieDetailViewController.instantiate()
        MovieDetailModuleConfigurator().configureModule(for: movieDetailViewController)
        if let movieDetailPresenter = movieDetailViewController.output as? MovieDetailPresenter {
            movieDetailPresenter.didSetMovie(movie)
        }
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}
