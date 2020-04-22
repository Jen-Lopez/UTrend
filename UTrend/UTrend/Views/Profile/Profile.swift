//  Profile.swift
//  Created by UTrend on 4/12/20.

import UIKit

class Profile:  UIViewController {
    
    // grey status bar
    let statusBar: UIImageView = {
        let sb = UIImageView()
        sb.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        return sb
    }()

    // create the profile Image
    let profileImage:UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: (252/255.0), green: (246/255.0), blue: (239/255.0), alpha: 1.0)
        
        // assign profile picture
        img.image = UIImage(named: "placeholder")
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    // create sign out button
    let signOutButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: (210/255.0), green: (196/255.0), blue: (196/255.0), alpha: 1.0)
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        return button
    } ()
    
    // first + last name
    let fullName:UILabel = {
        let name = UILabel()
        name.text = "First Last" // replace name
        name.textColor = UIColor(red: (153/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
        name.font! = UIFont(name: "Verdana", size: 22)!
        name.sizeToFit()
        name.textAlignment = .center
        return name
    }()
    
    // username
    let userName:UILabel = {
        let user = UILabel()
        user.textColor = UIColor(red: (193/255.0), green: (185/255.0), blue: (185/255.0), alpha: 1.0)
        user.text = "@username" // replace username
        user.font! = UIFont(name: "Verdana", size: 16)!
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
        profileHead.addSubview(fullName)
        fullName.anchor(left: profileImage.rightAnchor, bottom: profileImage.centerYAnchor, right: profileHead.rightAnchor)
        
        // add username
        profileHead.addSubview(userName)
        userName.anchor(top: fullName.bottomAnchor,left: profileImage.rightAnchor, right: profileHead.rightAnchor, paddingTop: 5)
        
        // add sign out button
        profileHead.addSubview(signOutButton)
        signOutButton.anchor(top: userName.bottomAnchor, left: profileImage.rightAnchor, paddingTop: 75, paddingLeft: 65, width: 130, height: 35)
        
        // add the bar
        profileHead.addSubview(profileNav)
//        profileNav.anchor(top: profileHead.bottomAnchor, left: profileHead.leftAnchor, right: profileHead.rightAnchor)
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

        cv.register(FeedCell.self, forCellWithReuseIdentifier: "profile")
        cv.isPagingEnabled  = true; // makes cell "snap" into place
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add profile header
        view.addSubview(profileHeader)
        profileHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 450)
        
        // Profile Collection View
        view.addSubview(profileView)
        profileView.anchor(top: profileNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor , right: view.rightAnchor)
        profileView.backgroundColor = .orange
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexP = IndexPath(item: menuIndex, section: 0)
        profileView.scrollToItem(at: indexP, at: [], animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // choose the right icon in menu when scrolling
        let index = Int(targetContentOffset.pointee.x/view.frame.width)
        let indexP = IndexPath(item: index, section: 0)
        profileNav.barItems.selectItem(at: indexP, animated: true, scrollPosition: [])
    }
}
