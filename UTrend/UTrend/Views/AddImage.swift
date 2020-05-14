//
//  AddImage.swift
//  UTrend

import Foundation
import UIKit
import Firebase

class AddImage : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var viewForTextField: UIView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        
        viewForImage.layer.cornerRadius = 10
        viewForImage.layer.masksToBounds = true
        viewForTextField.layer.cornerRadius = 10
        viewForTextField.layer.masksToBounds = true
        
        
        imagePicker.delegate = self
        textField.delegate = self
    
        //for keyboard
//        NotificationCenter.default.addObserver(self, selector: #selector(AddImage.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(AddImage.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        dismissCursor() // hides cursor
    }
    
    //move view up so keyboard doesn't cover content
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    //move view back down after keyboard goes away
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    
    @IBAction func selectImage(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        present(imagePicker, animated:true, completion:nil)
       }
       
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = false
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion:nil)
       }
       
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]) {
           
        var newImage: UIImage
           
        if let maybeImage = info[.editedImage] as? UIImage {
            newImage = maybeImage
           } else if let maybeImage = info[.originalImage] as? UIImage {
            newImage = maybeImage
           } else { return }
           
        imageView.image = newImage
        picker.dismiss(animated: true, completion: nil)
        
        //print("info from img picker: \(info)")
    }
       
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //textfield delegate
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
    
    //get contents of textfield, check if top, bottom, shoes
    @IBAction func addToCloset(_ sender: UIButton) {
       
        /*
        let actionTitle = "Are you sure?"
        let actionMessage = "Add to closet?"
        let actionOk = "Add to Closet"
        
        let actionController = UIAlertController(title: actionTitle, message: actionMessage, preferredStyle: .actionSheet)
        let actionOkay = UIAlertAction(title: actionOk, style: .default, handler:nil)
        
        actionController.addAction(actionOkay)
        */

        //get text from text field
        var text: String? = textField.text
        var type: String = ""
        
        var shouldUpload : Bool = false
        

        if text?.contains("top") ?? false { //is top, add to top array
            print("top")
            type = "top"
            shouldUpload = true
        } else if text?.contains("bottom") ?? false { //is bottom, add to bottom array
            print("bottom")
            type = "bottom"
            shouldUpload = true
        } else if text?.contains("shoes") ?? false { //is shoes, add to shoes array
            print("shoes")
            type = "shoes"
            shouldUpload = true
        }
            
        //do not add
        else {
            
            let alertTitle = "Wait!"
            let alertMessage = "Please enter 'top', 'bottom', 'shoes' before adding to closet."
            let alertOk = "OK"
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: alertOk, style: .default, handler: nil)
            
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }
                
        // UPLOAD TO FIREBASE
        if shouldUpload {
            let imgData = imageView.image?.jpegData(compressionQuality: 0.4)
            let user = Auth.auth().currentUser?.uid
            let db = Firestore.firestore()
            let imgN = UUID().uuidString
            let ref = Storage.storage().reference().child("users").child(user!).child("clothes")
            
            ref.child(imgN).putData(imgData!, metadata: nil) { (meta, err) in
                if err != nil {return}
            }
            
            db.collection("users").document(user!).collection("clothes").addDocument(data: ["imgName":imgN,"type":type])
            
        // refresh wardrobe collection
            var outVC = self.tabBarController!.viewControllers![2] as! OutfitGenerator
            outVC.refreshAll()
        }
    }
    
}


