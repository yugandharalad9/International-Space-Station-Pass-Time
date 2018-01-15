//
//  MyTableViewController.swift
//  International Space Station Pass Time
//
//  Created by Yugandhara Lad More on 1/15/18.
//  Copyright © 2018 Yugandhara Lad. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    
    
    var PassTimes: Array<PassTime> = []

    // Data model: These strings will be the data for the table view cells
    var passes: [String] = []
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
   
   
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for pass in PassTimes{
            
            let onDateTime = Date(timeIntervalSince1970: pass.risetime)
            
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
            
            let dateString = dayTimePeriodFormatter.string(from: onDateTime)
            passes.append("On \(dateString) for \(pass.duration) seconds")
            
        }
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passes.count
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.passes[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}
