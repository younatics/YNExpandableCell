//
//  YNTableViewExtenstion.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 18..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

extension YNTableView {
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let delegate = self.ynDelegate else { return nil }
        guard let titleForHeaderInSection = delegate.tableView?(self, titleForHeaderInSection: section) else { return nil }
        
        return titleForHeaderInSection
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let delegate = self.ynDelegate else { return CGFloat() }
        guard let heightForHeaderInSection = delegate.tableView?(self, heightForHeaderInSection: section) else { return CGFloat() }
        
        return heightForHeaderInSection
    }

}
