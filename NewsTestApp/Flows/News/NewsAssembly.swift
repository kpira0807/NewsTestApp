import Swinject
import UIKit

final class NewsAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(NewsViewController.self) { (resolver, navigationHandler: NewsNavigationHandler) in
            let model = NewsModel(navigationHandler: navigationHandler)
            let viewModel = NewsViewModel(model: model)
            let controller = NewsViewController(viewModel: viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
