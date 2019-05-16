//
//  FormButtonCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate {
    
    func formButtonCellPressed(_ cell: FormButtonCell)
    
}

public class FormButtonCell: UICollectionViewCell, FormCell {
    
    
    @IBOutlet var button: FormButton!
    
    var delegate: ButtonCellDelegate?
    
    public class Data: CellData {
        let title: String
        public init(title: String) {
            self.title = title
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func update(_ data: Data) {
        button.setTitle(data.title, for: .normal)
    }
    
    @IBAction func buttonPressed(_ button: UIButton) {
        self.delegate?.formButtonCellPressed(self)
    }

}
