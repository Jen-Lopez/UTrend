//
//  LikeCell.swift
//  UTrend

import UIKit

class LikeCell: UICollectionViewCell {
    var liked : Post? {
        didSet {
            likedImage.image = UIImage(named: (liked?.postImg)!)
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
