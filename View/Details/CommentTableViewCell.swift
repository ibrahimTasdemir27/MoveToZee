//
//  CommentTableViewCell.swift
//  MoveToZee
//
//  Created by haliliboswift on 9.08.2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
