//
//  YNTableViewDelegate.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

/// You need to set delegate and add only one method.
public protocol YNTableViewDelegate: UITableViewDelegate, UITableViewDataSource {
    
    /**
     Determine expandable cell in this view. This method is all that you have to do
     
     - Parameter tableView: YNTableView
     - Parameter expandCellAt: Determine expandable cell and return UITableViewCell
     */
    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell?
}
