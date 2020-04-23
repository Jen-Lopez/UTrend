//
//  FeedCell.swift
//  UTrend

import UIKit

class postFeed: UICollectionViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource  {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let screenSize = UIScreen.main.bounds;
    
    lazy var cView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor(red: (246/255.0), green: (242/255.0), blue: (237/255.0), alpha: 1.0)
        return cv
    }()
    
    func setUp() {
        addSubview(cView)
        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        cView.register(postCell.self, forCellWithReuseIdentifier: "posts")
    }
    
    // collection view METHODS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posts", for: indexPath) as! postCell
        let index = (indexPath.item)%2 + 1
        cell.postImage.image = UIImage(named: "outfit\(index)")
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
