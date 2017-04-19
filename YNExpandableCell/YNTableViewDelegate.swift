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
     Determine expandable cell in this view. you can add height in YNTableViewCell object.
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Determine expandable cell and return UITableViewCell
     */
    func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell?
    
    /**
     Get didSelectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Selected IndexPath
     - Parameter isExpandableCell: Whether it is expandableCell or not
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool)
    
    /**
     Get didDeselectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Deselected IndexPath
     - Parameter isExpandableCell: Whether it is expandableCell or not
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool)
    
}

public extension YNTableViewDelegate {
    /**
     Determine expandable cell in this view. This method is all that you have to do
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Determine expandable cell and return UITableViewCell
     */
    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? { return nil }

    /**
     Determine expandable cell in this view. you can add height in YNTableViewCell object.
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Determine expandable cell and return UITableViewCell
     */
    func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell? { return nil }

    /**
     Get didSelectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Selected IndexPath
     - Parameter isExpandableCell: Whether it is expandableCell or not
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) { }

    /**
     Get didDeselectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Deselected IndexPath
     - Parameter isExpandableCell: Whether it is expandableCell or not
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) { }
    
}
