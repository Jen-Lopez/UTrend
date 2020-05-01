//
//  wardrobeFeed.swift
//  UTrend

import UIKit
import Firebase

class wardrobeFeed: postFeed {
//    var closet :[ClothingItem] = {
//        var item1 = ClothingItem()
//        item1.uploadedImg = "clothes1"
//        var item2 = ClothingItem()
//        item2.uploadedImg = "clothes2"
//
//        var item3 = ClothingItem()
//        item3.uploadedImg = "clothes3"
//
//        var item4 = ClothingItem()
//        item4.uploadedImg = "clothes4"
//
//        return [item1,item2,item3,item4]
//    }()
    var closet = [ClothingItem]()
    
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
    
    override func fetchData() {
        let db = Firestore.firestore()
        let currUser = Auth.auth().currentUser?.uid
        let likeRef = db.collection("users").document(currUser!).collection("clothes")
        likeRef.getDocuments { (snap, err) in
            if err == nil && snap != nil {
                for doc in snap!.documents {
                    let docData = doc.data()
                    let item = ClothingItem()
                    item.uploadedImg = docData["imgName"] as? String
                    self.closet.append(item)
                    print("inside fetchdata of wardrobe")
                }
                
                DispatchQueue.main.async {
                    self.cView.reloadData()
                }
            }
        }
    }
}
