//
//  GridCell.swift
//  InfluxTestWork
//
//  Created by santhosh t on 21/12/22.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var messageBoxView: UIView!
    @IBOutlet weak var messageBoxSubView: UIView!
    @IBOutlet weak var triangleViewRight: UIView!
    @IBOutlet weak var triangleViewLeft: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var rightArrowHeight: NSLayoutConstraint!
    @IBOutlet weak var leftArrowHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var sizeView: UILabel!
    @IBOutlet weak var detailsView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 5
        messageBoxSubView.layer.cornerRadius = 5
        
        setUpTriangle(view:triangleViewRight)
        setUpTriangle(view:triangleViewLeft)
        
        triangleViewRight.isHidden = true
        triangleViewLeft.isHidden = true
    }
    
    func setUpTriangle(view:UIView){
        let heightWidth = view.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = #colorLiteral(red: 0, green: 0.4078922272, blue: 1, alpha: 1)
        
        view.layer.insertSublayer(shape, at: 0)
    }
    
    func configure(data: GridItems)
    {
        
        if data.selactionFlag!
        {
            //selectedItemId = data.id!
            mainView.layer.borderWidth = 2
            mainView.layer.borderColor = #colorLiteral(red: 0, green: 0.4078922272, blue: 1, alpha: 1)
            mainView.clipsToBounds = true
        }
        else
        {
            mainView.layer.borderWidth = 0
            mainView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            mainView.clipsToBounds = true
        }
        
        if data.messageBoxFlag!
        {
            if data.showFlag!
            {
                mainView.isHidden = true
                messageBoxView.isHidden = false
                rightArrowHeight.constant = 20
                leftArrowHeight.constant = 20
                
                nameView.text = data.title
                sizeView.text = data.subTitle
                detailsView.text = data.message
                
                if data.selactionIndex == 0
                {
                    //is odd number
                    triangleViewRight.isHidden = true
                    triangleViewLeft.isHidden = false
                }
                else
                {
                    //is even number
                    triangleViewRight.isHidden = false
                    triangleViewLeft.isHidden = true
                }
            }
            else
            {
                rightArrowHeight.constant = 0
                leftArrowHeight.constant = 0
                
                mainView.isHidden = true
                messageBoxView.isHidden = true
                triangleViewRight.isHidden = true
                triangleViewLeft.isHidden = true
            }
        }
        else
        {
            mainView.isHidden = false
            messageBoxView.isHidden = true
            
            triangleViewRight.isHidden = true
            triangleViewLeft.isHidden = true
        }
    }
    
}
