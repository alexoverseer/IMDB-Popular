import UIKit

final class MovieListModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: MovieListViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: MovieListViewController) {

        let router = MovieListRouter()

        let presenter = MovieListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MovieListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }   
}
