//
//  YearTableViewCell.swift
//  Forecast
//
//  Created by Kishan nakum on 03/07/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class YearTableViewCell: UITableViewCell {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var yearLabel: UILabel!
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
