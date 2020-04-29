//
//  Login.swift
//  UTrend
//
//  Created by Ashley Sidoryk on 4/19/20.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class Login: UIViewController, GIDSignInDelegate {
    
    
    @IBOutlet weak var emailli: UITextField!
    
    @IBOutlet weak var passwordli: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var googleLogIn: GIDSignInButton!
    
    @IBOutlet weak var errorli: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        
        // cursor hides when touched outside input field
        let tapRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboard() {
      view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let testingPassword = NSPredicate(format: "SELF MATCHES %@", "^(?+.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return testingPassword.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailCorrect = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let testingEmail = NSPredicate(format:"SELF MATCHES %@", emailCorrect)
            return testingEmail.evaluate(with: email)
    }
    
    func validateFields() -> String? {
        
        if  emailli.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordli.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let givenEmail = emailli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isEmailValid(givenEmail) == false {
            return "Please enter a valid email."
        }
        
        
        let givenPassword = passwordli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(givenPassword) == false {
            return "Please enter a password with at least 8 characters, a special character, and a number."
            
        }
        
        return nil
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        let email = emailli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            if err != nil {
                self.errorli.text = err!.localizedDescription
            }
            else{
                let main = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar
                self.navigationController?.pushViewController(main!, animated: true)
            }
        }
    }
        
    @IBAction func googleLPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      
      if let error = error {
        self.errorli.text = error.localizedDescription
          
          return
      }
      
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      
      Auth.auth().signIn(with: credential) { (authResult, error) in
          
          if let error = error {
              self.errorli.text = error.localizedDescription
          }
          else {
              self.errorli.text = "Login Successful."
            let main = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar
            self.navigationController?.pushViewController(main!, animated: true)
          }
      }
      
    }
    

}
