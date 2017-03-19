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
    private var expandedIndexPaths = [IndexPath]()

    open var ynDelegate: YNTableViewDelegate? {
        didSet {
            self.delegate = self
            self.dataSource = self
        }
    }
    
    open var ynTableViewRowAnimation = UITableViewRowAnimation.top
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.initView()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func registerCellsWith(nibNames: [String], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: nibNames, second: reuseIdentifiers)
        
        for i in 0..<nibNames.count {
            self.register(UINib(nibName: nibNames[i], bundle: nil), forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    public func registerCellsWith(cells: [AnyClass], and reuseIdentifiers: [String]) {
        self.checkValueIsSame(first: cells, second: reuseIdentifiers)
        
        for i in 0..<cells.count {
            self.register(cells[i], forCellReuseIdentifier: reuseIdentifiers[i])
        }
    }
    
    private func checkExpandRowIn(section: Int) -> Int {
        var openedCellCount = 0
        
        for expandedIndexPaths in self.expandedIndexPaths {
            if expandedIndexPaths.section == section {
                openedCellCount += 1
            }
        }
        
        return openedCellCount
    }
    
    //PRAGMA MARK: YNTableView Delegate
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate = self.ynDelegate else { return Int() }
        guard let numberOfSection = delegate.numberOfSections?(in: self) else { return Int() }
        return numberOfSection
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let delegate = self.ynDelegate else { return Int() }
        
        return delegate.tableView(self, numberOfRowsInSection: section) + self.checkExpandRowIn(section: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = self.ynDelegate else { return UITableViewCell() }
        
        for expandedIndexPath in self.expandedIndexPaths {
            if expandedIndexPath == indexPath {
                let internalIndexPath = IndexPath(row: indexPath.row - 1 - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
                guard let cell = delegate.tableView(self, expandCellAt: internalIndexPath) else { return UITableViewCell() }
                return cell
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.ynDelegate else { return }
        
        let selectedIndexPath = IndexPath(row: indexPath.row - self.expandedRowCountSince(current: indexPath), section: indexPath.section)
        guard (delegate.tableView(self, expandCellAt: selectedIndexPath)) != nil else { return }
        
        var sameIndexPathExists = false
        for expandedIndexPath in self.expandedIndexPaths {
            if indexPath == expandedIndexPath {
                sameIndexPathExists = true
            }
        }
        
        if !sameIndexPathExists {
            self.didSelectRowLogicAt(indexPath: indexPath)
        }
        
        if self.expandedIndexPaths.isEmpty {
            self.didSelectRowLogicAt(indexPath: indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        for expandedIndexPath in self.expandedIndexPaths {
            let internalIndexPath =  IndexPath(row: expandedIndexPath.row - 1, section: expandedIndexPath.section)
            
            if internalIndexPath == indexPath {
                let index = self.expandedIndexPaths.index(of: expandedIndexPath)
                guard let _index = index else { return }
                self.expandedIndexPaths.remove(at: _index)
                self.deleteRows(at: [expandedIndexPath], with: .top)
                self.expandedIndexPathsDeselectAfter(current: indexPath)
                
                guard let ynExpandableCell = cellForRow(at: indexPath) as? YNExpandableCell else { return }
                ynExpandableCell.normal()

            }
        }
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //PRAGMA MARK: YNTableView Logic
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
