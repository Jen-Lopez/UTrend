//
//  FeedCell.swift
//  UTrend

import UIKit

class postFeed: UICollectionViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource  {
    
    var posts : [Post] = {
        var post1 = Post()
        post1.postImg = "outfit1"
        post1.textCaption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        post1.time = "1 day ago"
        post1.likes = 243
        
        var post2 = Post()
        post2.postImg = "outfit2"
        post2.textCaption = "adipiscing elit, sed do eiusmod tempor!"
        post2.time = "3 weeks ago"
        post2.likes = 324
        return [post1,post2]
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor(red: (246/255.0), green: (242/255.0), blue: (237/255.0), alpha: 1.0)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    func setUp() {
        addSubview(cView)
        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        cView.register(postCell.self, forCellWithReuseIdentifier: "posts")
    }
    
    // collection view METHODS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posts", for: indexPath) as! postCell

        cell.postItem = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
