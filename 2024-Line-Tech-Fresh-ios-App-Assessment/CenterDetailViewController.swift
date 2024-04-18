//
//  CenterDetailViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/19.
//

import UIKit

class CenterDetailViewController: UIViewController{
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var center: Center!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = center.name
        
        let organizedHours = organizeOpeningHours(center.time)
        
        descriptionLabel.text = """
                                🌱 科別： \(center.type)\n
                                🌱 治療項目： \(center.service)\n
                                🌱 電話： \(center.telephone)\n
                                🌱 地址： \(center.address)\n
                                🌱 營業時間：
                                \(organizedHours)\n
                                🌱 備註： \(center.other)
                                """
        
        descriptionLabel.numberOfLines = 0
        // Break the line by word wrapping
        descriptionLabel.lineBreakMode = .byWordWrapping
        // Allow the label to resize based on content
        descriptionLabel.sizeToFit()
    }
    
    private func organizeOpeningHours(_ hours: String) -> String {
        let days = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
        var hoursByDay: [String: [String]] = [:]

        days.forEach { hoursByDay[$0] = [] }
        
        let allHoursComponents = hours.components(separatedBy: "、")
        
        for component in allHoursComponents where !component.contains("休診") {
            for day in days {
                if component.contains(day) {
                    let timeSlot = component.contains("上午") ? "上午" : component.contains("下午") ? "下午" : "晚上"
                    if !hoursByDay[day]!.contains(timeSlot) {
                        hoursByDay[day]?.append(timeSlot)
                    }
                    break
                }
            }
        }

        let hoursString = days.compactMap { day -> String? in
            guard let times = hoursByDay[day], !times.isEmpty else { return nil }
            return "    - \(day)：" + times.joined(separator: "、")
        }.joined(separator: "\n")

        return hoursString
    }
}
