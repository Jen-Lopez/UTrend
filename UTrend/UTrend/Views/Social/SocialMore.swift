//  SocialMore.swift
//  UTrend
//  Created by Jennifer Lopez

import UIKit
import Firebase
import FirebaseUI

class SocialMore: UIViewController {
    
    var imageName : String!
    var caption : String!
    var timeStamp : String!
    var numLikes : NSNumber!
    var userPic : String!
    var username : String!
    var id : String!
    var uID : String!

    let postImg :UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 40
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let time : UILabel = {
        let stamp = UILabel()
        stamp.font! = UIFont(name: "Avenir-Book", size: 16)!
        stamp.sizeToFit()
        stamp.textColor = UIColor(red: (161/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
        stamp.textAlignment = .center
        return stamp
    }()
    
    let userImg : UIImageView = {
      let profilePic = UIImageView()
      profilePic.backgroundColor = UIColor(red: (221/255.0), green: (215/255.0), blue: (215/255.0), alpha: 1.0)
      profilePic.layer.masksToBounds = true
      profilePic.layer.cornerRadius = 50/2
      profilePic.contentMode = .scaleAspectFill
      profilePic.clipsToBounds = true
      return profilePic
    }()
    
    let userName : UILabel = {
        let user = UILabel()
        user.textColor = UIColor(red: (212/255.0), green:(170/255.0), blue: (170/255.0), alpha: 1.0)
        user.font! = UIFont(name: "Avenir-Medium", size: 18)!
        user.sizeToFit()
        user.textAlignment = .center
        user.numberOfLines = 1
        return user
    }()
    
    let likeHeart : UIButton = {
        let like = UIButton(type: .system)
        // add image to likes
        like.addTarget(self, action:#selector(changeLike), for: .touchUpInside)
        return like
    }()
    
    let likeHeartImg : UIImageView = {
        let heart = UIImageView()
        return heart
    }()
    
    let likes : UILabel = {
        let like = UILabel()
        like.textColor = UIColor(red: (148/255.0), green: (103/255.0), blue: (103/255.0), alpha: 1.0)
        like.font! = UIFont(name: "Futura-Medium", size: 15)!
        return like
    }()
    
    // when user clicks on like, the post is added to their like feed. Image like also increments
    @objc func changeLike(_ sender: UIButton) {
        // checks if user liked image in order to prevent double like
        let isChanged = likeHeartImg.image?.isEqual(UIImage(named: "fill-likeheart"))
        // if it was like, then it'll "unlike" image
        if (isChanged == true) {
            print ("unlike, should delete")
            if let image = UIImage(named:"likeheart") {
                likeHeartImg.image = image
                let newNum:Int = Int(likes.text!)! - 1
                likes.text = String(newNum)
                // decrement the user's post like
                let userRef = Firestore.firestore().collection("users").document(uID).collection("posts").document(id)
                              userRef.setData(["likes":newNum], merge: true)
                // decrement from social as well
                let socialRef = Firestore.firestore().collection("socialFeed").document(id)
                socialRef.setData(["likes":newNum], merge: true)
                // remove document from user like collection
                let currUser = Auth.auth().currentUser?.uid
                let likeColl = Firestore.firestore().collection("users").document(currUser!).collection("likes").document(id)
                likeColl.delete()
            }
        }
        else {
            print ("LIKE")

            if let image = UIImage(named:"fill-likeheart") {
                likeHeartImg.image = image
                let newNum:Int = Int(likes.text!)! + 1
                likes.text = String(newNum)
                
                // add it to users "likes"
                addImg()
                // increment the like of the original poster's post
                let userRef = Firestore.firestore().collection("users").document(uID).collection("posts").document(id)
                userRef.setData(["likes":newNum], merge: true)
                
                // increment it in the social feed
                let socialRef = Firestore.firestore().collection("socialFeed").document(id)
                socialRef.setData(["likes":newNum], merge: true)
            }
        }
    }

    let comment: UILabel = {
        let com = UILabel()
        com.textColor = UIColor(red: (112/255.0), green: (112/255.0), blue: (112/255.0), alpha: 1.0)
        com.font! = UIFont(name: "Avenir-Book", size: 14)!
        com.sizeToFit()
        com.textAlignment = .center
        com.lineBreakMode = .byWordWrapping
        com.numberOfLines = 0;
        return com
    }()
    
    let saveButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(red: (233/255.0), green: (189/255.0), blue: (189/255.0), alpha: 1.0)
        let img = UIImageView()
        img.image = UIImage(named: "download")
        button.addSubview(img)
        img.anchor(top: button.topAnchor, left: button.leftAnchor, paddingTop: 5, paddingLeft: 15,width: 25, height: 25)
        
        let title = UILabel()
        title.text = "Save"
        button.addSubview(title)
        title.anchor(top: button.topAnchor, left: img.rightAnchor,paddingLeft: 5)
        title.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
        title.textColor = UIColor(red: (164/255.0), green: (111/255.0), blue: (111/255.0), alpha: 1.0)
        title.font! = UIFont(name: "Avenir-Heavy", size: 16)!
        button.layer.cornerRadius = 5
        button.addTarget(self, action:#selector(savePhoto), for: .touchUpInside)
        return button
    }()
    
    let backButton : UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(red: (139/255.0), green: (99/255.0), blue: (99/255.0), alpha: 0.47)
        
        let backB = UIImageView()
        backB.image = UIImage(named: "back")
        button.addSubview(backB)
        backB.anchor(top: button.topAnchor,right: button.rightAnchor, paddingTop: 12, paddingRight: 15 , width: 25, height: 25)
        button.addTarget(self, action:#selector(goBack), for: .touchUpInside)
        return button
    }()
    // goes back to social page
    @objc func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // saves photo to camera roll
    @objc func savePhoto(_ sender: UIButton) {
        let imgData = postImg.image!.pngData()
        let compressed = UIImage(data: imgData!)
        UIImageWriteToSavedPhotosAlbum(compressed!, nil, nil, nil)
        let alert = UIAlertController(title: "Success!", message: "Your image has been saved.", preferredStyle: .alert)
        let okay  = UIAlertAction(title: "Keep Scrolling", style: .default, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        view.backgroundColor = UIColor(red: (249/255.0), green: (246/255.0), blue: (241/255.0), alpha: 1.0)
        view.addSubview(postImg)
        let width = view.frame.width - 70
        let height = view.frame.height/2
        postImg.anchor(top: view.topAnchor, paddingTop: 125, width : width, height: height)
        postImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(time)
        time.anchor(top: postImg.bottomAnchor, right: postImg.rightAnchor, paddingTop: 12, paddingRight: 10)
        
        view.addSubview(userImg)
        userImg.anchor(top: time.bottomAnchor, left: postImg.leftAnchor, paddingTop: 10, paddingLeft: 25, width: 50, height: 50)
        
        view.addSubview(userName)
        userName.anchor(top: postImg.bottomAnchor, left: userImg.rightAnchor, paddingLeft: 12)
        userName.centerYAnchor.constraint(equalTo: userImg.centerYAnchor).isActive = true
        
        view.addSubview(likeHeart)
        likeHeart.anchor(top: time.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 65, width: 30, height: 30)
        likeHeart.addSubview(likeHeartImg)
        likeHeartImg.anchor(top: likeHeart.topAnchor)
        
        view.addSubview(likes)
        likes.anchor(top: time.bottomAnchor, left: likeHeart.rightAnchor, paddingLeft: 5)
        likes.centerYAnchor.constraint(equalTo: likeHeart.centerYAnchor).isActive = true
        
        view.addSubview(comment)
        comment.anchor(top: userImg.bottomAnchor, left: userImg.centerXAnchor, right: likeHeart.centerXAnchor, paddingTop: 20)
        
        view.addSubview(saveButton)
        saveButton.anchor(bottom: view.bottomAnchor, paddingBottom: 110,width: 105, height: 35)
        saveButton.centerXAnchor.constraint(equalTo: comment.centerXAnchor).isActive = true
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: postImg.leftAnchor, paddingTop: 55,width: 50, height: 50)
    }
    // add image to database storage
    func addImg() {
        let user = Auth.auth().currentUser?.uid
        let imgData = postImg.image?.jpegData(compressionQuality: 0.4)
        let db = Firestore.firestore()
        let imgN = UUID().uuidString
        let ref = Storage.storage().reference().child("users").child(user!).child("likes")
        ref.child(imgN).putData(imgData!, metadata: nil) { (meta, err) in
            if err != nil {return}
        }
        db.collection("users").document(user!).collection("likes").document(id!).setData(["likedImg":imgN, "ID":id!], merge: true)
    }
    
    private func setUp() {
        // image
        let name = imageName
        if let image = name {
            let ref = Storage.storage().reference().child("social").child(image)
            postImg.sd_setImage(with: ref)
        }
        
        // timestamp
        let t = timeStamp
        if let newTime = t {
            time.text = newTime
        }
        
        // userImg
        let pic = userPic
        if let profPic = pic {
            let ref = Storage.storage().reference().child("profile").child(profPic)
            userImg.sd_setImage(with: ref)
        }
        
        // userName
        let user = username
        if let uName = user {
            userName.text = uName
        }
        
        // likes
        let like = numLikes
        if let num = like {
            likes.text = num.stringValue
        }
        else {
            likes.text = "0"
        }
        
        // comment
        let info = caption
        if let com = info {
            comment.text = com
        }
        else {
            likes.text = ""
        }
    }
}
