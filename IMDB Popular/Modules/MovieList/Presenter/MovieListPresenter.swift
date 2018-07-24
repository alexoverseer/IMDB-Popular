import Foundation

final class MovieListPresenter {

    weak var view: MovieListViewInput!
    var interactor: MovieListInteractorInput!
    var router: MovieListRouterInput!

    fileprivate var cellViewModels: [MovieModel] = [MovieModel]()
    
    fileprivate var currentPage: Int = 1
    fileprivate var totalPages: Int = 1
    fileprivate var itemsBeforeRequest: Int = 0
    fileprivate var loadingNewMovies: Bool = false
    
    func viewIsReady() {
        view.setupInitialState()
        view.isLoadingMovies(loading: true)
        loadingNewMovies = true
        interactor.requestMoviesList(for: currentPage)
    }
}

// MARK: - MovieListModuleInput

extension MovieListPresenter: MovieListModuleInput {
    
    func onPopController(someData date: String) {
        print("onPopController: " + date)
    }
}

// MARK: - MovieListViewOutput

extension MovieListPresenter: MovieListViewOutput {
    
    func getNumberOfItemsBeforeRequest() -> Int {
        return self.itemsBeforeRequest
    }
    
    func isLoadingNewMovies() -> Bool {
        return loadingNewMovies
    }
    
    func getNextMovies() {
        if currentPage < totalPages {
            loadingNewMovies = true
            currentPage += 1
            itemsBeforeRequest = cellViewModels.count
            interactor.requestMoviesList(for: currentPage)
        }
    }
    
    func numberOfCells() -> Int {
        return cellViewModels.count
    }
    
    func cellViewModel(index indexPath: IndexPath) -> MovieModel {
        return cellViewModels[indexPath.row]
    }
    
    func resetMovies() {
        cellViewModels.removeAll()
        currentPage = 1
        view.updateMoviesList()
        view.isLoadingMovies(loading: true)
        loadingNewMovies = true
        interactor.requestMoviesList(for: currentPage)
    }
    
    func openMovieDetails(index indexPath: IndexPath) {
        router.showMovieDetailScreen(from: view, for: cellViewModels[indexPath.row])
    }
}

// MARK: - MovieListInteractorOutput

extension MovieListPresenter: MovieListInteractorOutput {
    
    func didRetrieveMovieDetails(_ currentPage: Int, totalPages: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
    }
    
    func didRetrieveMovies(_ movies: [MovieModel]) {
        view.isLoadingMovies(loading: false)
        cellViewModels += movies
        view.updateMoviesList()
        self.loadingNewMovies = false
    }
    
    func onError(_ error: ErrorType) {
        loadingNewMovies = false
        view.isLoadingMovies(loading: false)
        view.showError(error.message)
    }
}
