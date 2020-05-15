//  AddImage.swift
//  UTrend

import Foundation
import UIKit
import Firebase

class AddImage : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var shoesButton: UIButton!

    var clothingType: String!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit

        viewForImage.layer.cornerRadius = 10
        viewForImage.layer.masksToBounds = true

        imagePicker.delegate = self
    }

    @IBAction func selectImage(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        present(imagePicker, animated:true, completion:nil)
       }

    // camera function
    @IBAction func takePhoto(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                imagePicker.cameraCaptureMode = .photo
                imagePicker.modalPresentationStyle = .fullScreen
                present(imagePicker, animated: true, completion:nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Camera is unavailable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

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
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
        self.clothingType = "top"
        resetColors()
        sender.backgroundColor = UIColor(red: (255/255.0), green: (244/255.0), blue: (243/255.0), alpha: 1.0)
    }

    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        self.clothingType = "bottom"
        resetColors()
        sender.backgroundColor =  UIColor(red: (255/255.0), green: (244/255.0), blue: (243/255.0), alpha: 1.0)
    }

    @IBAction func shoesButtonPressed(_ sender: UIButton) {
        self.clothingType = "shoes"
        resetColors()
        sender.backgroundColor =  UIColor(red: (255/255.0), green: (244/255.0), blue: (243/255.0), alpha: 1.0)
    }
    // resets button colors
    func resetColors() {
        let defaultColor = UIColor(red: (248/255.0), green: (238/255.0), blue: (230/255.0), alpha: 1.0)
        topButton.backgroundColor = defaultColor
        bottomButton.backgroundColor = defaultColor
        shoesButton.backgroundColor = defaultColor
    }

    //using clothingType, determine type and add to closet
    @IBAction func addToCloset(_ sender: UIButton) {
        var type: String = ""

        var shouldUpload : Bool = false
        
        let placeholder = UIImage(named: "playstore-icon")?.pngData()
        let currImg = imageView.image?.pngData()
        // make sure img isn't placeholder
        if (placeholder != currImg) {
            if clothingType == "top" {
              print("top")
              type = "top"
              shouldUpload = true
            } else if clothingType == "bottom" {
              print("bottom")
              type = "bottom"
              shouldUpload = true
            } else if clothingType == "shoes" {
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

        // refresh outfit generator data
        let outVC = self.tabBarController!.viewControllers![2] as! OutfitGenerator
        outVC.refreshAll()
        // refresh wardrobe collection in profile
        let profVC = self.tabBarController!.viewControllers![0] as! Profile
        let wardrobeFeed = profVC.profileView.cellForItem(at: IndexPath(item: 2, section: 0)) as? wardrobeFeed
        if (wardrobeFeed != nil) {wardrobeFeed!.fetchData()}
            
        // success & reset content
            let success = UIAlertController(title: "Added", message: "Successfully added your item.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (alert) in
                // reset image
                self.imageView.image = UIImage(named: "playstore-icon")
                // reset buttons
                self.resetColors()
            }
            success.addAction(action)
            present(success, animated: true, completion: nil)
    
        }
    }
}
