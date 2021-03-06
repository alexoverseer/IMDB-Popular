import Foundation

protocol MovieListViewOutput {
    func viewIsReady()
    func getNextMovies()
    func numberOfCells() -> Int
    func cellViewModel(index indexPath: IndexPath) -> MovieModel
    func isLoadingNewMovies() -> Bool
    func resetMovies()
    func openMovieDetails(index indexPath: IndexPath)
    func getNumberOfItemsBeforeRequest() -> Int
}
