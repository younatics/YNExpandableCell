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
     - Parameter indexPath: Determine expandable cell and return UITableViewCell
     */
    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell?
    
    /**
     Get didSelectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Selected IndexPath
     - Parameter expandCellAt: Whether it is ExpandedCell or not
     */
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandedCell: Bool)
    
    /**
     Get didDeselectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Deselected IndexPath
     - Parameter expandCellAt: Whether it is ExpandedCell or not
     */
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandedCell: Bool)


}

extension YNTableViewDelegate {
    /**
     Get didSelectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Selected IndexPath
     - Parameter expandCellAt: Whether it is ExpandedCell or not
     */
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandedCell: Bool) { }

    /**
     Get didDeselectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Deselected IndexPath
     - Parameter expandCellAt: Whether it is ExpandedCell or not
     */
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandedCell: Bool) { }
    
}
