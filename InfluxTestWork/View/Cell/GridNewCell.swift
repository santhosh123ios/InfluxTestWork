//
//  GridNewCell.swift
//  InfluxTestWork
//
//  Created by santhosh t on 23/12/22.
//

import UIKit

class GridNewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(selaction_data: GridSelectionModel)
    {
        if selaction_data.selactionFlag!
        {
            mainView.layer.borderWidth = 2
            mainView.layer.borderColor = #colorLiteral(red: 0, green: 0.4078922272, blue: 1, alpha: 1)
            mainView.clipsToBounds = true
        }
        else
        {
            mainView.layer.borderWidth = 0
            mainView.layer.borderColor = #colorLiteral(red: 0, green: 0.4078922272, blue: 1, alpha: 1)
            mainView.clipsToBounds = true
        }
    }

}
