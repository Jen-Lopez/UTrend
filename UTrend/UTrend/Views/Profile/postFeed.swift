//
//  FeedCell.swift
//  UTrend
//  Created by Jennifer Lopez

import UIKit
import Firebase

class postFeed: UICollectionViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource  {
    var posts = [Post]()

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
        fetchData()
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
    // fetched posts from database
    @objc func fetchData() {
        posts.removeAll()
        let db = Firestore.firestore()
        let currUser = Auth.auth().currentUser?.uid
        let postRef = db.collection("users").document(currUser!).collection("posts")
        postRef.getDocuments { (snap, err) in
            if err == nil && snap != nil {
                for doc in snap!.documents {
                    let docData = doc.data()
                    let post = Post()
                    post.postImg = docData["postImg"] as? String
                    post.likes = docData["likes"] as? NSNumber
                    post.textCaption = docData["caption"] as? String
                    post.time = docData["timestamp"] as? String
                    self.posts.append(post)
                }
                
                DispatchQueue.main.async {
                    self.cView.reloadData()
                }
            }
        }
    }
    
}
