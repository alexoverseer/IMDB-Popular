import Foundation
import Kingfisher

struct ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    
    private init() {}
    
    // MARK: - Public
    
    func fetchImage(with imageUrl: String, completion: @escaping (UIImage?) -> Void) {

        if checkImageCache(with: imageUrl) {
            fetchImageFromCache(with: imageUrl, completion: { (image: Image?) in
                completion(image)
            })
            
            return
        }
        
        download(from: imageUrl) { (image: Image?) in
            if let image = image {
                self.saveImageToDisk(with: image, key: imageUrl)
                completion(image)
                return
            }
            
            completion(nil)
        }
    }
    
    // MARK: - Private
    
    private func checkImageCache(with key: String) -> Bool {
        return ImageCache.default.imageCachedType(forKey: key).cached
    }
    
    private func fetchImageFromCache(with key: String, completion: @escaping (Image?) -> Void) {
        ImageCache.default.retrieveImage(forKey: key, options: nil) { image, _ in
            completion(image)
        }
    }
    
    private func download(from imageUrl: String, completion: @escaping (Image?) -> Void) {
        ImageDownloader.default.downloadImage(with: URL(string: imageUrl)!, options: [], progressBlock: nil) { (image, _, _, _) in
            completion(image)
        }
    }
    
    private func saveImageToDisk(with image: Image, key: String) {
        ImageCache.default.store(image, forKey: key)
    }
    
}
