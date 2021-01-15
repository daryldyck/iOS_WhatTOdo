//
//  MainViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-26.
//

import WebKit
import UIKit

class WebViewController: UIViewController, WKNavigationDelegate
{
    var webView: WKWebView = WKWebView()
    var urlString: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let url = URL(string: urlString!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
