import Foundation
import Combine

protocol NewsNavigationHandler {
    
    func newsModelDidRequestToPresentInfo(
        _ model: NewsModel,
        urlInfo: String
    )
    
}

final class NewsModel {
    
    private let navigationHandler: NewsNavigationHandler
    
    let requestState = CurrentValueSubject<RequestState, Never>(.finished)
    let reloadInfoData = PassthroughSubject<Void, Never>()
    var articlesInfo = [Articles]()
    
    init(navigationHandler: NewsNavigationHandler) {
        self.navigationHandler = navigationHandler
        
        fetchData()
    }
    
    func showWEBInfo(urlInfo: String) {
        navigationHandler.newsModelDidRequestToPresentInfo(self, urlInfo: urlInfo)
    }
    
    private func fetchData() {
        let url = "https://newsapi.org/v2/everything?apiKey=\(APIKeys.NewsApiKey)&q=world&sortBy=publishedAt"
        let urls = URL(string: url)
        
        URLSession.shared.dataTask(with: urls!) { (data, response, error) in
            guard let data = data else { return }
            
            Task {
                do {
                    let decoder = JSONDecoder()
                    let articlesInfos = try decoder.decode(NewsAPI.self, from: data)
                    DispatchQueue.main.async { [self] in
                        let sorted = articlesInfos.articles.sorted(by: {$0.publishedAt > $1.publishedAt})
                        self.articlesInfo.append(contentsOf: sorted)
                        reloadInfoData.send(())
                        requestState.send(.finished)
                    }
                } catch {
                    self.requestState.send(.failed(error))
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
}
