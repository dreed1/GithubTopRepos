//
//  Repo.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/2/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit

class Repo: NSObject {
  var repoDescription: String = " "
  var html_url: String = " "
  var name: String = " "
  var language: String = " "
  
  var forks: Int = 0
  var stars: Int = 0
  var watchers: Int = 0

  var owner: String = ""
  
  var topContributor: Contributor?
  
  /**
  init
  
  - parameter jsonBlob: the json blob from the API you're using to create the object
  
  - returns: self, a Repository
  */
  init(jsonBlob: [String: AnyObject]) {
    super.init()
    
    self.populateWithJson(jsonBlob)
  }
  
  /**
  populate our object from a given json blob
  
  - parameter json: the json that comes back from the API
  */
  private func populateWithJson(json: [String: AnyObject]) {
    if let desc = json["description"] as? String {
      self.repoDescription = desc
    }
    if let url = json["html_url"] as? String {
      self.html_url = url
    }
    if let name = json["name"] as? String {
      self.name = name
    }
    if let language = json["language"] as? String {
      self.language = language
    }
    
    if let owner = json["owner"] as? [String: AnyObject] {
      if let login = owner["login"] as? String {
        self.owner = login
      }
    }
    
    if let forks = json["forks"] as? Int {
      self.forks = forks
    }
    if let stars = json["stargazers_count"] as? Int {
      self.stars = stars
    }
    if let watchers = json["watchers_count"] as? Int {
      self.watchers = watchers
    }
  }
}
