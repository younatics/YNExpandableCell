//
//  YNTableViewDelegate.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

public protocol YNTableViewDelegate: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: YNTableView, numberOfSubRowsAt indexPath: IndexPath) -> Int
    
    func tableView(_ tableView: YNTableView, cellForSubRowAt indexPath: IndexPath) -> UITableViewCell
    
}

extension YNTableViewDelegate {
    func tableView(_ tableView: YNTableView, heightForSubRowAt indexPath: IndexPath) -> CGFloat { return CGFloat() }

    func tableView(_ tableView: YNTableView, shouldExpandSubRowsOfCellAt indexPath: IndexPath) -> Bool { return Bool() }
    
}
