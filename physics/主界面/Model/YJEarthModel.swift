//
//  YJEarthModel.swift
//  physics
//
//  Created by joting on 2021/8/4.
//

import Foundation

struct YJEarthModel{
    let image = "earth"
    ///缩小100 倍
    ///单位：m
    var width = 79.0
    private let ratio = 1.0
    var height: Double {
        width * ratio
    }
    ///质量 kg
    let quliaty = 5.965e24
}
