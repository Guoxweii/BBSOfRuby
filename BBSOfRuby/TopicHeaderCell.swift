//
//  TopicHeaderCell.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/25.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class TopicHeaderCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
