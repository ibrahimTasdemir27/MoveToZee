//
//  FavoriteTableViewCell.swift
//  MoveToZee
//
//  Created by haliliboswift on 1.08.2022.
//

import UIKit
import CoreData

class FavoriteTableViewCell: UITableViewCell {
    
   

    @IBOutlet weak var favoriteDetailLabel: UILabel!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }


    
    
}
