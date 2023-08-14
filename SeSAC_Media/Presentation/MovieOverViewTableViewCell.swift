//
//  MovieOverViewTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/14.
//

import UIKit

class MovieOverViewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(text: String){
        overviewLabel.text = text
    }
    
}
