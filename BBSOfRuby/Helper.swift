//
//  Helper.swift
//  BBSOfRuby
//
//  Created by gxw on 14/10/21.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class Helper: NSObject {
    class func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}