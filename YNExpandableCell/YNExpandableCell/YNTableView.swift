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
    open var ynDelegate: YNTableViewDelegate? {
        didSet {
            self.delegate = self
            self.dataSource = self

        }
    }
    
    private var openedIndexPaths: [IndexPath]?
    
    var openedCellCount = 0
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    public func initData() {
        
    }
    
    func checkIndexPathisInRow(section: Int) -> Int {
        var openedCellCount = 0
        
        guard let openedIndexPaths = self.openedIndexPaths else { return Int() }
        
        for openedIndexPath in openedIndexPaths {
            if openedIndexPath.section == section {
                
            }
        }
    }
    
    //PRAGMA MARK: YNTableView Delegate
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate = self.ynDelegate else { return Int() }
        guard let numberOfSection = delegate.numberOfSections?(in: self) else { return Int() }
        return numberOfSection
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let delegate = self.ynDelegate else { return Int() }
        guard let openedIndexPath = self.openedIndexPaths else { return Int() }
        
        return delegate.tableView(self, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = self.ynDelegate else { return UITableViewCell() }
        return delegate.tableView(self, cellForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.ynDelegate else { return }
        
        if delegate.tableView(self, cellForRowAt: indexPath) is YNExpandableCell {
//            let insertIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)

            self.insertRows(at: [indexPath], with: .top)
            self.openedIndexPaths?.append(indexPath)
        }
        //TDDO: Check TableViewCell and if it right, insert indexpath. -> Make internal array for TableView -> Make method for openablecell
    }
    
    private func checkValueIsSame(first: [Any], second: [Any]) {
        if first.count != second.count {
            fatalError("Make first and second value count same")
        }
    }
    
    internal func initView() {
    }
    

}
