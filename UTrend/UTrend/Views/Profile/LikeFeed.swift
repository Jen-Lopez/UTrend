
//  LikeFeed.swift
//  UTrend

import UIKit
import Firebase

class LikeFeed: postFeed{
    var likes = [Post]()
    
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
    
    override func fetchData()  {
        likes.removeAll()
        let db = Firestore.firestore()
        let currUser = Auth.auth().currentUser?.uid
        let likeRef = db.collection("users").document(currUser!).collection("likes")
        likeRef.getDocuments { (snap, err) in
            if err == nil && snap != nil {
                for doc in snap!.documents {
                    let docData = doc.data()
                    let post = Post()
                    post.postImg = docData["likedImg"] as? String
                    self.likes.append(post)
                    print("inside fetchdata of like")
                }
                
                DispatchQueue.main.async {
                    self.cView.reloadData()
                }
                self.refresh.endRefreshing()
            }
        }
    }
}
