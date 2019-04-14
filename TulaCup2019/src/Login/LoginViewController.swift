//
//  LoginViewController.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 04/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import UIKit
import WebKit


fileprivate let responseUrl = "/tula2019Cup/login"
let oathUrl = "https://oauth.yandex.ru/authorize?"


class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var web = WKWebView()
    
    var manager: loginHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = web
        web.load(URLRequest(url: URL(string: makeOathUrl())!))
        //web.load(URLRequest(url: URL(string: "google.ru")!))
        web.allowsBackForwardNavigationGestures = true
        web.navigationDelegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        
        if url.absoluteString.contains(AppSettings.getRedirectUrl()) {
            print(url)
            // this means login successful
            decisionHandler(.cancel)
            
            let oath = oathParams(from: url.absoluteString)!
            AppSettings.oath = oath
            
            //manager?.onSuccessAuth()
            _ = self.navigationController?.popViewController(animated: false)
        }
        else {
            decisionHandler(.allow)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
