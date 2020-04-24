//  Social.swift
//  UTrend

import UIKit
import AVKit

class Social: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    let posts : [Post] = {
        let post1 = Post()
        post1.postImg = "out1"
        post1.time = "5h ago"
        post1.textCaption = "lor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
        post1.user = "mikayla"
        let post2 = Post()
        post2.postImg = "out2"
        post2.time = "22m ago"
        post2.textCaption = "lor sit amet, consectetur adipiscing"
        post2.user = "andrea_ue"

        let post3 = Post()
        post3.postImg = "out3"
        post3.time = "3d ago"
        post3.textCaption = "lor sit amet, consectetur adipiscing"
        post3.user = "nikkyG"

        let post4 = Post()
        post4.postImg = "out4"
        post4.time = "1mo ago"
        post4.textCaption  = "lor sit amet, consectetur elit, sed do eiusmod tempor incididunt"
        post4.user = "unknown"
        
        return [post1,post2,post3,post4]
    }()
    
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
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width/2 - 20
        layout.estimatedItemSize = CGSize(width: width, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        layout.minimumLineSpacing = 30
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = mauve
        cv.register(socialCell.self, forCellWithReuseIdentifier: "users")
        cv.showsVerticalScrollIndicator = false
                
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
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "users", for: indexPath) as! socialCell

        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.socialPost = posts[indexPath.item]
        return cell
    }
    
}
