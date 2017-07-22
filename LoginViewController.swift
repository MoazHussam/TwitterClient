//
//  LoginViewController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/18/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        installTwitterLoginButton()
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func installTwitterLoginButton() {
        
        let logInButton = TWTRLogInButton(logInCompletion: { [weak self] session, error in
            
            if let session  = session {
                print("signed in as \(session.userName)")
                NotificationCenter.default.post(Constants.Notifications.userLoggedIn)
                self?.lunchHomeViewController()
            } else if let error = error {
                print("error: \(error.localizedDescription)");
            } else {
                fatalError("Unexpected behaviour, Twitter SDK may be corrupted")
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }
    
    func lunchHomeViewController() {
        
        DispatchQueue.main.async {
            let rootVC = (UIApplication.shared.delegate as! AppDelegate).rootViewController
            self.present(rootVC, animated: true, completion: nil)
        }
        
    }

}
