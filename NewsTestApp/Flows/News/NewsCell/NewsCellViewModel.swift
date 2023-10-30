import Foundation
import UIKit

final class NewsCellViewModel {
    
    let title: String
    let image: String
    let author: String
    let publishedAt: String
    let source: String
    let description: String
    let onSelect: () -> Void
    
    init(
        title: String?,
        image: String?,
        author: String?,
        publishedAt: String,
        source: String?,
        description: String?,
        onSelect: @escaping () -> Void
    ) {
        self.title = title ?? ""
        self.image = image ?? ""
        self.author = author ?? ""
        self.publishedAt = publishedAt
        self.source = source ?? ""
        self.description = description ?? ""
        self.onSelect = onSelect
    }
    
}
