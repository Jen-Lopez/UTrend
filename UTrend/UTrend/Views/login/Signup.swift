//
//  Signup.swift
//  UTrend
//
//  Created by Ashley Sidoryk on 4/19/20.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class Signup: UIViewController, GIDSignInDelegate {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var emailsu: UITextField!
    
    @IBOutlet weak var usernamesu: UITextField!
    
    @IBOutlet weak var passwordsu: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var googleSignUp: GIDSignInButton!
    
    @IBOutlet weak var errorsu: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        // cursor hides when touched outside input field
        dismissCursor()
        // hide password
        passwordsu.isSecureTextEntry = true
    }    

    func dismissCursor() {
        let tapRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboard() {
      view.endEditing(true)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let testingPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return testingPassword.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailCorrect = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let testingEmail = NSPredicate(format:"SELF MATCHES %@", emailCorrect)
            return testingEmail.evaluate(with: email)
    }
    
    func validateFields() -> String? {
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernamesu.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailsu.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordsu.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let givenEmail = emailsu.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isEmailValid(givenEmail) == false {
            return "Please enter a valid email."
        }
        
        
        let givenPassword = passwordsu.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(givenPassword) == false {
            return "Please enter a password with at least 8 characters, a special character, and a number."
            
        }
        
        return nil
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            
            let firstname = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userName = usernamesu.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailsu.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordsu.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    self.showError("Error occured when creating user")
                }
                else {
                    //User created and now need to store the info
                    //Need to add auth pods and decide which database to use
                    
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(["firstname": firstname, "username": userName, "uid": result!.user.uid, "profileImgURL":""])
                    
                    self.transitionToProfile()
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorsu.text = message
        }
    
    func transitionToProfile () {
        let main = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar
        self.navigationController?.pushViewController(main!, animated: true)
    }
    
    
    @IBAction func googleSpressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      
      if let error = error {
        self.errorsu.text = error.localizedDescription
          
          return
      }
      
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      
      Auth.auth().signIn(with: credential) { (authResult, error) in
          
          if let error = error {
              self.errorsu.text = error.localizedDescription
          }
          else {
              self.errorsu.text = "Login Successful."
            let main = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar
            self.navigationController?.pushViewController(main!, animated: true)
          }
      }
      
    }

}
