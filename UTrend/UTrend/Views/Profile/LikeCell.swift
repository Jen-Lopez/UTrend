//
//  LikeCell.swift
//  UTrend

import UIKit
import FirebaseUI

class LikeCell: UICollectionViewCell {
    var liked : Post? {
        didSet {
            
            // load liked img
            let imgName = liked?.postImg
            let img = Storage.storage().reference().child(imgName!) // will change to users -> uid -> likes
            likedImage.sd_setImage(with: img)
//            // LOAD img from db
//                      let imgName =  postItem?.postImg
//                      let img = Storage.storage().reference().child("posts").child(imgName!)
//                      postImage.sd_setImage(with: img)
//            likedImage.image = UIImage(named: (liked?.postImg)!)
            
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
