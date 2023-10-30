import Foundation
import UIKit

final class MoreInfoNewsViewModel {
    
    var url: String {
        model.url
    }
    
    private let model: MoreInfoNewsModel
    
    init(model: MoreInfoNewsModel) {
        self.model = model
    }
    
}
