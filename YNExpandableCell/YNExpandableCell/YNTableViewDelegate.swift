//
//  YNTableViewDelegate.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

public protocol YNTableViewDelegate {
    func tableView(_ tableView: YNTableView, numberOfSubRowsAtIndexPath indexPath: IndexPath) -> Int
    
    func tableView(_ tableView: YNTableView, cellForSubRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    
    
    
}

extension YNTableViewDelegate {
    func tableView(_ tableView: YNTableView, heightForSubRowAtIndexPath indexPath: IndexPath) -> CGFloat { return CGFloat() }

    func tableView(_ tableView: YNTableView, shouldExpandSubRowsOfCellAtIndexPath indexPath: IndexPath) -> Bool { return Bool() }
    
}
