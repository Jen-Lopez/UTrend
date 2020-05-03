//
//  ShoeCell.swift
//  UTrend
//
//  Created by Samantha Garcia on 4/30/20.
//

import UIKit

class ShoeCell: UITableViewCell {

    var shoes: [String] = ["clothes4", "clothes4", "clothes4", "clothes4", "clothes4", "clothes4", "clothes4"]
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // chooses right item
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x/frame.width)
        print (index)
    }
}

extension ShoeCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        var name: String = shoes[indexPath.row]//[indexPath.section]
        
        cell.imageView.image = UIImage(named: name)
        return cell
    }
    
}



