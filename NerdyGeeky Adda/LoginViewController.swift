//
//  LoginViewController.swift
//  NerdyGeeky Adda
//
//  Created by Nasir Uddin on 28/01/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
class LogInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
    }

    
    
    @IBOutlet weak var anonymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // anonymousButton:
        // Set boder color and width
        anonymousButton.layer.borderWidth = 2.0
        anonymousButton.layer.borderColor = UIColor.white.cgColor
        GIDSignIn.sharedInstance().clientID = "54069862024-35dhsb9iubfj0g53at1m1ke4n0glp1qh.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(FIRAuth.auth()?.currentUser as Any)
        
        // google's firbase authintication method
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth: FIRAuth, user: FIRUser?) in
            print("test3")
            if user != nil {
                print(user as Any)
                Helper.helper.switchToNavigationViewController()
            } else {
                print("Unauthorized")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAnonymouslyDidTapped(_ sender: Any) {
        print("login anonymously did tapped")
        // Anonymously log users in
        // switch view by setting navigation controller as root view controller
        Helper.helper.loginAnonymously()
    }
    
    @IBAction func googleLoginDidTapped(_ sender: Any) {
        print("google login did tapped")
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        Helper.helper.logInWithGoogle(authentication: user.authentication)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
