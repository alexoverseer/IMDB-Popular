import Foundation
import Kingfisher

protocol ImageFetcher {
    func fetchImage(with imageUrl: String, completion: @escaping (UIImage?) -> Void)
}

struct ImageDownloadManager: ImageFetcher {
    
    static let shared = ImageDownloadManager()
    
    private init() {}
    
    // MARK: - Public
    
    func fetchImage(with imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        
        if checkImageCache(with: imageUrl) {
            fetchImageFromCache(with: imageUrl, completion: { (image: KFCrossPlatformImage?) in
                completion(image)
            })
            
            return
        }
        
        download(from: imageUrl) { (image: KFCrossPlatformImage?) in
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
    
    private func fetchImageFromCache(with key: String,
                                     completion: @escaping (KFCrossPlatformImage?) -> Void) {
        
        ImageCache.default.retrieveImage(forKey: key) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(nil)
            }
        }
    }
    
    private func download(from imageUrl: String, completion: @escaping (KFCrossPlatformImage?) -> Void) {
        ImageDownloader.default.downloadImage(with: URL(string: imageUrl)!,
                                              options: nil,
                                              progressBlock: nil) { result in
                                                
                                                switch result {
                                                case .success(let imageResult):
                                                    completion(imageResult.image)
                                                case .failure:
                                                    completion(nil)
                                                }
                                                
        }
    }
    
    private func saveImageToDisk(with image: KFCrossPlatformImage, key: String) {
        ImageCache.default.store(image, forKey: key)
    }
}
