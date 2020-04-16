//
//  Profile.swift
//  UTrend
//
//  Created by UTrend on 4/12/20.

import UIKit

class Profile: UIViewController {

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
        button.titleLabel?.font = UIFont(name: "Verdana", size: 15) // Thonburi or Verdana
        return button
    } ()
    
    // first + last
    let fullName:UILabel = {
        let name = UILabel()
//        name.text = "First Last" // dummy name
//        name.textColor = UIColor(red: (153/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
//        name.font! = UIFont(name: "Verdana", size: 25)!
        return name
    }()

    // create the profile header container
    lazy var profileHeader:UIView = {
        let profileHead = UIView()
        profileHead.backgroundColor = UIColor(red: (235/255.0), green: (227/255.0), blue: (218/255.0), alpha: 1.0)
        
        // add profile picture to view
        profileHead.addSubview(profileImage)
        profileImage.anchor(top: profileHead.topAnchor, left: profileHead.leftAnchor,  paddingTop: 130, paddingLeft:30, width: 150, height: 150)
        profileImage.layer.cornerRadius = 150/2
        
        // add sign out button
        profileHead.addSubview(signOutButton)
        signOutButton.anchor(bottom: profileHead.bottomAnchor, right: profileHead.rightAnchor, paddingBottom: 60, paddingRight: 60, width: 130, height: 35)
        
        // add name label
        profileHead.addSubview(fullName)

        return profileHead
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add profile header
        view.addSubview(profileHeader)
        profileHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 400)
    }
    
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
}

// add new method to existing UIView class
extension UIView {
    func anchor(top:NSLayoutYAxisAnchor? = nil, left:NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop:CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false;
        
        if let top = top {
            topAnchor.constraint(equalTo:top, constant: paddingTop!).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo:left, constant: paddingLeft!).isActive = true
        }

        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }

        if let right = right {
            if let paddingBottom = paddingBottom {
                rightAnchor.constraint(equalTo: right, constant: -paddingBottom).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
