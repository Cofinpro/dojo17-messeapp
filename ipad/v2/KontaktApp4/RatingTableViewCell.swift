//
//  RatingTableViewCell.swift
//  KontaktApp4
//
//  Created by Daniel Corak on 09.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    var indexPath: IndexPath? {
        return (superview as? UITableView)?.indexPath(for: self)
    }
}

class RatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var comment: UITextField!
    
    @IBOutlet weak var infoButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
