//  Social.swift
//  UTrend

import UIKit

class Social: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    let mauve = UIColor(red: (229/255.0), green: (218/255.0), blue: (217/255.0), alpha: 1.0)
    
    let statusBar: UIImageView = {
        let sb = UIImageView()
        sb.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        return sb
    }()
    
    let icon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Utrend-Icon")
        return img
    }()
    
    lazy var socialView : UICollectionView =  {
//        let layout = socialLayout()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = mauve
        cv.register(socialCell.self, forCellWithReuseIdentifier: "users")
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "users")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mauve
        // add grey status bar
        view.addSubview(statusBar)
        statusBar.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 60)
        // add img icon
        view.addSubview(icon)
        icon.anchor(top: statusBar.bottomAnchor, paddingTop: 10, width: 100, height: 90)
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // add collection view
        view.addSubview(socialView)
        socialView.anchor(top: icon.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "users", for: indexPath)
        cell.backgroundColor = UIColor(red: (249/255.0), green: (246/255.0), blue: (241/255.0), alpha: 1.0)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/2-30;
        return CGSize(width: size, height: 420)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
       }
}
