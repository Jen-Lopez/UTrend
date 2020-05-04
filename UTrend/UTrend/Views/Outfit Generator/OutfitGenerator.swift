//
//  OutfitGenerator.swift
//  UTrend
//

import Foundation
import UIKit

class OutfitGenerator : UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var refresh:UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refreshAll), for: .valueChanged)
        return ref
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.refreshControl = refresh
        tableView.backgroundColor =  UIColor(red: (235/255.0), green: (227/255.0), blue: (217/255.0), alpha: 1.0)
//        self.tableView.isScrollEnabled = false
    }
    @objc func refreshAll () {
        if let top = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TopCell {
            top.fetchTops()
        }
        if let bottom = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BottomCell {
            bottom.fetchBottoms()
        }
        if let shoes = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ShoeCell {
            shoes.fetchShoes()
        }

        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresh.endRefreshing()
        }
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
