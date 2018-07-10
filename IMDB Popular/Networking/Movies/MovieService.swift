import Foundation

protocol MoviesProtocol {
    func requestMovies(page: Int?, onSuccess: @escaping (DetailModel) -> Void, onFailure: @escaping (ErrorType) -> Void)
    func requestMovieDetails(movie: MovieModel, onSuccess: @escaping (MovieDetailModel) -> Void, onFailure: @escaping (ErrorType) -> Void)
}

struct MovieService: MoviesProtocol {
    
    func requestMovies(page: Int?, onSuccess: @escaping (DetailModel) -> Void, onFailure: @escaping (ErrorType) -> Void) {
        let onRequestSuccess: (Any?) -> Void = { response in
            guard let stringResponse = response as? String,
                let jsonData = stringResponse.data(using: .utf8) else {
                    return onFailure(.responseParse)
            }
            do {
                let movies = try JSONDecoder().decode(DetailModel.self, from: jsonData)
                onSuccess(movies)
            } catch let error {
                print(error)
                onFailure(.responseParse)
            } 
        }
        
        let inputs = RequestInputs(params: ["page": page ?? 1],
                                   path: "movie/popular",
                                   method: .get,
                                   onSuccess: onRequestSuccess,
                                   onFailure: onFailure)
        _ = Request(inputs: inputs, encoding: .string)
    }
    
    func requestMovieDetails(movie: MovieModel, onSuccess: @escaping (MovieDetailModel) -> Void, onFailure: @escaping (ErrorType) -> Void) {

        let onRequestSuccess: (Any?) -> Void = { response in
            guard let stringResponse = response as? String,
                let jsonData = stringResponse.data(using: .utf8) else {
                    return onFailure(.responseParse)
            }
            
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetailModel.self, from: jsonData)
                onSuccess(movieDetails)
            } catch let error {
                print(error)
                onFailure(.responseParse)
            }
        }

        let path = "movie/" + "\(movie.movieID)"
        let inputs = RequestInputs(path: path, method: .get, onSuccess: onRequestSuccess, onFailure: onFailure)
        _ = Request(inputs: inputs, encoding: .string)
    }
}
