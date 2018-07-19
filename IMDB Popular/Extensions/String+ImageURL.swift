import Foundation

extension String {
    
    enum ImageQuality: Int {
        case low = 200, medium = 350, high = 500
    }
    
    func getImageURL(quality imageQuality: ImageQuality) -> String {
        return "https://image.tmdb.org/t/p/w\(imageQuality.rawValue)\(self)"
    }
}
