//
//  YNExpandableDeprecated.swift
//  YNExpandableCell
//
//  Created by Seungyoun Yi on 2017. 3. 27..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation

extension YNTableViewDelegate {
    
    /**
     Get didSelectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Selected IndexPath
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    @available(*, deprecated, message: "use tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) instead")
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandedCell: Bool) { }
    
    
    /**
     Get didDeselectRowAt IndexPath and whether it is ExpandedCell or not
     
     - Parameter tableView: YNTableView
     - Parameter indexPath: Deselected IndexPath
     - Parameter isExpandedCell: Whether it is expandedCell or not
     */
    @available(*, deprecated, message: "use tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) instead")
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandedCell: Bool) { }
    

}
