//
//  MainViewController.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-11-26.
//

import WebKit
import UIKit

class MapViewController: UIViewController, WKNavigationDelegate
{
    var webView: WKWebView = WKWebView()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        webView.navigationDelegate = self
        view = webView
    }

    override func viewWillAppear(_ animated: Bool)
    {
        let url = URL(string: "https://bing.com/maps/default.aspx?cp=43.6532~-79.3832")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
