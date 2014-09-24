//
//  TopicCell.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/24.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var replyNumber: UILabel!
    @IBOutlet weak var createTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
