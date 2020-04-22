//  ProfileBar.swift
//  UTrend

import UIKit

class ProfileBar : UIView, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var profileController : Profile?
    
    lazy var barItems : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: (204/255.0), green: (198/255.0), blue: (191/255.0), alpha: 1.0)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    let tabTitles = ["Posts","Likes","Wardrobe"]
    let tabIcons = ["posts","light-heart","hanger"]

    override init(frame:CGRect) {
        super.init(frame:frame)
        addSubview(barItems)
        barItems.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        // select profile
        let selected = NSIndexPath(item: 0, section: 0)
        barItems.selectItem(at: selected as IndexPath, animated: false, scrollPosition: .top)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuCell
        cell.icon.image = UIImage(named: tabIcons[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(red: (184/255.0), green: (179/255.0), blue: (174/255.0), alpha: 1.0)

        // change text
        cell.title.text = tabTitles[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // when clicking on icon, change view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}

class MenuCell : UICollectionViewCell {
    var darkColor = UIColor(red: (142/255.0), green: (138/255.0), blue: (138/255.0), alpha: 1.0)
    var lightColor = UIColor(red: (184/255.0), green: (179/255.0), blue: (174/255.0), alpha: 1.0)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }

    let icon : UIImageView = {
        let ic = UIImageView()
        return ic
    }()

    let title : UILabel = {
        let tabName = UILabel()
        tabName.font! = UIFont(name: "Verdana", size: 11)!
        tabName.sizeToFit()
        tabName.textColor = UIColor(red: (117/255.0), green: (112/255.0), blue: (106/255.0), alpha: 1.0)
        tabName.textAlignment = .center
        return tabName
    }()

    func setUpCell () {
        addSubview(icon)

        icon.anchor(top: topAnchor,paddingTop: 10, width:35, height: 35)
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(title)
        title.anchor(top:icon.bottomAnchor, paddingTop: 5)
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            icon.tintColor = isHighlighted ? darkColor : lightColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            icon.tintColor = isSelected ? darkColor : lightColor
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
