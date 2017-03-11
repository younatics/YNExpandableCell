//
//  SKSTableView.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

// MARK: - SKSTableView
class SKSTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    let kIsExpandedKey = "isExpanded"
    let kSubrowsKey = "subrowsCount"
    let kDefaultCellHeight: CGFloat = 44.0

    var shouldExpandOnlyOneCell = false
    var expandableCells: NSMutableDictionary?
    
    var sksTableViewDelegate: SKSTableViewDelegate?
    
    var cellIndicator: SKSTableViewCellIndicator?
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.shouldExpandOnlyOneCell = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.shouldExpandOnlyOneCell = false
    }

    func setSKSTableViewDelegate(_ SKSTableViewDelegate: SKSTableViewDelegate) {
        self.dataSource = self
        self.delegate = self
        self.separatorColor = UIColor(red: CGFloat(236.0 / 255.0), green: CGFloat(236.0 / 255.0), blue: CGFloat(236.0 / 255.0), alpha: CGFloat(1.0))
        if (sksTableViewDelegate == nil) {
            self.sksTableViewDelegate = SKSTableViewDelegate
        }
    }
    func separatorColor(_ separatorColor: UIColor) {
        super.separatorColor = separatorColor
        
        cellIndicator = SKSTableViewCellIndicator()
        cellIndicator?.indicatorColor = separatorColor
    }
    func initExpandableCells() -> NSMutableDictionary? {
        if self.expandableCells == nil {
            self.expandableCells = NSMutableDictionary()
            guard let delegate = self.sksTableViewDelegate else { return nil }
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
                    let rowInfo = NSMutableDictionary(objects: [(isExpandedInitially), (numberOfSubrows)], forKeys: [kIsExpandedKey as NSCopying, kSubrowsKey as NSCopying])
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
    func refreshDataWithScrolling(to indexPath: IndexPath) {
        self.refreshData()
        if indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section) {
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    // MARK: - UITableViewDataSource
    // MARK: - Required
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sksTableViewDelegate!.tableView(tableView, numberOfRowsInSection: section) + self.numberOfExpandedSubrows(inSection: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
        if correspondingIndexPath?.subRow() == 0 {
            var expandableCell: SKSTableViewCell? = (self.SKSTableViewDelegate.tableView(tableView, cellForRowAt indexPath: correspondingIndexPath) as? SKSTableViewCell)
            if expandableCell?.responds(to: #selector(self.setSeparatorInset)) {
                expandableCell?.separatorInset = .zero
            }
            var isExpanded: Bool? = self.expandableCells()[(correspondingIndexPath?.section)][correspondingIndexPath?.row][kIsExpandedKey]?
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
            return expandableCell!
        }
        else {
            var cell: UITableViewCell? = self.SKSTableViewDelegate.tableView((tableView as? SKSTableView), cellForSubRowAt: correspondingIndexPath)
            cell?.backgroundColor = self.separatorColor
            cell?.backgroundView = nil
            cell?.indentationLevel = 2
            return cell!
        }
    }
    // MARK: - Optional
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.SKSTableViewDelegate.responds(to: #selector(self.numberOfSectionsInTableView)) {
            return self.SKSTableViewDelegate.numberOfSections(in tableView: tableView)
        }
        return 1
    }
    // MARK: - UITableViewDelegate
    // MARK: - Optional
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var cell: SKSTableViewCell? = (tableView.cellForRow(at: indexPath) as? SKSTableViewCell)
        if cell?.responds(to: #selector(self.expandableCells)) {
            if cell?.isExpandable {
                cell?.expanded = !cell?.isExpanded
                var indexPath: IndexPath? = indexPath
                var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
                if cell?.isExpanded && self.shouldExpandOnlyOneCell {
                    self.indexPath = correspondingIndexPath
                    self.collapseCurrentlyExpandedIndexPaths()
                }
                if self.indexPath {
                    var numberOfSubRows: Int = self.numberOfSubRows(at: correspondingIndexPath)
                    var expandedIndexPaths = [Any]()
                    var row: Int = self.indexPath.row
                    var section: Int = self.indexPath.section
                    for index in 1...numberOfSubRows {
                        var expIndexPath = IndexPath(row: row + index, section: section)
                        expandedIndexPaths.append(expIndexPath)
                    }
                    if cell?.isExpanded {
                        self.setExpanded(true, forCellAt: correspondingIndexPath)
                        self.insertRows(at: expandedIndexPaths, with: .top)
                    }
                    else {
                        self.setExpanded(false, forCellAt: correspondingIndexPath)
                        self.deleteRows(at: expandedIndexPaths, with: .top)
                    }
                    cell?.accessoryViewAnimation()
                }
            }
            if self.SKSTableViewDelegate.responds(to: Selector("tableView:didSelectRowAtIndexPath:")) {
                var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
                if correspondingIndexPath?.subRow == 0 {
                    self.SKSTableViewDelegate.tableView(tableView, didSelectRowAt indexPath: correspondingIndexPath)
                }
                else {
                    self.SKSTableViewDelegate.tableView(self, didSelectSubRowAt: correspondingIndexPath)
                }
            }
        }
        else {
            if self.SKSTableViewDelegate.responds(to: Selector("tableView:didSelectSubRowAtIndexPath:")) {
                var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
                self.SKSTableViewDelegate.tableView(self, didSelectSubRowAt: correspondingIndexPath)
            }
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: IndexPath) {
        if self.SKSTableViewDelegate.responds(to: Selector("tableView:accessoryButtonTappedForRowWithIndexPath:")) {
            self.SKSTableViewDelegate.tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
        }
        self.delegate.tableView(tableView, didSelectRowAt indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var correspondingIndexPath: IndexPath? = self.correspondingIndexPathForRow(at: indexPath)
        if correspondingIndexPath?.subRow() == 0 {
            if self.SKSTableViewDelegate.responds(to: Selector("tableView:heightForRowAtIndexPath:")) {
                return self.SKSTableViewDelegate.tableView(tableView, heightForRowAt indexPath: correspondingIndexPath)
            }
            return kDefaultCellHeight
        }
        else {
            if self.SKSTableViewDelegate.responds(to: Selector("tableView:heightForSubRowAtIndexPath:")) {
                return self.SKSTableViewDelegate.tableView(self, heightForSubRowAt: correspondingIndexPath)
            }
            return kDefaultCellHeight
        }
    }
    // MARK: - SKSTableViewUtils
    func numberOfExpandedSubrows(inSection section: Int) -> Int {
        var totalExpandedSubrows: Int = 0
        var rows: [Any] = self.expandableCells()[(section)]
        for row: Any in rows {
            if row[kIsExpandedKey] == true {
                totalExpandedSubrows += CInt(row[kSubrowsKey])
            }
        }
        return totalExpandedSubrows
    }
    @IBAction func expandableButtonTouched(_ sender: Any, event: Any) {
        let touches: Set<AnyHashable>? = (event as AnyObject).allTouches
        let touch: UITouch? = touches?.first as! UITouch?
        let currentTouchPosition: CGPoint? = touch?.location(in: self)
        let indexPath: IndexPath? = self.indexPathForRow(at: currentTouchPosition!)
        if indexPath != nil {
            self.tableView(self, accessoryButtonTappedForRowWithIndexPath: indexPath!)
        }
    }
    func numberOfSubRows(at indexPath: IndexPath) -> Int {
        return self.sksTableViewDelegate.tableView(self, numberOfSubRowsAt: indexPath)
    }
    func correspondingIndexPathForRow(at indexPath: IndexPath) -> IndexPath {
        var correspondingIndexPath: IndexPath? = nil
        var expandedSubrows: Int = 0
        var rows: [Any] = self.expandableCells[(indexPath.section)]
        (rows as NSArray).enumerateObjects(usingBlock: {(_ obj: Any, _ idx: Int, _ stop: Bool) -> Void in
            var isExpanded: Bool = obj[kIsExpandedKey]
            var numberOfSubrows: Int = 0
            if isExpanded {
                numberOfSubrows = CInt(obj[kSubrowsKey])
            }
            var subrow: Int = indexPath.row - expandedSubrows - idx
            if subrow > numberOfSubrows {
                expandedSubrows += numberOfSubrows
            }
            else {
                correspondingIndexPath = IndexPath(for: subrow, inRow: idx, inSection: indexPath.section)
                stop = true
            }
        })
        return correspondingIndexPath!
    }
    func setExpanded(_ isExpanded: Bool, forCellAt indexPath: IndexPath) {
        var cellInfo: [AnyHashable: Any] = self.expandableCells()[(indexPath.section)][indexPath.row]
        cellInfo[kIsExpandedKey] = (isExpanded)
    }
    func collapseCurrentlyExpandedIndexPaths() {
        var totalExpandedIndexPaths = [Any]()
        var totalExpandableIndexPaths = [Any]()
        self.expandableCells().enumerateKeysAndObjects(usingBlock: {(_ key: Any, _ obj: Any, _ stop: Bool) -> Void in
            var totalExpandedSubrows: Int = 0
            (obj as NSArray).enumerateObjects(usingBlock: {(_ obj: Any, _ idx: Int, _ stop: Bool) -> Void in
                var currentRow: Int = idx + totalExpandedSubrows
                var isExpanded: Bool = obj[kIsExpandedKey]
                if isExpanded {
                    var expandedSubrows = CInt(obj[kSubrowsKey])
                    for index in 1...expandedSubrows {
                        var expandedIndexPath = IndexPath(row: currentRow + index, section: CInt(key))
                        totalExpandedIndexPaths.append(expandedIndexPath)
                    }
                    obj[kIsExpandedKey] = (false)
                    totalExpandedSubrows += expandedSubrows
                    totalExpandableIndexPaths.append(IndexPath(row: currentRow, section: CInt(key)))
                }
            })
        })
        for indexPath: IndexPath in totalExpandableIndexPaths {
            var cell: SKSTableViewCell? = (self.cellForRow(at: indexPath) as? SKSTableViewCell)
            cell?.expanded = false
            cell?.accessoryViewAnimation()
        }
        self.deleteRows(at: totalExpandedIndexPaths, with: .top)
    }
}
// MARK: - NSIndexPath (SKSTableView)
var SubRowObjectKey: Any?

extension IndexPath {
    func subRow() -> Int {
        let subRowObj: Any? = objc_getAssociatedObject(self, SubRowObjectKey as! UnsafeRawPointer!)
        return subRowObj as! Int
    }
    func setSubRow(_ subRow: Int) {
        var subRowObj: Any? = Int(subRow)
        objc_setAssociatedObject(self, SubRowObjectKey as! UnsafeRawPointer!, subRowObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    init(for subrow: Int, inRow row: Int, inSection section: Int) {
        var indexPath = IndexPath(row: row, section: section)
        indexPath.subRow = subrow
        return indexPath
    }
}
