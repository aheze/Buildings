//
//  Models.swift
//  Buildings
//
//  Created by A. Zheng (github.com/aheze) on 3/28/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    

import SwiftUI

struct Dot: Identifiable {
    let id = UUID()
    var color: UIColor
    var length: CGFloat
    var location: CGPoint
}

struct Concrete {
    var color = UIColor()
    var dots = [Dot]()
}

struct Glass {
    var color = UIColor()
    var dots = [Dot]()
}

struct Dirt {
    var color = UIColor()
    var dots = [Dot]()
}

struct Wood {
    var color = UIColor()
    var numberOfLines = 0
}

struct Bars {
    var color = UIColor()
    var numberOfLines = 0
}

struct Brick {
    var color = UIColor()
    var numberOfLines = 0
}

struct Column {
    var color = UIColor()
    var numberOfLines = 0
}
