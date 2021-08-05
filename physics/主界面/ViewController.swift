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
    var formula = GravitationalFormula.square
    
    @IBAction func showSetting(_ sender: Any) {
        let controller = YJSettingViewController()
        controller.modalPresentationStyle = .formSheet
        controller.delegate = self
        controller.distance = moonView.model.distance
        controller.relation = formula
        present(controller, animated: true, completion: nil)
        
    }
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
    ///开始月球自转与公转
    func runMoon(_ formula:GravitationalFormula = .square) {
        //绘制自转和公转动画
        self.formula = formula
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
    ///开始地球自转
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
extension ViewController:YJSettingViewControllerDelegate{
    func changed(_ relation: GravitationalFormula, _ diatance: OrbitLevel) {
        moonView.model.distance = diatance
        runMoon(relation)
    }
}
