//
//  ActionViewController.swift
//  Extension
//
//  Created by Bhavin Kapadia on 2022-01-23.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    let alertTitle = "alert(document.title);"
    let alertURL = "alert(document.URL);"

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(preWrittenScript))
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let savedUrl = defaults.url(forKey: "siteURL")!.absoluteString
        print(savedUrl as Any)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else {
                        return
                    }
                     guard let javaScriptValues =
                            itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    self?.defaults.set(self?.pageURL, forKey: "siteURL")

                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let arguement: NSDictionary = ["customJavaScript": script.text]
        let webDictionary:NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: arguement]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])

    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    
    @objc func preWrittenScript() {
        let ac = UIAlertController(title: "Select Script", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Title Alert", style: .default, handler: titleAlert))
        ac.addAction(UIAlertAction(title: "URL Alert", style: .default, handler: URLAlert))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    func titleAlert(action: UIAlertAction) {
        
        let item = NSExtensionItem()
        let arguement: NSDictionary = ["customJavaScript": alertTitle]
        let webDictionary:NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: arguement]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        return
    }
    
    
    func URLAlert(action: UIAlertAction) {
        
        let item = NSExtensionItem()
        let arguement: NSDictionary = ["customJavaScript": alertURL]
        let webDictionary:NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: arguement]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        return
    }
    
    
    
}
