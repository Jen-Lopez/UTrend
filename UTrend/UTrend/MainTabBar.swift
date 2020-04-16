//  MainTabBar.swift
//  UTrend
//
//  Created by UTrend on 4/13/20.

import UIKit

class MainTabBar: UITabBarController {
    var tabItem = UITabBarItem();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loads tab bar image and selectors
        let selTabOne = UIImage(named: "profile-color")?.withRenderingMode(.alwaysOriginal)
        let deselTabOne = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        tabItem = self.tabBar.items![0]
        tabItem.image = deselTabOne
        tabItem.selectedImage = selTabOne


        let selTabTwo = UIImage(named: "heart-social-color")?.withRenderingMode(.alwaysOriginal)
        let deselTabTwo = UIImage(named: "heart-social")?.withRenderingMode(.alwaysOriginal)
        tabItem = self.tabBar.items![1]
        tabItem.image = deselTabTwo
        tabItem.selectedImage = selTabTwo


        let selTabThree = UIImage(named: "heart-color")?.withRenderingMode(.alwaysOriginal)
        let deselTabThree = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        tabItem = self.tabBar.items![2]
        tabItem.image = deselTabThree
        tabItem.selectedImage = selTabThree


        let selTabFour = UIImage(named: "camera-color")?.withRenderingMode(.alwaysOriginal)
        let deselTabFour = UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal)
        tabItem = self.tabBar.items![3]
        tabItem.image = deselTabFour
        tabItem.selectedImage = selTabFour
        
        // always start on profile page
        self.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
