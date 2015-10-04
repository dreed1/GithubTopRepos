//
//  AppDelegate.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/2/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let viewController = RepoListTableViewController(nibName:"RepoListTableViewController", bundle:nil)
    let nav = UINavigationController(rootViewController: viewController)
    
    let ourWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    ourWindow.rootViewController = nav
    ourWindow.makeKeyAndVisible()
    self.window = ourWindow
    
    return true
  }
}

