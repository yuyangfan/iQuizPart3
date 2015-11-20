//
//  QuizTableViewCell.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/3/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptions: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
