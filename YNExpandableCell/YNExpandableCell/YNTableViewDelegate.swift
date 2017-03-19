//
//  YNTableViewDelegate.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import Foundation
import UIKit

public protocol YNTableViewDelegate: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell?
}

extension YNTableViewDelegate {
    
}
