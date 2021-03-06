//
//  FollowersCollectionViewController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit

class UsersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Model
    
    var followers: [TwitterUser]? {
        didSet {
            self.collectionView?.reloadData()
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    var user: TwitterUser? {
        didSet {
            self.updateData()
        }
    }
    var dataController = UsersDataController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.collectionView!.registerCellClass(UserCollectionViewCell.self)
        self.collectionView!.registerHeaderClass(UsersViewControllerHeader.self)
        self.collectionView!.registerFooterClass(UsersViewControllerFooter.self)
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout".localized, style: .plain, target: self, action: #selector(logOut(sender:)))
        
        NotificationCenter.default.addObserver(forName: Constants.Notifications.userLoggedOut.name, object: nil, queue: nil) { (notification) in
            let rootVC = (UIApplication.shared.delegate as! AppDelegate).rootViewController
            self.present(rootVC, animated: true, completion: nil)
        }

    }
        
    // MARK: - CollectionView Delegate FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as UserCollectionViewCell
        let index = indexPath.item
        let tweeter = followers?[index]
        cell.tweeter = tweeter
        return cell
        
    }
        
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableHeader(forIndexPath: indexPath) as UsersViewControllerHeader
            return header
        } else {
            let footer = collectionView.dequeueReusableFooter(forIndexPath: indexPath) as UsersViewControllerFooter
            return footer
        }
        
    }
    
    // MARK: - CollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let followersDetails = UserInfoViewController(collectionViewLayout: UICollectionViewFlowLayout())
        followersDetails.user = followers?[indexPath.item]
        self.navigationController?.pushViewController(followersDetails, animated: true)
        
    }
    
    // MARK: - Helper Methods
    
    private func updateData() {
        
        dataController.getFollowers(forUser: user) { [weak self] (error, followers) in
            
            if let error = error {
                print("Retreaving followers failed with error: \(error)")
                self?.showError(message: "Please try again".localized)
            } else {
                guard let followers = followers else {
                    fatalError("UsersDataController class is misconfigured")
                }
                
                self?.followers = followers
            
            }
            
        }
        
    }
    
    @objc func logOut(sender: Any) {
        TwitterLoginManager.shared.logOutCurrentUser()
    }
    
    private func showError(message: String) {
        
        let alertController = UIAlertController(title: "Failed to retreive data".localized, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

}
