//
//  FilterItem.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import Foundation
struct FilterItem: Identifiable
{
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}
