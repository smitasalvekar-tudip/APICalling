//
//  StructureTableViewCell.swift
//  APICalling
//
//  Created by TudipTech on 27/01/22.
//

import UIKit

class StructureTableViewCell: UITableViewCell {
    @IBOutlet weak var structImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
