//
//  LikeFeed.swift
//  UTrend

import UIKit

class LikeFeed: postFeed{
    var likes : [Post] = {
        var like1 = Post()
        like1.postImg = "like1"
        
        var like2 = Post()
        like2.postImg = "like2"
        
        var like3 = Post()
        like3.postImg = "like3"
        
        var like4 = Post()
        like4.postImg = "like4"
        
        var like5 = Post()
        like5.postImg = "like5"
        
        var like6 = Post()
        like6.postImg = "like6"
        
        return [like1,like2,like3,like4,like5,like6]
    }()
    
    override func setUp() {
        addSubview(cView)
        cView.register(LikeCell.self, forCellWithReuseIdentifier: "likes")
        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "likes", for: indexPath) as! LikeCell
        
        cell.liked = likes[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3-30;
        return CGSize(width: size, height: 150)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likes.count
     }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}
