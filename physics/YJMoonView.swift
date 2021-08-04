//
//  YJMoonView.swift
//  physics
//
//  Created by joting on 2021/8/4.
//

import UIKit

class YJMoonView: UIImageView {
    var model = YJMoonModel()
    func config(_ model:YJMoonModel) {
        self.model = model
        image = UIImage(named: model.image)
        frame.size = CGSize(width: model.width, height: model.height)
        //center = CGPoint(x: UIScreen.main.bounds.width/2 - CGFloat(model.distance), y: UIScreen.main.bounds.height/2)
    }
    func run(_ quality:Double,_ center:CGPoint,_ formula:GravitationalFormula) -> (duration:Double,path:CGMutablePath){
        layer.removeAllAnimations()
        // 创建自转动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        let duration = 2 * Double.pi / model.w(quality,formula)
        anim.duration = duration
        anim.isRemovedOnCompletion = false
        // 将动画添加到图层上
        layer.add(anim, forKey: "rotation")
        //设置运动的路线
        let path =  CGMutablePath()
        path.addArc(center: center, radius: CGFloat(model.distance.rawValue), startAngle: 0,
                    endAngle: CGFloat(2 * Double.pi), clockwise: false)
        
        //给方块添加移动动画
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = duration
        orbit.path = path
        orbit.repeatCount = MAXFLOAT
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.isRemovedOnCompletion = false
        orbit.fillMode = CAMediaTimingFillMode.forwards
        layer.add(orbit,forKey:"Move")
        return (duration:duration,path:path)
    }
}
