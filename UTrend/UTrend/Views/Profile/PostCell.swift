//  PostCell.swift
//  Created by UTrend on 4/18/20.

// CUSTOM PROFILE CELLS
import UIKit

class postCell : UICollectionViewCell {
    var postItem : Post? {
        didSet {
            comment.text = postItem?.textCaption
            postImage.image = UIImage(named: (postItem?.postImg)!)
            timeStamp.text = postItem?.time
            likes.text = String((postItem?.likes)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCell()
    }
    
    let postImage : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 5
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let comment : UILabel = {
        let com = UILabel()
        com.textColor = UIColor(red: (98/255.0), green: (92/255.0), blue: (92/255.0), alpha: 1.0)
        com.font! = UIFont(name: "Avenir-Book", size: 12)!
        com.sizeToFit()
        com.textAlignment = .center
        com.lineBreakMode = .byWordWrapping
        com.numberOfLines = 0;
        return com
    }()
    
    let timeStamp : UILabel = {
        let time = UILabel()
        time.font! = UIFont(name: "Avenir-Book", size: 11)!
        time.sizeToFit()
        time.textColor = UIColor(red: (168/255.0), green: (168/255.0), blue: (168/255.0), alpha: 1.0)
        time.textAlignment = .center
        return time
    }()
    
    let likes : UILabel = {
        let num = UILabel()
        num.textColor = UIColor(red: (132/255.0), green: (127/255.0), blue: (127/255.0), alpha: 1.0)

        num.font! = UIFont(name: "Avenir-Book", size: 12)!
        num.sizeToFit()
        num.textAlignment = .center
        return num
    }()
    
    let heart : UIImageView = {
        let like = UIImageView()
        like.image = UIImage(named: "like-heart")
        return like
    }()
    
    func setupCell() {
        addSubview(postImage)
        postImage.anchor(top: self.topAnchor,left: self.leftAnchor, paddingTop: 14, paddingLeft: 25, width: 100, height: 135)
        
        addSubview(comment)
        comment.anchor(top: postImage.topAnchor, left: postImage.rightAnchor, paddingTop: 15, paddingLeft: 30, width: 205)
        
        addSubview(timeStamp)
        timeStamp.anchor(bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 8, paddingRight: 15)

        addSubview(heart)
        heart.anchor( bottom: timeStamp.bottomAnchor, right: timeStamp.leftAnchor,paddingRight: 70, width: 25, height: 25)

        addSubview(likes)
        likes.anchor(left: heart.rightAnchor, bottom: heart.bottomAnchor, paddingLeft: -5,paddingBottom: 5,width: 35)
        
        // drop shadow
        self.layer.shadowOffset = CGSize(width: 1, height: 5)
        self.layer.shadowColor = UIColor(ciColor: .black).cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        backgroundColor =  UIColor(red: (249/255.0), green: (249/255.0), blue: (249/255.0), alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
