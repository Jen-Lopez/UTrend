//
//  LikeCell.swift
//  UTrend

import UIKit
import FirebaseUI
import Firebase

class LikeCell: UICollectionViewCell {
    var liked : Post? {
        didSet {
            
            // load liked img
            let imgName = liked?.postImg
            let user = Auth.auth().currentUser?.uid
            let img = Storage.storage().reference().child("users").child(user!).child("likes").child(imgName!)
            likedImage.sd_setImage(with: img)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let likedImage : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    func setUpCell() {
        addSubview(likedImage)
        likedImage.anchor(top: topAnchor,left: leftAnchor, width: frame.width, height: frame.height)
    }

}
