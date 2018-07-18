import UIKit

final class MovieDetailRouter: NSObject, MovieDetailRouterInput {
    
    func exitMazafaka(from view: MovieDetailViewInput) {
        guard let viewController = view as? MovieDetailViewController else { return }
        viewController.navigationController?.delegate = self
    }
}

extension MovieDetailRouter: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewController = viewController as? MovieListViewController,
            let movieListPresenter = viewController.output as? MovieListPresenter else {
                return
        }
        movieListPresenter.onPopController(someData: "Pop from \(self)")
    }
}
