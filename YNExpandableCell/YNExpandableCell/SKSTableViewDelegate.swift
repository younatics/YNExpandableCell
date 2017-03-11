//
//  SKSTableViewDelegate.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

protocol SKSTableViewDelegate: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: SKSTableView, numberOfSubRowsAt indexPath: IndexPath) -> Int
    
    func tableView(_ tableView: SKSTableView, cellForSubRowAt indexPath: IndexPath) -> UITableViewCell
    
}

extension SKSTableViewDelegate {
    func tableView(_ tableView: SKSTableView, heightForSubRowAt indexPath: IndexPath) -> CGFloat { return CGFloat() }
    
    func tableView(_ tableView: SKSTableView, shouldExpandSubRowsOfCellAt indexPath: IndexPath) -> Bool { return Bool() }
    
}
