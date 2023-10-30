import Foundation
import UIKit

class ImageView: UIImageView {
    
    func set(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cacheResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.image = UIImage(data: data)
                    self.handleLoadImage(data: data, response: response )
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cahedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cahedResponse, for: URLRequest(url: responseURL))
    }
    
}
