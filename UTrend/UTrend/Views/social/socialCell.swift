//  socialCellCollectionViewCell.swift
//  UTrend

import UIKit

class socialCell: UICollectionViewCell {
    
    var socialPost : Post? {
        didSet {
            postImage.image = UIImage(named: (socialPost?.postImg)!)
            timeStamp.text = socialPost?.time
            comment.text = socialPost?.textCaption
            userName.text = socialPost?.username
       
            if (socialPost?.userPic != nil) {
                userImg.image = UIImage(named: (socialPost?.userPic)!)
            }
           
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpCell()
        backgroundColor = UIColor(red: (249/255.0), green: (246/255.0), blue: (241/255.0), alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // picture, like button, time stamp, description, profile pic
    let postImage : UIImageView = {
        let pic = UIImageView()
        pic.layer.masksToBounds = true
        pic.layer.cornerRadius = 8
        pic.clipsToBounds = true
        pic.contentMode = .scaleAspectFill
        return pic
    }()
    
    let timeStamp : UILabel = {
        let time = UILabel()
        time.font! = UIFont(name: "Avenir-Book", size: 14)!
        time.sizeToFit()
        time.textColor = UIColor(red: (161/255.0), green: (153/255.0), blue: (153/255.0), alpha: 1.0)
        time.textAlignment = .center
        return time
    }()
    
    let comment : UILabel = {
        let com = UILabel()
        com.textColor = UIColor(red: (112/255.0), green: (112/255.0), blue: (112/255.0), alpha: 1.0)

        com.font! = UIFont(name: "Avenir-Book", size: 12)!
        com.sizeToFit()
        com.textAlignment = .center
        com.lineBreakMode = .byWordWrapping
        com.numberOfLines = 0;
        return com
    }()
    
    let userImg : UIImageView = {
        let profilePic = UIImageView()
        profilePic.backgroundColor = UIColor(red: (221/255.0), green: (215/255.0), blue: (215/255.0), alpha: 1.0)
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = 35/2
        profilePic.contentMode = .scaleAspectFill
        profilePic.clipsToBounds = true
        return profilePic
    }()
    
    let userName : UILabel = {
        let user = UILabel()
        user.textColor = UIColor(red: (212/255.0), green:(170/255.0), blue: (170/255.0), alpha: 1.0)
        user.font! = UIFont(name: "Avenir-Medium", size: 15)!
        user.sizeToFit()
        user.textAlignment = .center
        user.numberOfLines = 1
        return user
    }()
    
    func setUpCell() {
        addSubview(postImage)
        
        postImage.anchor(top: topAnchor, paddingTop: 20)
        postImage.anchor(top: topAnchor, paddingTop: 20, width: frame.width-30)
        postImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(timeStamp)
        timeStamp.anchor(top: postImage.bottomAnchor, right: postImage.rightAnchor, paddingTop: 8)

        addSubview(comment)
        comment.anchor(top: timeStamp.bottomAnchor, paddingTop: 15, width: frame.width - 20)
        comment.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(userImg)
        userImg.anchor(top: comment.bottomAnchor, left: postImage.leftAnchor, bottom: bottomAnchor, paddingTop: 15,paddingLeft: 30, paddingBottom: 15, width: 35, height: 35)

        addSubview(userName)
        userName.anchor(top: comment.bottomAnchor, left: userImg.rightAnchor,paddingLeft: 10)
        userName.centerYAnchor.constraint(equalTo: userImg.centerYAnchor).isActive = true
    }
 
}
