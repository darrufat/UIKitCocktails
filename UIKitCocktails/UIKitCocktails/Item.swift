//
//  Item.swift
//  UIKitCocktails
//
//  Created by David Josep Arrufat Villalbos on 1/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
