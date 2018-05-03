//
//  DoubleCalendarViewController.swift
//  FSCalendarSwiftExample
//
//  Created by Vinayak V on 02/05/18.
//  Copyright © 2018 wenchao. All rights reserved.
//

import UIKit


class DoubleCalendarViewController: UIViewController {

    @IBOutlet weak var left: FSCalendar!
    @IBOutlet weak var right: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        left.delegate = self;
        right.delegate = self;
        
        
        left.layer.borderWidth = 0.5
        left.layer.borderColor = UIColor.blue.cgColor
        
        right.layer.borderWidth = 0.5
        right.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        left.currentPage = Date()
        right.currentPage = Date().addingTimeInterval(1 * 30 * 24 * 3600) // 1 month aprox
        
    }
    
    
}


extension DoubleCalendarViewController: FSCalendarDelegate {
    
    func getOtherCal(_ calendar: FSCalendar) -> FSCalendar {
        switch calendar {
        case left:
            return right
        default:
            return left
        }
    }
    
    func calendar(_ calendar: FSCalendar, scrollViewDidScroll scrollView: UIScrollView) {
        
        
        let x = scrollView.contentOffset.x;
        let y = scrollView.contentOffset.y;
        let diff = scrollView.frame.size.width;
        
        
        guard diff > 0 else {
            return;
        }
        
        
        
        
        switch calendar {
        case left:
            right.scroll(toOffset: CGPoint(x: x + diff, y: y))
            
        case right:
            left.scroll(toOffset: CGPoint(x: x - diff, y: y))
            
        default:
            break;
        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        getOtherCal(calendar).select(date, scrollToDate: false)
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        getOtherCal(calendar).deselect(date)
    }
    
}

