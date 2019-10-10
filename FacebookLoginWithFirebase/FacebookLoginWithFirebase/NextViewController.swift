//
//  NextViewController.swift
//  FacebookLoginWithFirebase
//
//  Created by 長坂豪士 on 2019/10/10.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit
import SDWebImage

class NextViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "pictureURLString") != nil || (UserDefaults.standard.object(forKey: "displayName") != nil) {
            
            let imageString = UserDefaults.standard.object(forKey: "pictureURLString") as! String
            
            profileImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            
            profileImageView.layer.cornerRadius = 20.0
            
            let displayName = UserDefaults.standard.object(forKey: "displayName") as! String
            
            userNameLabel.text = displayName
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
