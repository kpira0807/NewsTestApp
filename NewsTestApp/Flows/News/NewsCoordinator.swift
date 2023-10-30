import UIKit
import Swinject

final class NewsCoordinator: NavigationNode {
    
    var navigationController: UINavigationController? {
        rootViewController.navigationController
    }
    
    private weak var rootViewController: UIViewController!
    private weak var viewController: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        registerFlow()
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        NewsAssembly(self).assemble(container: container)
        MoreInfoNewsAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension NewsCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let controller: NewsViewController = container.autoresolve(argument: self as NewsNavigationHandler)
        rootViewController = controller
        
        return controller
    }
    
}

extension NewsCoordinator: NewsNavigationHandler {
    
    func newsModelDidRequestToPresentInfo(_ model: NewsModel, urlInfo: String) {
        let controller: MoreInfoNewsViewController = container.autoresolve(arguments: urlInfo, self as MoreInfoNewsNavigationHandler)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension NewsCoordinator: MoreInfoNewsNavigationHandler {}
