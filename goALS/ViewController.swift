//
//  ViewController.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/12/22.
//

import Foundation
import SwiftUI

class ViewController: UIViewController, FSCalendarDelegate {
        
    var calendar = FSCalendar()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(calendar)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: date)
        print(string)
    }
}
