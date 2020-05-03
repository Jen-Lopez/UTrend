//
//  postInfo.swift
//  UTrend

import UIKit
import Firebase

class postInfo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imgName : String = ""
    
    let statusBar: UIImageView = {
        let sb = UIImageView()
        sb.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        return sb
    }()

    let caption : UITextView = {
        let cap = UITextView()
        cap.backgroundColor =  UIColor(red: (246/255.0), green: (242/255.0), blue: (235/255.0), alpha: 1.0)
        cap.layer.cornerRadius = 10
        cap.layer.masksToBounds = true
        cap.textColor = UIColor(red: (112/255.0), green: (112/255.0), blue: (112/255.0), alpha: 1.0)
        cap.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        cap.textAlignment = .center
        cap.font = UIFont(name: "Verdana", size: 16)

        return cap
    }()
    
    let postImg : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: (216/255.0), green: (200/255.0), blue: (199/255.0), alpha: 1.0)
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        return img
    }()
    
    let headline : UILabel = {
        let text = UILabel()
        text.text = "Post"
        text.font! = UIFont(name: "Verdana", size: 40)!
        text.sizeToFit()
        text.textColor = UIColor(red: (164/255.0), green: (111/255.0), blue: (111/255.0), alpha: 1.0)
        text.backgroundColor = UIColor(red: (249/255.0), green: (246/255.0), blue: (241/255.0), alpha: 1.0)
        text.textAlignment = .center
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true

        return text
    }()
    
    let submit : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor(red: (131/255.0), green: (113/255.0), blue: (113/255.0), alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: (225/255.0), green: (202/255.0), blue: (200/255.0), alpha: 1.0)
        button.layer.cornerRadius = 5
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 16)
        button.addTarget(self, action:#selector(addToDB), for: .touchUpInside)
        return button
    }()
    
    @objc func getPicture () {
        // open up imagepicker
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func addToDB(_ sender: UIButton) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        
        let socialRef = db.collection("socialFeed")
        let userRef = db.collection("users").document(user!)
        
        if caption.text != "" && imgName != "" {
            // add to user feed
            userRef.collection("posts").addDocument(data: ["caption": caption.text!,"postImg": imgName,"likes":0,"timestamp":"1 day ago"])
            
            // add to social feed db
            userRef.getDocument { (doc, err) in
                if err == nil {
                    let data = doc!.data()
                    let profImg = data!["profileImg"] as? String
                    let username = data!["username"] as? String
                    
                    socialRef.addDocument(data: ["caption": self.caption.text!,"postImg":self.imgName,"profImg":profImg!,"likes":0,"username":username!,"timestamp": "1 day ago"])
                }
            }

            // show success alert
            let success = UIAlertController(title: "Success!", message: "Thanks for posting", preferredStyle: .alert)
            let okay  = UIAlertAction(title: "Ok", style: .default, handler: nil)
            success.addAction(okay)
            self.present(success, animated: true, completion: nil)
        } else {
            print("do not add to db")
            // present an alert
            let alert = UIAlertController(title: "Sorry!", message: "Make sure you upload an Image and add a caption.", preferredStyle: .alert)
            let okay  = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // IMAGE PICKER -- SET PROFILE PICTURE
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          var selectedImg : UIImage?
          if let edited = info[.editedImage] {
              selectedImg = edited as? UIImage
          } else if let original = info[.originalImage] {
              selectedImg = original as? UIImage
          }
          
          if let selected = selectedImg {
            postImg.image = selected
            // upload image to Firebase
            let imgData = selected.jpegData(compressionQuality: 0.4)
            imgName = UUID().uuidString
            let ref  = Storage.storage().reference().child("social").child(imgName)
            ref.putData(imgData!, metadata: nil) { (meta, err) in
                   if err != nil {return}
            }
//              db.collection("users").document(user!).setData([ "profileImg": imgName], merge: true)
          }
          dismiss(animated: true, completion: nil)
        print (" the image name is \(imgName)")
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = UIColor(red: (229/255.0), green: (218/255.0), blue: (217/255.0), alpha: 1.0)

        // add grey status bar
       view.addSubview(statusBar)
       statusBar.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 60)
        // add post title
        view.addSubview(headline)
        headline.anchor(top: statusBar.bottomAnchor, paddingTop: 30,width: 130,height: 65)
        headline.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // add image view
        view.addSubview(postImg)
        postImg.anchor(top: headline.bottomAnchor, paddingTop: 50, width: view.frame.width-100, height: 300)
        postImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // click on imgview to get picture
        postImg.isUserInteractionEnabled = true
        postImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getPicture)))
        
        // add comment view
        view.addSubview(caption)
        caption.anchor(top: postImg.bottomAnchor, paddingTop: 40, width: 280, height: 130)
        caption.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // add button
        view.addSubview(submit)
        submit.anchor(top: caption.bottomAnchor,paddingTop: 40, width: 100, height: 40)
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // hide cursor
        dismissCursor()
        
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
    
}
