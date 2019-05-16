//
//  FormTitleSubtitleCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

public class FormTitleSubtitleCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let title: String
        let subTitle: String
        
        public init(title: String, subTitle: String) {
            self.title = title
            self.subTitle = subTitle
        }
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var topMargin: NSLayoutConstraint!
    @IBOutlet var bottomMargin: NSLayoutConstraint!
    @IBOutlet var verticalMargin: NSLayoutConstraint!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = CellStyle.shared.titleColor
        subTitleLabel.textColor = CellStyle.shared.subTitleColor
        titleLabel.font = CellStyle.shared.titleFont
        subTitleLabel.font = CellStyle.shared.subTitleFont
        
        topMargin.constant = CellStyle.shared.titleSubTitleTopMargin
        bottomMargin.constant = CellStyle.shared.titleSubTitleBottomMargin
        verticalMargin.constant = CellStyle.shared.titleSubTitleVerticalSpacing
    }
    
    public func update(_ data: Data) {
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.subTitle
    }

}
