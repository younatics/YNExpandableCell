//
//  YNTableView.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

/// Inherit this tableView to use YNExpandableCell
open class YNTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private var expandedIndexPaths = [IndexPath]()

    /// Set ynDelegate to use this tableview
    open var ynDelegate: YNTableViewDelegate? {
        didSet {
            self.delegate = self
            self.dataSource = self
        }
    }
    
    /// Simple UITableViewRowAnimation
    open var ynTableViewRowAnimation = UITableViewRowAnimation.top

    /// Called in Nib
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    /// Init method
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    /// Init coder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //PRAGMA MARK: YNTableView Method

    /**
     Register cells with array of strings
     
     - Parameter nibNames: [String]
     - Parameter reuseIdentifiers: [String]
     */
    open func registerCellsWith(nibNames: [String], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: nibNames, second: reuseIdentifiers)
        
        for i in 0..<nibNames.count {
            self.register(UINib(nibName: nibNames[i], bundle: nil), forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    /**
     Register cells with array of cells and strings
     
     - Parameter cells: [AnyClass]
     - Parameter reuseIdentifiers: [String]
     */
    open func registerCellsWith(cells: [AnyClass], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: cells, second: reuseIdentifiers)
        
        for i in 0..<cells.count {
            self.register(cells[i], forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    /// Expand all cell
    open func expandAll() {
        guard let delegate = self.ynDelegate else { return }
        let numberOfSections = self.numberOfSections(in: self)
        
        var tempExpandedIndexPaths = [IndexPath]()
        for section in 0..<numberOfSections {
            let rowCount = self.tableView(self, numberOfRowsInSection: section)
            for row in 0..<rowCount {
                let indexPath = IndexPath(row: row, section: section)

                let selectedIndexPath = IndexPath(row: indexPath.row - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
                if (delegate.tableView(self, expandCellAt: selectedIndexPath)) != nil && !tempExpandedIndexPaths.contains(selectedIndexPath) {
                    tempExpandedIndexPaths.append(selectedIndexPath)
                } else if (delegate.tableView(self, expandCellWithHeightAt: selectedIndexPath)) != nil && !tempExpandedIndexPaths.contains(selectedIndexPath) {
                    tempExpandedIndexPaths.append(selectedIndexPath)
                }
            }
        }
        guard tempExpandedIndexPaths.count > 0 else { return }
        var tempSelectedRowCount = 0
        var tempSelectedSection = tempExpandedIndexPaths[0].section
        var addedExpandedIndexPath = IndexPath()
        
        for i in 0..<tempExpandedIndexPaths.count {
            if i == 0 {
                addedExpandedIndexPath = IndexPath(row: tempExpandedIndexPaths[i].row + 1 + tempSelectedRowCount, section: tempExpandedIndexPaths[i].section)
            } else {
                if tempExpandedIndexPaths[i].section == tempSelectedSection {
                    tempSelectedRowCount += 1
                    addedExpandedIndexPath = IndexPath(row: tempExpandedIndexPaths[i].row + 1 + tempSelectedRowCount, section: tempExpandedIndexPaths[i].section)
                } else {
                    tempSelectedSection = tempExpandedIndexPaths[i].section
                    tempSelectedRowCount = 0
                    addedExpandedIndexPath = IndexPath(row: tempExpandedIndexPaths[i].row + 1 + tempSelectedRowCount, section: tempExpandedIndexPaths[i].section)
                }
            }
            
            if !self.expandedIndexPaths.contains(addedExpandedIndexPath) && self.expandedIndexPaths.count != tempExpandedIndexPaths.count {
                let internalIndexPath = IndexPath(row: addedExpandedIndexPath.row - 1, section: addedExpandedIndexPath.section)
                self.didSelectRowLogicAt(indexPath: internalIndexPath)
                self.selectRow(at: internalIndexPath, animated: true, scrollPosition: .none)
            }
        }
    }
    
    /// Collapse all cell
    open func collapseAll() {
        while self.expandedIndexPaths.count > 0{
            let internalIndexPath = IndexPath(row: self.expandedIndexPaths[0].row - 1, section: self.expandedIndexPaths[0].section)
            self.didDeselectRowLogicAt(expandedIndexPath: self.expandedIndexPaths[0], indexPath: internalIndexPath)
            self.deselectRow(at: internalIndexPath, animated: true)
        }
    }
    
    //PRAGMA MARK: YNTableView Delegate
    
    /// Overide tableview reloadData
    open override func reloadData() {
        super.reloadData()
        for expandedIndexPath in expandedIndexPaths {
            let internalIndexPath = IndexPath(row: expandedIndexPath.row-1, section: expandedIndexPath.section)
            self.selectRow(at: internalIndexPath, animated: true, scrollPosition: .none)
        }
    }
    /// Basic UITableViewDelegate: func numberOfSections(in tableView: UITableView) -> Int
    open func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate = self.ynDelegate else { return Int() }
        guard let numberOfSection = delegate.numberOfSections?(in: self) else { return Int() }
        return numberOfSection
    }
    
    /// Basic UITableViewDelegate: func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate = self.ynDelegate else { return Int() }
        
        return delegate.tableView(self, numberOfRowsInSection: section) + self.checkExpandRowIn(section: section)
    }
    
    /// Basic UITableViewDelegate: func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = self.ynDelegate else { return UITableViewCell() }
        
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath == indexPath {
                let internalIndexPath = IndexPath(row: indexPath.row - 1 - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
                if let cell = delegate.tableView(self, expandCellAt: internalIndexPath) {
                    return cell
                } else if let cell = delegate.tableView(self, expandCellWithHeightAt: internalIndexPath)?.cell {
                    return cell
                }
            }
        }
        
        let internalIndexPath = IndexPath(row: indexPath.row - self.expandedRowCountSince(current: indexPath), section: indexPath.section)

        if let ynExpandableCell = delegate.tableView(self, cellForRowAt: internalIndexPath) as? YNExpandableCell {
            let checkSelectedIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if self.expandedIndexPaths.contains(checkSelectedIndexPath) {
                ynExpandableCell.selected()
                return ynExpandableCell
            }
        }
        return delegate.tableView(self, cellForRowAt: internalIndexPath)
        
    }
    
    /// Basic UITableViewDelegate: func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.ynDelegate else { return }
        
        let selectedIndexPath = IndexPath(row: indexPath.row - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
        if (delegate.tableView(self, expandCellAt: selectedIndexPath)) != nil || (delegate.tableView(self, expandCellWithHeightAt: selectedIndexPath)) != nil {
            
            var sameIndexPathExists = false
            for expandedIndexPath in self.expandedIndexPaths {
                if indexPath == expandedIndexPath {
                    sameIndexPathExists = true
                }
            }
            if !sameIndexPathExists {
                self.didSelectRowLogicAt(indexPath: indexPath)
                delegate.tableView(self, didSelectRowAt: indexPath, isExpandableCell: true, isExpandedCell: false)
                return
            }
            
            if self.expandedIndexPaths.isEmpty {
                self.didSelectRowLogicAt(indexPath: indexPath)
                delegate.tableView(self, didSelectRowAt: indexPath, isExpandableCell: true, isExpandedCell: false)
                return
            }
            delegate.tableView(self, didSelectRowAt: indexPath, isExpandableCell: false, isExpandedCell: true)
            
        } else if self.expandedIndexPaths.contains(indexPath) {
            delegate.tableView(self, didSelectRowAt: indexPath, isExpandableCell: false, isExpandedCell: true)
        } else {
            delegate.tableView(self, didSelectRowAt: indexPath, isExpandableCell: false, isExpandedCell: false)
        }
    }
    
    /// Basic UITableViewDelegate: func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let delegate = self.ynDelegate else { return }

        for expandedIndexPath in self.expandedIndexPaths {
            let internalIndexPath =  IndexPath(row: expandedIndexPath.row - 1, section: expandedIndexPath.section)
            
            if expandedIndexPath == indexPath {
                delegate.tableView(self, didDeselectRowAt: indexPath, isExpandableCell: false, isExpandedCell: true)
                return
            }
            if internalIndexPath == indexPath {
                self.didDeselectRowLogicAt(expandedIndexPath: expandedIndexPath, indexPath: indexPath)
                delegate.tableView(self, didDeselectRowAt: indexPath, isExpandableCell: true, isExpandedCell: false)
                return
            }
        }
        
        delegate.tableView(self, didDeselectRowAt: indexPath, isExpandableCell: false, isExpandedCell: false)
    }
    
    /// Basic UITableViewDelegate: tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let delegate = self.ynDelegate else { return 44 }
        
        var height:CGFloat = 0
        if let normalHeight = delegate.tableView?(self, heightForRowAt: indexPath) {
            height = normalHeight
        }

        for expandedIndexPaths in self.expandedIndexPaths {
            if indexPath == expandedIndexPaths {
                let selectedIndexPath = IndexPath(row: indexPath.row - 1 - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
                if let _height = delegate.tableView(self, expandCellWithHeightAt: selectedIndexPath)?.height {
                    height = _height
                }
            }
        }
        return height
    }

    /// Basic UITableViewDelegate: func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //PRAGMA MARK: YNTableView Logic
    private func checkExpandRowIn(section: Int) -> Int {
        var openedCellCount = 0
        
        for expandedIndexPaths in self.expandedIndexPaths {
            if expandedIndexPaths.section == section {
                openedCellCount += 1
            }
        }
        
        return openedCellCount
    }
    
    private func didDeselectRowLogicAt(expandedIndexPath: IndexPath, indexPath: IndexPath) {
        let index = self.expandedIndexPaths.index(of: expandedIndexPath)
        guard let _index = index else { return }
        self.expandedIndexPaths.remove(at: _index)
        self.deleteRows(at: [expandedIndexPath], with: .top)
        self.expandedIndexPathsDeselectAfter(current: indexPath)
        
        guard let ynExpandableCell = cellForRow(at: indexPath) as? YNExpandableCell else { return }
        ynExpandableCell.normal()

    }


    private func didSelectRowLogicAt(indexPath: IndexPath) {
        let insertIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        self.expandedIndexPaths.append(insertIndexPath)
        self.insertRows(at: [insertIndexPath], with: .top)
        self.expandedIndexPathsSelectAfter(current: indexPath)
        
        guard let ynExpandableCell = cellForRow(at: indexPath) as? YNExpandableCell else { return }
        ynExpandableCell.selected()
    }

    private func expandedIndexPathsSelectAfter(current indexPath: IndexPath) {
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath.section == indexPath.section {
                if expandedIndexPath.row > indexPath.row + 1 {
                    let index = self.expandedIndexPaths.index(of: expandedIndexPath)
                    guard let _index = index else { return }
                    
                    let indexPath = IndexPath(row: expandedIndexPath.row + 1, section: expandedIndexPath.section)
                    self.expandedIndexPaths[_index] = indexPath
                    
                }
            }
        }
    }
    
    private func expandedIndexPathsDeselectAfter(current indexPath: IndexPath) {
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath.section == indexPath.section {
                if expandedIndexPath.row > indexPath.row {
                    let index = self.expandedIndexPaths.index(of: expandedIndexPath)
                    guard let _index = index else { return }
                    
                    let indexPath = IndexPath(row: expandedIndexPath.row - 1, section: expandedIndexPath.section)
                    self.expandedIndexPaths[_index] = indexPath
                    
                }
            }
        }
    }
    
    private func expandedRowCountSince(current indexPath: IndexPath) -> Int {
        var expandCount = 0
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath.section == indexPath.section {
                if expandedIndexPath.row < indexPath.row {
                    expandCount += 1
                }
            }
        }

        return expandCount
    }
    
    private func checkValueIsSame(first: [Any], second: [Any]) {
        if first.count != second.count {
            fatalError("Make first and second value count same")
        }
    }
    
    private func initView() {
        self.allowsMultipleSelection = true
    }
    
}
