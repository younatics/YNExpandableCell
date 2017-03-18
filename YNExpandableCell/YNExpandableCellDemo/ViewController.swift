//
//  ViewController.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YNTableViewDelegate {

    @IBOutlet var ynTableView: YNTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.ynTableView.ynDelegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YNExpandableFirstCell.ID) as! YNExpandableFirstCell
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Section 0"
        } else if section == 1 {
            return "Section 1"
        }
        return ""
    }


    
    func initView() {
        let cells = ["YNExpandableFirstCell","YNExpandableSecondCell","YNExpandableThirdCell"]
        self.ynTableView.registerCellsWith(nibNames: cells, and: cells)
    }
}

