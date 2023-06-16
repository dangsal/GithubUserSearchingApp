//
//  WebViewController.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/16.
//

import UIKit
import WebKit

import Then


final class WebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - ui compoent
    
    private lazy var webView: WKWebView = WKWebView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.navigationDelegate = self
    }
    
    // MARK: - property
    
    private let url: URL
    
    // MARK: - init
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.requestUrl()
    }
    
    // MARK: - func
    
    private func setupLayout() {
        self.view.addSubview(self.webView)
        self.webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func requestUrl() {
        let request = URLRequest(url: self.url)
        self.webView.load(request)
    }
}
