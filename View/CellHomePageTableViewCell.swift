//
//  CellHomePageTableViewCell.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import UIKit

class CellHomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var titlePosterHome: UILabel!
    @IBOutlet weak var detailPosterHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
