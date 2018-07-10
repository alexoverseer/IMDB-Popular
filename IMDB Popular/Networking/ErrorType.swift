import Foundation

enum ErrorType: Error {
    case undefined
    case connection
    case request(Error?)
    case responseParse
    
    var message: String {
        switch self {
        case .undefined, .request, .responseParse: return "Something went wrong"
        case .connection: return "Seems you don't have internet connection"
        }
    }
}
