//
//  CommentCell.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/25.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
