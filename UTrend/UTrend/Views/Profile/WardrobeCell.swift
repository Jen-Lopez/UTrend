//
//  WardrobeCell.swift
//  UTrend

import UIKit
import FirebaseUI

class WardrobeCell: UICollectionViewCell {
    
    var item : ClothingItem? {
        didSet {
            // load clothes img
            let imgName = item?.uploadedImg
            let user = Auth.auth().currentUser?.uid
            let img = Storage.storage().reference().child("users").child(user!).child("clothes").child(imgName!) // will change to users -> uid -> clothes
              outfit.sd_setImage(with: img)
        }
    }

        override init(frame: CGRect) {
            super.init(frame:frame)
            setUpCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let outfit : UIImageView = {
            let img = UIImageView()
            img.layer.masksToBounds = true
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            return img
        }()
        
        func setUpCell() {
            addSubview(outfit)
            outfit.anchor(top: topAnchor,left: leftAnchor, width: frame.width, height: frame.height)
        }
}
