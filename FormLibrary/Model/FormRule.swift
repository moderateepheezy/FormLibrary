//
//  FormRule.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

struct FormRule: Codable {
    let condition, value, action, otherwise: String
    let targets: [String]
}
