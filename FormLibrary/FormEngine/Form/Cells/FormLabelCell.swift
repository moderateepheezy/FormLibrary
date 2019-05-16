//
//  FormLabelCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//


import UIKit

public class FormLabelCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let text: NSAttributedString
        
        public init(text: NSAttributedString) {
            self.text = text
        }
    }

    //MARK: - IBOutlets
    @IBOutlet var text: UILabel!
    
    //MARK: - Functions
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        text.textColor = CellStyle.shared.fieldTitleColor
        
    }
    
    public func update(_ data: Data) {
        text.attributedText = data.text
    }

}
