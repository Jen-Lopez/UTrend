//
//  ShoeCell.swift
//  UTrend
//
//  Created by Samantha Garcia on 4/30/20.
//

import UIKit
import Firebase
import FirebaseUI

class ShoeCell: UITableViewCell {

    var shoes = [ClothingItem]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowLayout : UICollectionViewFlowLayout =  {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 193, height: 150 )
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.isPagingEnabled  = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = flowLayout
        fetchShoes()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
        func fetchShoes (){
            shoes.removeAll()
            let db = Firestore.firestore()
            let currUser = Auth.auth().currentUser?.uid
            let ref = db.collection("users").document(currUser!).collection("clothes")
            
            ref.getDocuments { (snap, err) in
                if err == nil && snap != nil {
                    for doc in snap!.documents {
                        let item = ClothingItem()
                        
                        let type = doc["type"] as? String
                        let imgN = doc["imgName"] as? String
                        
                        if type == "shoes" {
                            item.type = type
                            item.uploadedImg = imgN
                            self.shoes.append(item)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
   
    
}

extension ShoeCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell

        // LOAD IMG FROM FIREBASE
        let name: String = shoes[indexPath.row].uploadedImg!
        let user = Auth.auth().currentUser?.uid
        let img = Storage.storage().reference().child("users").child(user!).child("clothes").child(name)
        cell.imageView.sd_setImage(with: img)
        
        return cell
    }
    
}



