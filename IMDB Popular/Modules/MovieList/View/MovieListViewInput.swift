import Foundation

protocol MovieListViewInput: class {
    func setupInitialState()
    func updateMoviesList()
    func showError(_ errorMessage: String)
}
