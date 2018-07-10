import Foundation

struct DetailModel: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

struct MovieModel: Codable {
    let voteCount: Int
    let movieID: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case movieID = "id"
        case video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
