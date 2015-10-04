//
//  WebViewController.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/3/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  @IBOutlet var webView: UIWebView?
  
  var url: String = ""
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.webView!.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
  }
}
