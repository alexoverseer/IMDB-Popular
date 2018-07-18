import UIKit

final class MovieDetailModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: MovieDetailViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: MovieDetailViewController) {

        let router = MovieDetailRouter()

        let presenter = MovieDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MovieDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
