//
//  YJSettingViewController.swift
//  physics
//
//  Created by joting on 2021/8/5.
//

import UIKit
protocol YJSettingViewControllerDelegate:NSObject {
    func changed(_ relation:GravitationalFormula,_ diatance:OrbitLevel)
}
class YJSettingViewController: UIViewController {
    var distance = OrbitLevel.low
    var relation = GravitationalFormula.square
    weak var delegate:YJSettingViewControllerDelegate?
    @IBOutlet weak var relationSegment: UISegmentedControl!
    @IBOutlet weak var distanceSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        relationSegment.selectedSegmentIndex = indexOf(relation)
        distanceSegment.selectedSegmentIndex = indexOf(distance)
    }

    @IBAction func distanceChanged(_ sender: UISegmentedControl) {
        distance = distanceOf(sender.selectedSegmentIndex)
        delegate?.changed(relation, distance)
    }
    
    @IBAction func relationChanged(_ sender: UISegmentedControl) {
        relation = relationOf(sender.selectedSegmentIndex)
        delegate?.changed(relation, distance)
    }
    
    private func relationOf(_ index:Int) -> GravitationalFormula{
        return GravitationalFormula(rawValue: index - 1) ?? .square
    }
    private func distanceOf(_ index:Int) -> OrbitLevel{
        switch index {
        case 0:
            return .veryLow
        case 1:
            return .low
        case 2:
            return .defalut
        case 3:
            return .high
        case 4:
            return .veryHight
        default:
            return .defalut
        }
    }
    private func indexOf(_ relation:GravitationalFormula) -> Int{
        return relation.rawValue + 1
    }
    private func indexOf(_ distance:OrbitLevel) -> Int{
        switch distance {
        case .veryLow:
            return 0
        case .low:
            return 1
        case .defalut:
            return 2
        case .high:
            return 3
        case .veryHight:
            return 4
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
