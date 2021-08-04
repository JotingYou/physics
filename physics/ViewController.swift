//
//  ViewController.swift
//  physics
//
//  Created by joting on 2021/8/4.
//

import UIKit

class ViewController: UIViewController {
    let moonView = YJMoonView()
    let earth = YJEarthModel()
    var pathLayer:CAShapeLayer!
    var duration = 0.0
    
    @IBOutlet weak var earthView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let moonModel = YJMoonModel()
        moonView.config(moonModel)
        //添加到视图中
        view.addSubview(moonView)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        runMoon()
        runEarth()
    }
    func runMoon(_ formula:GravitationalFormula = .square) {
        //绘制自转和公转动画
        let result = moonView.run(earth.quliaty, view.center, formula)
        duration = result.duration
        let path = result.path
        //绘制运动轨迹
        if pathLayer != nil {
            pathLayer.removeFromSuperlayer()
        }
        pathLayer = CAShapeLayer()
        pathLayer.frame = self.view.bounds
        //pathLayer.isGeometryFlipped = true
        pathLayer.path = path
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.lightGray.cgColor
        
        //给运动轨迹添加动画
         let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
         pathAnimation.duration = duration
         pathAnimation.fromValue = 0
         pathAnimation.toValue = 1
         //pathAnimation.delegate = (window as! CAAnimationDelegate)
         pathLayer.add(pathAnimation , forKey: "strokeEnd")
        //将轨道添加到视图层中
        view.layer.addSublayer(pathLayer)

    }
    func runEarth() {
        earthView.layer.removeAnimation(forKey: "rotation")
        // 创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = duration/30
        anim.isRemovedOnCompletion = false
        // 将动画添加到图层上
        earthView.layer.add(anim, forKey: "rotation")
    }

}

