import Foundation
import UIKit
import Combine

final class NewsViewModel {
    
    var requestState: AnyPublisher<RequestState, Never> {
        model.requestState.eraseToAnyPublisher()
    }
    
    var reloadInfoData: AnyPublisher<Void, Never> {
        _reloadInfoData.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var cellViewModels: [NewsCellViewModel] = []
    
    private let model: NewsModel
    private let _reloadInfoData = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: NewsModel) {
        self.model = model
        
        setupBindings()
    }
    
    private func setupBindings() {
        model.reloadInfoData.sink { [weak self] _ in
            guard let self = self else { return }
            
            self.buildCellViewModels()
            self._reloadInfoData.send(())
        }.store(in: &subscriptions)
    }
    
    private func buildCellViewModels() {
        cellViewModels = model.articlesInfo.map { value in
            NewsCellViewModel(
                title: value.title,
                image: value.urlToImage,
                author: value.author,
                publishedAt: value.publishedAt,
                source: value.source.name,
                description: value.description,
                onSelect: { [weak self] in
                    self?.model.showWEBInfo(urlInfo: value.url ?? "https://www.google.com")
                })
        }
    }
    
}
