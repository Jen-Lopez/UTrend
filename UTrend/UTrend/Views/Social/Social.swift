//  Social.swift
//  UTrend
//  Created by Jennifer Lopez

import UIKit
import AVKit
import Firebase

class Social: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var segueIdentifier = "viewInfo"
    var posts = [Post]()
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
    // opens view to submit a post to the social page
    @objc func makePost() {
        self.navigationController?.pushViewController(postInfo(), animated: true)
    }
    
    lazy var socialView : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width/2 - 20
        layout.estimatedItemSize = CGSize(width: width, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 5, right: 12)
        layout.minimumLineSpacing = 30
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = mauve
        cv.register(socialCell.self, forCellWithReuseIdentifier: "users")
        cv.showsVerticalScrollIndicator = false
                
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSocialPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = true // hides nav bar

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
        // click on icon to submit a post
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(makePost)))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    // generates posts displayed in social view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "users", for: indexPath) as! socialCell

        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.socialPost = posts[indexPath.item]
        return cell
    }
    
    // opens view to see more information on pos, passes data forward
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.item]
        performSegue(withIdentifier: segueIdentifier, sender: post)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = sender as! Post
        if segue.identifier == segueIdentifier {
            if let vc = segue.destination as? SocialMore {
                                
                // check if the post was liked. If it was, fill in likeheart
                let db = Firestore.firestore()
                let user = Auth.auth().currentUser?.uid
                let likes = db.collection("users").document(user!).collection("likes").document(post.pid!)
//                print (post.pid!)
                likes.getDocument { (doc, err) in
                    if (doc?.exists == true) {
//                        print ("does exist!")
                        vc.likeHeartImg.image = UIImage(named:"fill-likeheart")
                    }
                    else {
                        vc.likeHeartImg.image = UIImage(named:"likeheart")
                    }
                }
                
                vc.imageName = post.postImg
                vc.timeStamp = post.time
                vc.username = post.username
                vc.numLikes = post.likes
                vc.caption = post.textCaption
                vc.userPic = post.userPic
                vc.id = post.pid
                vc.uID = post.uid
            }
        }
    }
    
    func fetchSocialPost(){
//        print ("inside fetch post")
        posts.removeAll()
        let db = Firestore.firestore()
        let socialRef = db.collection("socialFeed")
        socialRef.getDocuments { (snap, err) in
            if err == nil && snap != nil {
                for doc in snap!.documents {
                    let docData = doc.data()
                    let post = Post()
                    post.postImg = docData["postImg"] as? String
                    post.textCaption = docData["caption"] as? String
                    post.likes = docData["likes"] as? NSNumber
                    post.username = docData["username"] as? String
                    post.userPic = docData["profImg"] as? String
                    post.pid = docData["ID"] as? String
                    post.uid = docData["uid"] as? String
                    
                    self.posts.append(post)
                }
                DispatchQueue.main.async {
                    self.socialView.reloadData()
                }
            }
        }
    }
}
