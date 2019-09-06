//
//  RPUpdatingLabel.swift
//  RPUpdatingLabel
//
//  Created by Raunak Poddar on 05/09/19.
//  Copyright © 2019 Raunak Poddar. All rights reserved.
//

import UIKit

public class RPUpdatingLabel: UILabel {
    
    @objc public static let ClockUpdateNotification = Notification.Name("ClockUpdateNotification")
    
    public var eventTime: Date? {
        didSet {
            setTimeElapsedString()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main
        setTimeElapsedString()
        center.addObserver(forName: RPUpdatingLabel.ClockUpdateNotification,
                           object: nil,
                           queue: mainQueue) { [weak self] (notification: Notification) in
                            if let date = notification.userInfo?["date"] as? Date {
                                self?.setTimeElapsedString(forDate: date)
                            }
        }
    }
    
    private func setTimeElapsedString(forDate date: Date = Date()) {
        text = date.timeElapsedString(sinceDate: eventTime, pastSuffix: "ago", futureSuffix: "to go")
    }
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self)
    }

}
