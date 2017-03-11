//
//  YNTableView.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

open class YNTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    static let kIsExpandedKey = "isExpanded"
    static let kSubrowsKey = "subrowsCount"
    static let kDefaultCellHeight: CGFloat = 44.0
    
    var yNDelegate: YNTableViewDelegate?
    var shouldExpandOnlyOneCell = false
    var expandableCells: NSMutableDictionary?

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setYNTableViewDelegate(delegate: YNTableViewDelegate?) {
        
        guard let delegate = delegate else { return }
        self.yNDelegate = delegate
        
    }
    
    func initView() {
        self.delegate = self
        self.dataSource = self
  
    }
    
    func initExpandableCells() -> NSMutableDictionary? {
        if self.expandableCells == nil {
            self.expandableCells = NSMutableDictionary()
            guard let delegate = yNDelegate else { return nil }
            guard let numberOfSections = delegate.numberOfSections?(in: self) else { return nil }
            
            for section in 0..<numberOfSections {
                let numberOfRowsInSection = delegate.tableView(self, numberOfRowsInSection: section)
                var rows = [Any]()
                for row in 0..<numberOfRowsInSection {
                    let rowIndexPath = IndexPath(row: row, section: section)
                    let numberOfSubrows = delegate.tableView(self, numberOfSubRowsAt: rowIndexPath)
                    var isExpandedInitially: Bool = false
                    if delegate.responds(to: Selector("tableView:shouldExpandSubRowsOfCellAtIndexPath:")) {
                        isExpandedInitially = delegate.tableView(self, shouldExpandSubRowsOfCellAt: rowIndexPath)
                    }
                    let rowInfo = NSMutableDictionary(objects: [(isExpandedInitially), (numberOfSubrows)], forKeys: [YNTableView.kIsExpandedKey as NSCopying, YNTableView.kSubrowsKey as NSCopying])
                    rows.append(rowInfo)
                }
                self.expandableCells?[(section)] = rows
            }
        }
        return self.expandableCells
    }
    
    func refreshData() {
        self.expandableCells = nil
        
        super.reloadData()
    }
    
    func refreshDataWithScrollingTo(indexPath: IndexPath) {
        self.refreshData()
        
        if indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section) {
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }

    }
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let yNDelegate = self.yNDelegate else { return Int() }

        return yNDelegate.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
        if correspondingIndexPath?.subRow() == 0 {
            var expandableCell: SKSTableViewCell? = (self.SKSTableViewDelegate.tableView(tableView, cellForRowAt indexPath: correspondingIndexPath) as? SKSTableViewCell)
            if expandableCell?.responds(to: #selector(self.setSeparatorInset)) {
                expandableCell?.separatorInset = UIEdgeInsetsZero
            }
            var isExpanded: Bool? = self.expandableCells[(correspondingIndexPath?.section)][correspondingIndexPath?.row][kIsExpandedKey]?
            if expandableCell?.isExpandable {
                expandableCell?.expanded = isExpanded
                var expandableButton: UIButton? = (expandableCell?.accessoryView as? UIButton)
                expandableButton?.addTarget(tableView, action: Selector("expandableButtonTouched:event:"), for: .touchUpInside)
                if isExpanded != nil {
                    expandableCell?.accessoryView?.transform = CGAffineTransform(rotationAngle: .pi)
                }
                else {
                    if expandableCell?.containsIndicatorView() {
                        expandableCell?.removeIndicatorView()
                    }
                }
            }
            else {
                expandableCell?.expanded = false
                expandableCell?.accessoryView = nil
                expandableCell?.removeIndicatorView()
            }
            return expandableCell
        }
        else {
            var cell: UITableViewCell? = self.SKSTableViewDelegate.tableView((tableView as? SKSTableView), cellForSubRowAt: correspondingIndexPath)
            cell?.backgroundColor = self.separatorColor
            cell?.backgroundView = nil
            cell?.indentationLevel = 2
            return cell
        }
    }
    
    // MARK: YNTableViewUtils
    
    func numberOfExpandedSubrows(inSection section: Int) -> Int {
        var totalExpandedSubrows: Int = 0
        if let expandableCells = self.expandableCells {
            let rows = expandableCells[(section)] as! [NSMutableDictionary]
            for row in rows {
                if let isExpanded = row.object(forKey: YNTableView.kIsExpandedKey) as? Bool{
                    if isExpanded == true {
                        totalExpandedSubrows = row.object(forKey: YNTableView.kSubrowsKey) as! Int
                    }
                }
            }
        }
        return totalExpandedSubrows
    }
    
    @IBAction func expandableButtonTouched(_ sender: Any, event: Any) {
        var touches: Set<AnyHashable>? = (event as AnyObject).allTouches
        var touch: UITouch? = touches?.first as! UITouch?
        var currentTouchPosition: CGPoint? = touch?.location(in: self)
        var indexPath: IndexPath? = self.indexPathForRow(at: currentTouchPosition!)
        if indexPath != nil {
            self.ta
            self.tableView(self, accessoryButtonTappedForRowWithIndexPath: indexPath)
        }
    }
    
    func numberOfSubRows(at indexPath: IndexPath) -> Int {
        return self.yNDelegate!.tableView(self, numberOfSubRowsAt: indexPath)
    }
    
    

}
