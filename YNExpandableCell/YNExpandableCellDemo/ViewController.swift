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


    func addData() {
        let dataArray = [
            (("Section0_Row0","Row0_Subrow1","Row0_Subrow2"),
            ("Section0_Row1"),
            ("Section0_Row2","Row2_Subrow1","Row2_Subrow2","Row2_Subrow3")),
            
            (("Section1_Row0","Row0_Subrow1","Row0_Subrow2"),
             ("Section1_Row1","Row1_Subrow1"),
             ("Section1_Row2","Row2_Subrow1","Row2_Subrow2","Row2_Subrow3","Row2_Subrow4"))
            ] as [Any]
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
        return 20
    }
    


    
    func initView() {
        let cells = ["YNExpandableFirstCell","YNExpandableSecondCell","YNExpandableThirdCell"]
        self.ynTableView.registerCellsWith(nibNames: cells, and: cells)
    }
}

