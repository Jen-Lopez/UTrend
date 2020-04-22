//
//  WardrobeCell.swift
//  UTrend

import UIKit

class WardrobeCell: UICollectionViewCell, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "closet", for: indexPath)
            return cell
        }
        
        override init(frame: CGRect) {
            super.init(frame:frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let outfit : UIImageView = {
            let img = UIImageView()
            img.backgroundColor = .blue
            img.layer.masksToBounds = true
    //        img.layer.cornerRadius = 5
            img.image = UIImage(named: "wardrobe")
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            return img
        }()
        
        func setUp() {
            addSubview(outfit)
            outfit.anchor(top: topAnchor,left: leftAnchor, width: frame.width, height: frame.height)
        }
}
