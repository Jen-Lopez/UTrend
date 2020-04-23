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

class Login: UIViewController {
    
    
    @IBOutlet weak var emailli: UITextField!
    
    @IBOutlet weak var passwordli: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorli: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //TODO: IMPLEMENT VALIDATION HERE TOO
    
    @IBAction func loginPressed(_ sender: Any) {
        
        let email = emailli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordli.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            if err != nil {
                self.errorli.text = err!.localizedDescription
            }
            else{
                //transition to profile screen code
            }
        }
    }
    
    //MAKE GOOGLE BUTTON ACTION
    

}
