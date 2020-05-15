//  Profile.swift
//  Created by Jennifer Lopez

import UIKit
import Firebase
import FirebaseUI

class Profile:  UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // grey status bar
    let statusBar: UIImageView = {
        let sb = UIImageView()
        sb.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        return sb
    }()

    // create the profile Image
    lazy var profileImage:UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: (252/255.0), green: (246/255.0), blue: (239/255.0), alpha: 1.0)
        // assign placeholder for new user
        img.image = UIImage(named: "placeholder")
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeProfilePic)))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    @objc func changeProfilePic() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
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
            profileImage.image = selected
            // UPLOAD NEW PROFILE IMG TO FIREBASE
            let imgData = selected.jpegData(compressionQuality: 0.4)
            let user = Auth.auth().currentUser?.uid
            let db = Firestore.firestore()
            let imgName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile").child(imgName)
            storageRef.putData(imgData!, metadata: nil) { (meta, err) in
                if err != nil {return}
            }
            db.collection("users").document(user!).setData([ "profileImg": imgName], merge: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // create sign out button
    let signOutButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: (210/255.0), green: (196/255.0), blue: (196/255.0), alpha: 1.0)
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        button.addTarget(self, action:#selector(logOut), for: .touchUpInside)
        return button
    } ()
    
    // when log out is clicked, it goes back to welcome page
    @objc func logOut(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "welcome") as? Welcome
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // first name
    let firstName:UILabel = {
        let name = UILabel()
        name.textColor = UIColor(red: (153/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
        name.font! = UIFont(name: "Verdana", size: 30)!
        name.sizeToFit()
        name.textAlignment = .center
        return name
    }()
    
    // username
    let userName:UILabel = {
        let user = UILabel()
        user.textColor = UIColor(red: (193/255.0), green: (185/255.0), blue: (185/255.0), alpha: 1.0)
        user.font! = UIFont(name: "Verdana", size: 22)!
        user.sizeToFit()
        user.textAlignment = .center
        return user
    }()
    
    // create the navigator
    lazy var profileNav : ProfileBar = {
        let bar = ProfileBar()
        bar.profileController = self
        return bar
    }()

    // create the profile header container
    lazy var profileHeader:UIView = {
        let profileHead = UIView()
        profileHead.backgroundColor = UIColor(red: (235/255.0), green: (227/255.0), blue: (218/255.0), alpha: 1.0)
        
        // add grey status bar
        profileHead.addSubview(statusBar)
        statusBar.anchor(top: profileHead.topAnchor, left: profileHead.leftAnchor, right: profileHead.rightAnchor, height: 60)
        
        // add profile picture to view
        profileHead.addSubview(profileImage)
        profileImage.anchor(top: profileHead.topAnchor, left: profileHead.leftAnchor,  paddingTop: 130, paddingLeft:30, width: 135, height: 135)
        profileImage.layer.cornerRadius = 135/2

        // add name label
        profileHead.addSubview(firstName)
        firstName.anchor(left: profileImage.rightAnchor, bottom: profileImage.centerYAnchor, right: profileHead.rightAnchor)
        
        // add username
        profileHead.addSubview(userName)
        userName.anchor(top: firstName.bottomAnchor,left: profileImage.rightAnchor, right: profileHead.rightAnchor, paddingTop: 5)
        
        // add sign out button
        profileHead.addSubview(signOutButton)
        signOutButton.anchor(top: userName.bottomAnchor, left: profileImage.rightAnchor, paddingTop: 75, paddingLeft: 65, width: 130, height: 35)
        
        // add the bar
        profileHead.addSubview(profileNav)
        profileNav.anchor(left: profileHead.leftAnchor, bottom: profileHead.bottomAnchor, right: profileHead.rightAnchor, height: 75)
        
        return profileHead
    }()
    
    // HORIZONTAL COLLECTION VIEW
    lazy var profileView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // creates horizontal scroll effect
        layout.minimumLineSpacing = 0 // removes white space
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.backgroundColor = UIColor(red: (246/255.0), green: (242/255.0), blue: (237/255.0), alpha: 1.0)

        cv.register(postFeed.self, forCellWithReuseIdentifier: "postFeed")
        cv.register(LikeFeed.self, forCellWithReuseIdentifier: "likeFeed")
        cv.register(wardrobeFeed.self, forCellWithReuseIdentifier: "wardrobeFeed")
        
        cv.isPagingEnabled  = true; // makes cell "snap" into place
        cv.showsHorizontalScrollIndicator = false
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetch user
        fetchUser()
        
        // add profile header
        view.addSubview(profileHeader)
        profileHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 450)
        
        // Profile Collection View
        view.addSubview(profileView)
        profileView.anchor(top: profileNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor , right: view.rightAnchor)

        profileView.backgroundColor = UIColor(red: (246/255.0), green: (242/255.0), blue: (237/255.0), alpha: 1.0)
    }
    
    // refreshes collection views on page at the beginning before it appears
    override func viewWillAppear(_ animated: Bool) {
        let postFeed = self.profileView.cellForItem(at: IndexPath(item: 0, section: 0)) as? postFeed
        let likeFeed = self.profileView.cellForItem(at: IndexPath(item: 1, section: 0)) as? LikeFeed
        let wardrobeFeed = self.profileView.cellForItem(at: IndexPath(item: 2, section: 0)) as? wardrobeFeed
        postFeed?.fetchData()
        likeFeed?.fetchData()
        wardrobeFeed?.fetchData()
        print ("refreshed data")
    }
    
    // when you click on menu item, it scrolls to appropriate view
    func scrollToMenuIndex(menuIndex: Int){
        let indexP = IndexPath(item: menuIndex, section: 0)
        profileView.scrollToItem(at: indexP, at: [], animated: true)
    }
    // when you scroll, it selects appropriate menu icon
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // choose the right icon in menu when scrolling
        let index = Int(targetContentOffset.pointee.x/view.frame.width)
        let indexP = IndexPath(item: index, section: 0)
        profileNav.barItems.selectItem(at: indexP, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 3
       }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if (indexPath.item == 0) {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postFeed", for: indexPath)
           return cell
       } else if (indexPath.item == 1) {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "likeFeed", for: indexPath)
           return cell
       } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wardrobeFeed", for: indexPath)
           return cell
       }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: view.frame.width, height: view.frame.height - 450)
    }
    // fetches user info (e.g. username, name, profilepic) from database
    func fetchUser() {
        // first, get the UID of logged in user
        if let uid = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            // get the associated document of the user
            let user = db.collection("users").document(uid)
            // set values
            user.getDocument { (doc, err) in
                if err == nil {
                    if doc != nil && doc!.exists {
                        let data = doc!.data()
                        self.firstName.text = data!["firstname"] as? String
                        self.userName.text = "@" + (data!["username"] as? String)!
                        
                        // download profile image from firebase
                        let imgName = data!["profileImg"] as? String
                        if (imgName?.isEmpty == false) {
                            let img = Storage.storage().reference().child("profile").child(imgName!)
                            self.profileImage.sd_setImage(with: img)
                        }
                    }
                }
            }
        }
    }
    
}

