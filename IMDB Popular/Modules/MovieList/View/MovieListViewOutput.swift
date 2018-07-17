import Foundation

protocol MovieListViewOutput {
    func viewIsReady()
    func getNextMovies()
    func numberOfCells() -> Int
    func cellViewModel(index indexPath: IndexPath) -> MovieModel
}
