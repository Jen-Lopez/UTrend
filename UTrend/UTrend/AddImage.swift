//
//  AddImage.swift
//  UTrend
//

import Foundation
import UIKit

class AddImage : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        textField.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        //let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        //imagePicker.delegate = self
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
           } else {
            return
           }
           
        imageView.image = newImage
        picker.dismiss(animated: true, completion: nil)
           
        print("info from img picker: \(info)")
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
        //get text from text field
        var text: String? = textField.text
        var type: String
        

        if text?.contains("top") ?? false { //is top, add to top array
            print("top")
            type = "top"
        } else if text?.contains("bottom") ?? false { //is bottom, add to bottom array
            print("bottom")
            type = "bottom"
        } else if text?.contains("shoes") ?? false { //is shoes, add to shoes array
            print("shoes")
            type = "shoes"
        }
        
        //else maybe show an alert? do not add
        else {
            //alert
            
        }
        
    }
    
    
    
    
}


