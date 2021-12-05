import UIKit

public protocol ImageLoaderProtocol {
    static func loadImageFromURL(_ url: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

public class ImageLoader: ImageLoaderProtocol {
    
    static public func loadImageFromURL(_ url: String, completion: @escaping (Result<UIImage, Error>) -> ())  {
        guard let imageURL = URL(string: url) else { return }
        
        let request = URLRequest(url: imageURL)
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 0 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024, diskPath: nil)
        let urlSession = URLSession(configuration: configuration)
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(.success(image))
        }
        dataTask.resume()
    }
    
}

extension UIImageView {
    
    public func loadByURL(_ url: String) {
        ImageLoader.loadImageFromURL(url) { result in
            switch result {
            case .success(let image):
                
                let thumbImage = image.getThumbnail()
                
                DispatchQueue.main.async {
                    self.image = thumbImage
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



extension UIImage {

  func getThumbnail() -> UIImage? {

    guard let imageData = self.pngData() else { return nil }

    let options = [
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary

    guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
    guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

    return UIImage(cgImage: imageReference)

  }
}
