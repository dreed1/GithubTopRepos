//
//  RepositoryTableViewCell.swift
//  GithubMostStarred
//
//  Created by Dan Reed on 10/3/15.
//  Copyright © 2015 Dan Reed. All rights reserved.
//

import UIKit
import FontAwesome_swift


let kRepositoryCellReuseIdentifier = "RepositoryTableViewCell"

class RepositoryTableViewCell: UITableViewCell {
  @IBOutlet var repositoryNameLabel: UILabel?
  @IBOutlet var repositoryTopContributorLabel: UILabel?
  
  @IBOutlet var repositoryForksLabel: UILabel?
  @IBOutlet var repositoryStarsLabel: UILabel?
  @IBOutlet var repositoryWatchersLabel: UILabel?
  
  @IBOutlet var forkIcon: UIImageView?
  @IBOutlet var watcherIcon: UIImageView?
  @IBOutlet var starIcon: UIImageView?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  /**
  populate the cell with a given repo
  
  - parameter repo: the Repo object used to populate the view
  */
  func populateWithRepo(repo: Repo) {
    self.setIconImages()
    
    let nameAndDescription = NSMutableAttributedString(string:"\(repo.name) (\(repo.language)) - \(repo.repoDescription)")
    nameAndDescription.addAttribute(
      NSFontAttributeName,
      value: UIFont.boldSystemFontOfSize(16),
      range: NSMakeRange(0,repo.name.characters.count)
    )
    nameAndDescription.addAttribute(
      NSFontAttributeName,
      value: UIFont.systemFontOfSize(16, weight: UIFontWeightLight),
      range: NSMakeRange(repo.name.characters.count + 1, repo.language.characters.count+2)
    )
    nameAndDescription.addAttribute(
      NSFontAttributeName,
      value: UIFont.systemFontOfSize(16),
      range: NSMakeRange(repo.name.characters.count + 6 + repo.language.characters.count, repo.repoDescription.characters.count)
    )
    self.repositoryNameLabel?.attributedText = nameAndDescription
    
    self.repositoryForksLabel?.text = "\(repo.forks)"
    self.repositoryStarsLabel?.text = "\(repo.stars)"
    self.repositoryWatchersLabel?.text = "\(repo.watchers)"
    
    if let topDog = repo.topContributor {
      self.repositoryTopContributorLabel?.text = topDog.name
    } else {
      NetworkManager.getTopContributor(
        repo.owner,
        repo: repo.name,
        successCallback: { [weak self] (response) -> Void in
          if let json = response[0] as? [String: AnyObject] {
            let contributor = Contributor(jsonBlob: json)
            repo.topContributor = contributor
            self?.repositoryTopContributorLabel?.text = contributor.name
          } else {
            print("Something bad happened, couldn't make the top contributor")
          }
        }) { (error) -> Void in
          print("\(error)")
      }

    }
  }
  
  /**
  set the icons
  */
  private func setIconImages() {
    let iconSize = CGSizeMake(16, 16)
    
    let starImage = UIImage.fontAwesomeIconWithName(
      FontAwesome.Star,
      textColor: UIColor.blackColor(),
      size: iconSize
    )
    starIcon?.image = starImage
    
    let watcherImage = UIImage.fontAwesomeIconWithName(
      FontAwesome.Eye,
      textColor: UIColor.blackColor(),
      size: iconSize
    )
    watcherIcon?.image = watcherImage
    
    let forkImage = UIImage.fontAwesomeIconWithName(
      FontAwesome.CodeFork,
      textColor: UIColor.blackColor(),
      size: iconSize
    )
    forkIcon?.image = forkImage
  }
}
