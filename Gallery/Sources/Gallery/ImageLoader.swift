import UIKit

public protocol ImageLoaderProtocol {
    static func loadImageFromURL(_ url: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

public class ImageLoader: ImageLoaderProtocol {
    
    static public func loadImageFromURL(_ url: String, completion: @escaping (Result<UIImage, Error>) -> ())  {
        guard let imageURL = URL(string: url) else { return }
        
        let request = URLRequest(url: imageURL)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.urlCache = URLCache(memoryCapacity: 5 * 1024 * 1024, diskCapacity: 5 * 1024 * 1024, diskPath: nil)
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
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

