//
//  DetailViewController.swift
//  milestone13_15
//
//  Created by Bhavin Kapadia on 2022-01-02.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var detailItems: CountryFact?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItems = detailItems else { return }
        print(detailItems)
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 120%; color: dark-grey; border-style: solid; border-color: blue; } </style>
        </head>
        <body>
        Country: \(detailItems.name) <br>
        
        Capital: \(detailItems.capital) <br>
        
        Currency: \(detailItems.currency)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        let textView = UITextView()
        textView.text = "Hello World"
    }
    
    
    
    
}
