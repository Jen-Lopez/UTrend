//
//  OutfitGenerator.swift
//  UTrend
//

import Foundation
import UIKit

class OutfitGenerator : UIViewController {
    //removed this part    , UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.isScrollEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newOutfit(_ sender: UIButton) {}
    
}


extension OutfitGenerator : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopCell
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomCell", for: indexPath) as! BottomCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoeCell", for: indexPath) as! ShoeCell
            return cell
        }

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height: CGFloat = tableView.frame.size.height
        
        //NSLog("0 : %f", (3*height)/8)
        //NSLog("1 : %f", (3*height)/8)
        //NSLog("2 : %f", (2*height)/8)
        
        if (indexPath.row == 0) {
            return (3*height)/8
        } else if (indexPath.row == 1) {
            return (3*height)/8
        } else {
            return (2*height)/8
        }
    }
    
    
}
