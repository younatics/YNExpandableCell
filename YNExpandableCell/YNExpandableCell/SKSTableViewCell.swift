//
//  SKSTableViewCell.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

let kIndicatorViewTag = -1
class SKSTableViewCell: UITableViewCell {
    var expandable = false
    var expanded = false
    
    static var image: UIImage?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style, reuseIdentifier: reuseIdentifier)
        
        self.expandable = true
        self.expanded = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.expanded {
            if !self.containsIndicatorView() {
                self.addIndicatorView()
            }
            else {
                self.removeIndicatorView()
                self.addIndicatorView()
            }
        }
    }
    var cellImage: UIImage? = nil
    func expandableView() -> UIView? {
        if self.cellImage == nil {
            self.cellImage = UIImage(named: "expandableImage.png")
        }
        
        guard let cellImage = self.cellImage else { return nil }
        let button = UIButton(type: .custom)
        let frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(cellImage.size.width), height: CGFloat(cellImage.size.height))
        button.frame = frame
        button.setBackgroundImage(self.cellImage, for: .normal)
        return button
    }
    func isExpandable(_ isExpandable: Bool) {
        if isExpandable {
            self.accessoryView = self.expandableView()
        }
        self.expandable = isExpandable
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func addIndicatorView() {
        let point = self.accessoryView?.center
        let bounds = self.accessoryView?.bounds
        
        guard let _point = point else { return }
        guard let _bounds = bounds else { return }
        
        let frame = CGRect(x: CGFloat((_point.x - _bounds.width * 1.5)), y: CGFloat(_point.y * 1.4), width: CGFloat(_bounds.width * 3.0), height: CGFloat(_bounds.height - _point.y * 1.4))
        let indicatorView = SKSTableViewCellIndicator(frame: frame)
        indicatorView.tag = kIndicatorViewTag
        self.contentView.addSubview(indicatorView)
    }
    func removeIndicatorView() {
        var indicatorView: Any? = self.contentView.viewWithTag(kIndicatorViewTag)
        if indicatorView != nil {
            (indicatorView as AnyObject).removeFromSuperview()
            indicatorView = nil
        }
    }
    func containsIndicatorView() -> Bool {
        return (self.contentView.viewWithTag(kIndicatorViewTag) != nil) ? true : false
    }
    func accessoryViewAnimation() {
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            if self.expanded {
                self.accessoryView?.transform = CGAffineTransform(rotationAngle: .pi)
            }
            else {
                self.accessoryView?.transform = CGAffineTransform(rotationAngle: 0)
            }
        }, completion: {(_ finished: Bool) -> Void in
            if !self.expanded {
                self.removeIndicatorView()
            }
        })
    }
}
