//
//  DogInfoViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit
import WebKit

class DogInfoViewController: UIViewController {
    
// MARK: - Private Properties
    private let webView = WKWebView()
    private var dogsInfoURL: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        setupWebView()
        loadURL()
    }
    
}

// MARK: - Public Methods
extension DogInfoViewController {
    
    func getRequst(url: URL?) {
        dogsInfoURL = url
    }

}

// MARK: - Setup Views
extension DogInfoViewController {
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Private Methods
extension DogInfoViewController {
    
    private func loadURL() {
        let request = URLRequest(url: checkLoad())
        webView.load(request)
    }
    
    private func checkLoad() -> URL {
        guard let url = dogsInfoURL else {return URL(string: "http://google.com")!}
        
        return url
    }
}

// MARK: - WKNavigationDelegate Delegate
extension DogInfoViewController: WKNavigationDelegate {
    
}

