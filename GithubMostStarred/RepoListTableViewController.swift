//
//  RepoListTableViewController.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/2/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit

class RepoListTableViewController: UITableViewController {
  
  var repositories = [Repo]()
        
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.registerNib(
      UINib(nibName: "RepositoryTableViewCell", bundle: nil),
      forCellReuseIdentifier: kRepositoryCellReuseIdentifier
    )
    NetworkManager.getTopRepositories({ (response) -> Void in
      if let items = response["items"] as? [AnyObject] {
        for item in items {
          if let repository = item as? [String: AnyObject] {
            self.repositories.append(
              Repo(jsonBlob: repository)
            )
            self.tableView.reloadData()
          }
        }
      }
      }) { (error) -> Void in
        print("error: \(error)")
    }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return repositories.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(kRepositoryCellReuseIdentifier, forIndexPath: indexPath)
    
    if let c = cell as? RepositoryTableViewCell {
      let repo = self.repositories[indexPath.row]
      c.populateWithRepo(repo)
    }

    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let webViewController = WebViewController(nibName:"WebViewController", bundle:nil)
    let repo = self.repositories[indexPath.row]
    webViewController.url = repo.html_url
    self.navigationController?.pushViewController(
      webViewController, animated: true
    )
  }
}
