//
//  WardrobeCell.swift
//  UTrend

import UIKit

class WardrobeCell: UICollectionViewCell {

        override init(frame: CGRect) {
            super.init(frame:frame)
            setUpCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let outfit : UIImageView = {
            let img = UIImageView()
            img.backgroundColor = .blue
            img.layer.masksToBounds = true
            img.image = UIImage(named: "wardrobe")
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            return img
        }()
        
        func setUpCell() {
            addSubview(outfit)
            outfit.anchor(top: topAnchor,left: leftAnchor, width: frame.width, height: frame.height)
        }
}
