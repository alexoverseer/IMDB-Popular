import Foundation

protocol MovieListViewInput: class {
    func setupInitialState()
    func updateMoviesList()
    func showError(_ errorMessage: String)
    func isLoadingMovies(loading status: Bool)
}
