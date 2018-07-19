import Foundation

protocol MovieDetailInteractorInput {
    func requestMovieDetails(for movie: MovieModel)
    func requestMoviePoster(for movie: MovieDetailModel?)
    func requestMoviePosterThumbnail(for movie: MovieDetailModel?)
}
