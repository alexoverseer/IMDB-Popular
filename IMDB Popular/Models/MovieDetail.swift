import Foundation

struct MovieDetailModel: Codable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let movieID: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage
        case movieID = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct BelongsToCollection: Codable {
    let collectionID: Int
    let backdropPath: String?
    let posterPath: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case collectionID = "id"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case name
    }
}

struct Genre: Codable {
    let genreID: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case genreID = "id"
    }
}

struct ProductionCompany: Codable {
    let companyID: Int
    let logoPath: String?
    let name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case companyID = "id"
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let identifier, name: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let identifier, name: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "iso_639_1"
        case name
    }
}
