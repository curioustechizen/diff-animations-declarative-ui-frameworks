//
//  CircleInfoData.swift
//  CircleDiffAnimations
//
//  Created by Kiran Rao on 16/04/2020.
//  Copyright © 2020 Kiran Rao. All rights reserved.
//

import SwiftUI

struct CircleInfo: Identifiable, Equatable {
    private(set) var id = UUID()
    let color: Color
    private(set) var isExpanded: Bool = false
}

extension CircleInfo {
    func withExpanded(_ isExpanded: Bool) -> CircleInfo {
        CircleInfo(id: self.id, color: self.color, isExpanded: isExpanded)
    }
}

fileprivate let purple = CircleInfo(color: Color.purple)
fileprivate let gray = CircleInfo(color: Color.gray)
fileprivate let blue = CircleInfo(color: Color.blue)
fileprivate let green = CircleInfo(color: Color.green)
fileprivate let yellow = CircleInfo(color: Color.yellow)
fileprivate let orange = CircleInfo(color: Color.orange)
fileprivate let red = CircleInfo(color: Color.red)


struct CircleInfoModel {
    
    private static let circles1 = [purple, gray, blue, green, yellow, orange, red]
    private static let circles2 = [purple, gray.withExpanded(true),  orange.withExpanded(true), red, green]
    
    private(set) var activeCircles = circles1
    
    mutating func toggle() {
        self.activeCircles = activeCircles == CircleInfoModel.circles1 ? CircleInfoModel.circles2 : CircleInfoModel.circles1
    }
    
    func index(of circle: CircleInfo) -> Int? {
        activeCircles.firstIndex(of: circle)
    }
}
