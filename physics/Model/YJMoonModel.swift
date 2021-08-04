//
//  YJMoonModel.swift
//  physics
//
//  Created by joting on 2021/8/4.
//

import Foundation
enum OrbitLevel:Double {
    case high = 384
    case defalut = 284
    case low = 184
}
enum GravitationalFormula:Int {
    case Inversely = -1
    case unrelated = 0
    case liner = 1
    case square = 2
    case cube = 3
}
struct YJMoonModel{
    private let G = 6.67e-11
    let image = "moon"
    let quliaty = 0.0
    ///缩小100 倍
    ///单位：m
    let width = 19.75
    ///缩小100 倍
    ///单位：m
    let height = 19.75
        
    var speed = 0.0
    ///缩小1000 倍
    ///单位：km
    var distance = OrbitLevel.defalut

    ///角速度
    /// rad/s
    func w(_ M:Double,_ formula: GravitationalFormula = .square) -> Double {
        let index = formula.rawValue + 1
        return sqrt((G * M)/pow(distance.rawValue * 1000, Double(index)))
    }
}
