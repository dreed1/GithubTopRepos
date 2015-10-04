//
//  NetworkManager.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/2/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit
import Alamofire

private let dummyErrorDomain = "SomethingBadHappened"

class NetworkManager: NSObject {
  /**
  call github's api and ask for a list of the top 100 repos sorted by stars
  
  - parameter successCallback: success callback block
  - parameter errorCallback:   error callback block
  */
  class func getTopRepositories(successCallback: ((response: AnyObject) -> Void), errorCallback: ((error: NSError) -> Void)) {
    let starSearchEndpoint = "https://api.github.com/search/repositories"
    
    self.makeRequest(
      starSearchEndpoint,
      params:self.repoRequestParams(),
      successCallback: successCallback,
      errorCallback: errorCallback
    )
  }
  
  /**
  call github and ask them for the top contributor of a given repo
  
  - parameter owner:           the owner of the repository
  - parameter repo:            the repository we're talking about
  - parameter successCallback: success handler block
  - parameter errorCallback:   error handling block
  */
  class func getTopContributor(owner:String, repo:String, successCallback: ((response: AnyObject) -> Void), errorCallback: ((error: NSError) -> Void)) {
    let collaboratorSearchEndpoint = "https://api.github.com/repos/\(owner)/\(repo)/contributors"
    
    self.makeRequest(
      collaboratorSearchEndpoint,
      params:self.contributorRequestParams(),
      successCallback: successCallback,
      errorCallback: errorCallback
    )
  }
  
  /**
  how to make a network request
  
  - parameter url:             the url you want to reach
  - parameter params:          the params you want to hand off
  - parameter successCallback: success handler
  - parameter errorCallback:   failure handler
  */
  private class func makeRequest(
    url:String,
    params:[String: AnyObject]?,
    successCallback: ((response: AnyObject) -> Void),
    errorCallback: ((error: NSError) -> Void)) {
    Alamofire.request(
      .GET,
      url,
      parameters: params)
      .responseJSON { response in
        if let JSON = response.result.value {
          successCallback(response: JSON)
        } else {
          var err = NetworkManager.dummyError()
          if let error = response.result.error {
            err = error
          } else {
            print("Something terrible happened but I don't know what. Plz fix it.")
          }
          errorCallback(error: err)
        }
    }
  }
  
  /**
  request params for the list of most starred repositories
  
  - returns: a hashmap with request params
  */
  private class func repoRequestParams() -> [String: AnyObject] {
    return [
      "sort": "stars",
      "order": "desc",
      "q": "stars:>=1",
      "per_page": "100"
    ]
  }
  
  /**
  request params for the top contributor request
  
  - returns: a hash containing request params
  */
  private class func contributorRequestParams() -> [String: AnyObject] {
    return [
      "sort": "contributions",
      "order": "desc",
      "per_page": "1"
    ]
  }
  
  /**
  defining a dummy error for boilerplate
  
  - returns: an error
  */
  private class func dummyError() -> NSError {
    return NSError(
      domain: dummyErrorDomain,
      code: 12345,
      userInfo: [
        NSLocalizedDescriptionKey: NSLocalizedString("Nah, that didn't work.", comment: "Description of the error"),
        NSLocalizedFailureReasonErrorKey: NSLocalizedString("It's possible someone knows why, but I do not.", comment:"Reason for the error"),
        NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Try again, but do better next time.", comment:"Suggestion for recovery")
      ]
    )
  }
}
