//
//  ViewController.swift
//  FacebookLoginWithFirebase
//
//  Created by 長坂豪士 on 2019/10/09.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import Firebase


class ViewController: UIViewController, LoginButtonDelegate {

    
    let fbLoginButton:FBLoginButton = FBLoginButton()
    var displayName = String()
    var pictureURL = String()
    var pictureURLString = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        fbLoginButton.frame = CGRect(x: view.frame.size.width/2 - view.frame.size.width/4, y: view.frame.size.height/4, width: view.frame.size.width/2, height: 30)
        // 何を許可するのか
        fbLoginButton.permissions = ["public_profile, email"]
        view.addSubview(fbLoginButton)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再表示した際に上のバーのところを消す
        navigationController?.isNavigationBarHidden = true
        
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error == nil {
            
            if result?.isCancelled == true {
                
                return
            }
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (result, error) in
            
            // 49行目とおなじ意味
            if let error = error {
                
                return
            }
            
            self.displayName = result!.user.displayName!
            self.pictureURLString = result!.user.photoURL!.absoluteString
            // そのままだと画像が小さいので大きくするためにURLをいじる
            self.pictureURLString = self.pictureURLString + "?type=large"
            
            UserDefaults.standard.set(1, forKey: "loginOK")
            UserDefaults.standard.set(self.displayName, forKey: "displayName")
            UserDefaults.standard.set(self.pictureURLString, forKey: "pictureURLString")
            
            let nextVC = self.storyboard?.instantiateViewController(identifier: "next") as! NextViewController
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            
        }
        
    }
    
    // 盲目的に書く
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        
        return true
    }
    
    // ログアウトした際の処理
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("ログアウトしました！")
    }
    

}

