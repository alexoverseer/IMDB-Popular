import Foundation

final class MovieDetailPresenter {

    weak var view: MovieDetailViewInput!
    var interactor: MovieDetailInteractorInput!
    var router: MovieDetailRouterInput!
    
    var movie: MovieModel?
    
    func viewIsReady() {
        
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
	
}
