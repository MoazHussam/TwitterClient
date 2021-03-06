//
//  FollowerInfoCollectionViewController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class UserInfoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK - Model

    var tweets: [Tweet]? {
        didSet {
            collectionView?.reloadData()
            collectionViewLayout.invalidateLayout()
        }
    }
    var dataController = UserInfoDataController()
    var user: TwitterUser? {
        didSet {
            self.getTweets()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.registerCellClass(UserInfoCollectionViewCell.self)
        collectionView?.registerHeaderClass(UserInfoViewControllerHeader.self)
        collectionView?.registerFooterClass(UsersViewControllerFooter.self)
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }

    }
    
    // MARK: - CollectionView FlowLayout Delegate
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as UserInfoCollectionViewCell
        let tweet = tweets?[indexPath.item]
        cell.tweet = tweet
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableHeader(forIndexPath: indexPath) as UserInfoViewControllerHeader
            header.user = self.user
            return header
        } else {
            let footer = collectionView.dequeueReusableFooter(forIndexPath: indexPath) as UsersViewControllerFooter
            return footer
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    // MARK: - Helper methods
    
    private func getTweets() {
        
        if let user = self.user {
            dataController.tweets(forUser: user, completion: { [weak self] (error, tweets) in
                
                if let error = error {
                    print("Retreaving tweets failed with error: \(error)")
                    self?.showError(message: "Please try again".localized)
                } else {
                    guard let tweets = tweets else {
                        fatalError("UserInfoDataController class is misconfigured")
                    }
                    self?.tweets = tweets
                }
            })
        } else {
            print("no tweeter is specified")
        }
        
    }
    
    private func showError(message: String) {
        
        let alertController = UIAlertController(title: "Failed to retreive data".localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

    }

}
