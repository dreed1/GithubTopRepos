//
//  Contributor.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/4/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit

class Contributor: NSObject {
  var contributions: Int = 0
  
  var name: String = " "
  
  /**
  initializer for the COntributor model
  
  - parameter jsonBlob: the json blob
  
  - returns: self, a Contributor
  */
  init(jsonBlob: [String: AnyObject]) {
    super.init()
    
    self.populateWithJson(jsonBlob)
  }
  
  /**
  populate the object with a given json blob
  
  - parameter json: the json you want to create the object with
  */
  private func populateWithJson(json: [String: AnyObject]) {
    if let name = json["login"] as? String {
      self.name = name
    }
    
    if let contributions = json["contributions"] as? Int {
      self.contributions = contributions
    }
  }
}
