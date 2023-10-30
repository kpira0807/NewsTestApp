import Foundation
import UIKit
import SnapKit
import Combine
import WebKit

final class MoreInfoNewsViewController: NiblessViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView = WKWebView()
    
    private let viewModel: MoreInfoNewsViewModel
    
    init(viewModel: MoreInfoNewsViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.navigationDelegate = self
        
        setupViews()
        loadWeb(viewModel.url)
    }
    
    private func loadWeb(_ webURL: String) {
        let url = URL(string: webURL)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}

extension MoreInfoNewsViewController {
    
    private func setupViews() {
        view.addSubview(webView)
        webView.accessibilityIdentifier = "webView"
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
