//
//  SKSTableViewCellIndicator.swift
//  YNExpandableCell
//
//  Created by YiSeungyoun on 2017. 3. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

class SKSTableViewCellIndicator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var indicatorColor: UIColor!
    
//    func indicatorColor() -> UIColor {
//        return self.cellIndicatorColor
//    }
//    func indicatorColor(_ indicatorColor: UIColor) {
//        self.cellIndicatorColor = indicatorColor
//    }
    override func draw(_ rect: CGRect) {
        var context: CGContext? = UIGraphicsGetCurrentContext()
//        context.beginPath()
//        context.move(to: CGPoint(x: CGFloat(rect.minX), y: CGFloat(rect.maxY)))
//        context.addLine(to: CGPoint(x: CGFloat(rect.midX), y: CGFloat(rect.minY)))
//        context.addLine(to: CGPoint(x: CGFloat(rect.maxX), y: CGFloat(rect.maxY)))
//        context.closePath()
//        context.setFillColor(self.self.indicatorColor().cgColor)
//        context.fillPath()
    }
}
