//
//  File.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

protocol FormCell {}

extension FormCell {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
}

