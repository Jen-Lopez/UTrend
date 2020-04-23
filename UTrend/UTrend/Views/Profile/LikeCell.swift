//
//  LikeCell.swift
//  UTrend

import UIKit

class LikeCell: UICollectionViewCell {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "likes", for: indexPath)
//        return cell
//    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let likedImage : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .blue
        img.layer.masksToBounds = true
//        img.layer.cornerRadius = 5
        img.image = UIImage(named: "likes") // post picture
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    func setUpCell() {
        addSubview(likedImage)
        likedImage.anchor(top: topAnchor,left: leftAnchor, width: frame.width, height: frame.height)
    }
    
//    override func setUp() {
//        addSubview(cView)
//        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
//        cView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
//    }
    
    
}
