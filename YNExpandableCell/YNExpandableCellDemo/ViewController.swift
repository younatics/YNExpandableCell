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


    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? {
        if indexPath.section == 0 && indexPath.row == 1 {
            let expandedcell = tableView.dequeueReusableCell(withIdentifier: YNExpandableSecondCell.ID) as! YNExpandableSecondCell
            return expandedcell
        } else if indexPath.section == 0 && indexPath.row == 2 {
            let expandedcell = tableView.dequeueReusableCell(withIdentifier: YNExpandableThirdCell.ID) as! YNExpandableThirdCell
            return expandedcell
        } else if indexPath.section == 0 && indexPath.row == 4 {
            let expandedcell = tableView.dequeueReusableCell(withIdentifier: YNExpandableThirdCell.ID) as! YNExpandableThirdCell
            return expandedcell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YNExpandableFirstCell.ID) as! YNExpandableFirstCell
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.titleLabel.text = "YNExpandable Second Cell"
        } else if indexPath.section == 0 && indexPath.row == 2 {
            cell.titleLabel.text = "YNExpandable Third Cell"
        } else if indexPath.section == 0 && indexPath.row == 4 {
            cell.titleLabel.text = "YNExpandable Third Cell"
        } else {
           cell.titleLabel.text = "YNSection \(indexPath.section) Row \(indexPath.row)"
        }
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

