//
//  ResultTableViewCell.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.backgroundColor = UIColor().randomColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
