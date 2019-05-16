//
//  FormButton.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//


import UIKit

class FormButton: UIButton {
    
    private var inverse = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = CellStyle.shared.fieldCornerRadius
        self.layer.borderWidth = CellStyle.shared.fieldBorderWidth
        self.titleLabel?.font = CellStyle.shared.fieldButtonFont
        self.layer.borderColor = CellStyle.shared.fieldBorderColor.cgColor
        if inverse {
            self.setTitleColor(.white, for: .normal)
            self.setTitleColor(CellStyle.shared.buttonLabelColor, for: .highlighted)
            self.backgroundColor = CellStyle.shared.fieldBorderColor
        } else {
            self.setTitleColor(CellStyle.shared.buttonLabelColor, for: .normal)
            self.setTitleColor(.white, for: .highlighted)
            self.backgroundColor = .white
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if inverse {
                self.backgroundColor = isHighlighted ? UIColor.white : CellStyle.shared.fieldBorderColor
            } else {
                self.backgroundColor = isHighlighted ? CellStyle.shared.fieldBorderColor : UIColor.white
            }
        }
    }
    
    public func setInverse(_ inverse: Bool) {
        self.inverse = inverse
        commonInit()
    }

}
