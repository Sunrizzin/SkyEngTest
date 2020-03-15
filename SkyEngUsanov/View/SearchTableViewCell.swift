//
//  SearchTableViewCell.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.backgroundColor = UIColor().randomColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
