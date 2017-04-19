//
//  ViewController.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit
import YNExpandableCell

class ViewController: UIViewController, YNTableViewDelegate {
    @IBOutlet var ynTableView: YNTableView!
    @IBOutlet var expandAllButton: UIBarButtonItem!
    @IBOutlet var collapseAllButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cells = ["YNExpandableCellEx","YNSliderCell","YNSegmentCell"]
        self.ynTableView.registerCellsWith(nibNames: cells, and: cells)
        self.ynTableView.registerCellsWith(cells: [UITableViewCell.self as AnyClass], and: ["YNNonExpandableCell"])
        
        self.ynTableView.ynDelegate = self
        self.ynTableView.ynTableViewRowAnimation = .top
        
        self.expandAllButton.action = #selector(self.expandAllButtonClicked)
        self.expandAllButton.target = self
        self.collapseAllButton.action = #selector(self.collapseAllButtonClicked)
        self.collapseAllButton.target = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func expandAllButtonClicked() {
        self.ynTableView.expandAll()
    }
    
    func collapseAllButtonClicked() {
        self.ynTableView.collapseAll()
    }
    
    func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell? {
        let ynSliderCell = YNTableViewCell()
        ynSliderCell.cell = tableView.dequeueReusableCell(withIdentifier: YNSliderCell.ID) as! YNSliderCell
        ynSliderCell.height = 142

        let ynSegmentCell = YNTableViewCell()
        ynSegmentCell.cell = tableView.dequeueReusableCell(withIdentifier: YNSegmentCell.ID) as! YNSegmentCell
        ynSegmentCell.height = 160

        if indexPath.section == 0 && indexPath.row == 1 {
            return ynSliderCell
        } else if indexPath.section == 0 && indexPath.row == 2 {
            return ynSegmentCell
        } else if indexPath.section == 0 && indexPath.row == 4 {
            return ynSegmentCell
        } else if indexPath.section == 1 && indexPath.row == 0 {
            return ynSegmentCell
        } else if indexPath.section == 1 && indexPath.row == 1 {
            return ynSliderCell
        } else if indexPath.section == 2 && indexPath.row == 2 {
            return ynSliderCell
        } else if indexPath.section == 2 && indexPath.row == 4 {
            return ynSliderCell
        }
        return nil
    }

//    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? {
//        let ynSliderCell = tableView.dequeueReusableCell(withIdentifier: YNSliderCell.ID) as! YNSliderCell
//        let ynSegmentCell = tableView.dequeueReusableCell(withIdentifier: YNSegmentCell.ID) as! YNSegmentCell
//
//        if indexPath.section == 0 && indexPath.row == 1 {
//            return ynSliderCell
//        } else if indexPath.section == 0 && indexPath.row == 2 {
//            return ynSegmentCell
//        } else if indexPath.section == 0 && indexPath.row == 4 {
//            return ynSegmentCell
//        } else if indexPath.section == 1 && indexPath.row == 0 {
//            return ynSegmentCell
//        } else if indexPath.section == 1 && indexPath.row == 1 {
//            return ynSliderCell
//        } else if indexPath.section == 2 && indexPath.row == 2 {
//            return ynSliderCell
//        } else if indexPath.section == 2 && indexPath.row == 4 {
//            return ynSliderCell
//        }
//        return nil
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expandableCell = tableView.dequeueReusableCell(withIdentifier: YNExpandableCellEx.ID) as! YNExpandableCellEx
        if indexPath.section == 0 && indexPath.row == 1 {
            expandableCell.titleLabel.text = "YNSlider Cell"
        } else if indexPath.section == 0 && indexPath.row == 2 {
            expandableCell.titleLabel.text = "YNSegment Cell"
        } else if indexPath.section == 0 && indexPath.row == 4 {
            expandableCell.titleLabel.text = "YNSegment Cell"
        } else if indexPath.section == 1 && indexPath.row == 0 {
            expandableCell.titleLabel.text = "YNSegment Cell"
        } else if indexPath.section == 1 && indexPath.row == 1 {
            expandableCell.titleLabel.text = "YNSlider Cell"
        } else if indexPath.section == 2 && indexPath.row == 2 {
            expandableCell.titleLabel.text = "YNSlider Cell"
        } else if indexPath.section == 2 && indexPath.row == 4 {
            expandableCell.titleLabel.text = "YNSlider Cell"
        } else {
            let nonExpandablecell = tableView.dequeueReusableCell(withIdentifier: "YNNonExpandableCell")
            nonExpandablecell?.textLabel?.text = "YNNonExpandable Cell"
            nonExpandablecell?.selectionStyle = .none
            return nonExpandablecell!
        }
        return expandableCell
        
    }
    
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
        print("Selected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
    }
    
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
        print("Deselected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 5
        } else if section == 2 {
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
        } else if section == 2 {
            return "Section 2"
        }
        return ""
    }
}

