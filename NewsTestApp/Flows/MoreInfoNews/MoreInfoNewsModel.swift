import Foundation

protocol MoreInfoNewsNavigationHandler {}

final class MoreInfoNewsModel {
    
    let url: String
    
    private let navigationHandler: MoreInfoNewsNavigationHandler
    
    init(
        url: String,
        navigationHandler: MoreInfoNewsNavigationHandler
    ) {
        self.url = url
        self.navigationHandler = navigationHandler
    }
    
}


