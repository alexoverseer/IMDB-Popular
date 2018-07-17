import Foundation

final class MovieListPresenter {

    weak var view: MovieListViewInput!
    var interactor: MovieListInteractorInput!
    var router: MovieListRouterInput!

    fileprivate var cellViewModels: [MovieModel] = [MovieModel]()
    
    fileprivate var currentPage: Int = 1
    fileprivate var totalPages: Int = 1
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.requestMoviesList(for: currentPage)
    }
}

// MARK: - MovieListModuleInput

extension MovieListPresenter: MovieListModuleInput {
	
}

// MARK: - MovieListViewOutput

extension MovieListPresenter: MovieListViewOutput {
    
    func getNextMovies() {
        if currentPage < totalPages {
            currentPage += 1
            interactor.requestMoviesList(for: currentPage)
        }
    }
    
    func numberOfCells() -> Int {
        return cellViewModels.count
    }
    
    func cellViewModel(index indexPath: IndexPath) -> MovieModel {
        return cellViewModels[indexPath.row]
    }
}

// MARK: - MovieListInteractorOutput

extension MovieListPresenter: MovieListInteractorOutput {
    
    func didRetrieveMovieDetails(_ currentPage: Int, totalPages: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
    }
    
    func didRetrieveMovies(_ movies: [MovieModel]) {
        cellViewModels += movies
        view.updateMoviesList()
    }
    
    func onError(_ error: ErrorType) {
        view.showError(error.message)
    }
}
