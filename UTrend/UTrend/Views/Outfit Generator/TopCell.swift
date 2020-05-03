//
//  TopCell.swift
//  UTrend
//
//  Created by Samantha Garcia on 4/30/20.
//

import UIKit

class TopCell: UITableViewCell {
//    var tops = [ClothingItem]()
    
    var tops: [String] = ["clothes2", "clothes3", "clothes2", "clothes2", "clothes2", "clothes2", "clothes2"]
       
    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowLayout : UICollectionViewFlowLayout =  {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 193, height: 210 )
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
           
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.isPagingEnabled  = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = flowLayout
    }
           
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // chooses right item
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x/frame.width)
        print (index)
    }
    
}

extension TopCell : UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
     
        var name: String = tops[indexPath.row]

//        var name: String = tops[indexPath.row].uploadedImg!
        
        cell.imageView.image = UIImage(named: name)
        return cell
    }
}
