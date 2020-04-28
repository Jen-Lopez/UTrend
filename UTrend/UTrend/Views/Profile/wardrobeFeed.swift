//
//  wardrobeFeed.swift
//  UTrend

import UIKit

class wardrobeFeed: postFeed {
    var closet :[ClothingItem] = {
        var item1 = ClothingItem()
        item1.uploadedImg = "clothes1"
        var item2 = ClothingItem()
        item2.uploadedImg = "clothes2"

        var item3 = ClothingItem()
        item3.uploadedImg = "clothes3"

        var item4 = ClothingItem()
        item4.uploadedImg = "clothes4"

        return [item1,item2,item3,item4]
    }()
    override func setUp() {
        addSubview(cView)
        cView.register(WardrobeCell.self, forCellWithReuseIdentifier: "clothes")
        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothes", for: indexPath) as! WardrobeCell
        cell.item = closet[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3-30;
        return CGSize(width: size, height: 150)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return closet.count
     }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}
