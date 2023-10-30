import Swinject
import UIKit

final class MoreInfoNewsAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(MoreInfoNewsViewController.self) { (resolver,
                                                               url: String,
                                                               navigationHandler: MoreInfoNewsNavigationHandler) in
            let model = MoreInfoNewsModel(url: url, navigationHandler: navigationHandler)
            let viewModel = MoreInfoNewsViewModel(model: model)
            let controller = MoreInfoNewsViewController(viewModel: viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
