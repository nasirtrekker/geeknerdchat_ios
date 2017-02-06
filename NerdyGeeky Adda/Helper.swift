//
//  Helper.swift
//  NerdyGeeky Adda
//
//  Created by Nasir Uddin on 06/02/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import GoogleSignIn
import FirebaseDatabase

// this class will handle user login and view switch
// Helper class make the code highly felixible.
// eg., if google stopped firebase we can indetrate others
class Helper {
    static let helper = Helper()
  
    func loginAnonymously() {
        print("login anonymously did tapped")
        // Anonymously log users in
        // switch view by setting navigation controller as root view controller
        
        FIRAuth.auth()?.signInAnonymously(completion: { (anonymousUser: FIRUser?, error: Error?) in
            
            if error == nil {
            } else {
                
            }   
            
        })
        
        
    }
    
    func logInWithGoogle(authentication: GIDAuthentication) {
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }else {
                print(user?.email! as Any)
                print(user?.displayName! as Any)
                print(user?.photoURL! as Any)
                
                let newUser = FIRDatabase.database().reference().child("users").child(user!.uid)
                newUser.setValue(["displayname" : "\(user!.displayName!)", "id" : "\(user!.uid)",
                    "profileUrl": "\(user!.photoURL!)"])
                
                
                self.switchToNavigationViewController()
            }
        })
    }
    
    func switchToNavigationViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
        
    }
    
    
    
    
    
    
}
