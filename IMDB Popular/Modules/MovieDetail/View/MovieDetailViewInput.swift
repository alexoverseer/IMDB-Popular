import UIKit

protocol MovieDetailViewInput: class {
    func setupInitialState()
    func showError(_ errorMessage: String)
    func didGetCoverImage(_ coverImage: UIImage)
    func didGetPosterImage(_ posterImage: UIImage)
    func isLoadingMovieDetail(loading status: Bool)
    func setupMovieDetails(_ details: MovieDetailModel?)
}
