//
//  FeedCell.swift
//  UTrend

import UIKit

class FeedCell: UICollectionViewCell, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
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
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
//        cv.register(LikeCell.self, forCellWithReuseIdentifier: "thing")
        cv.register(WardrobeCell.self, forCellWithReuseIdentifier: "thing")
//        cv.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        // only for gallery view
        layout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: screenSize.width/3-30, height: 150)
        layout.minimumLineSpacing = 30
//          layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
//        cv.register(postCell.self, forCellWithReuseIdentifier: "thing")
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "thing")

        return cv
    }()
    
    func setUp() {
        addSubview(cView)
        cView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
//        cView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thing", for: indexPath) //as! postCell
//        cell.backgroundColor = .red
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 110, height: 150)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: 160)
//    }
}
