//
//  FormSectionTitleCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

public class FormSectionTitleCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let title: String
        public init(title: String) {
            self.title = title
        }
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!

    override public func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel.textColor = CellStyle.shared.sectionTitleColor
        self.titleLabel.font = CellStyle.shared.sectionTitleFont
        
        self.topConstraint.constant = CellStyle.shared.sectionTitleTopMargin
        self.bottomConstraint.constant = CellStyle.shared.sectionTitleBottomMargin
    }

    func update(_ data: Data) {
        titleLabel.text = data.title
    }
    
}
