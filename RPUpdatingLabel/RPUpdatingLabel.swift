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
    @objc public static let NotificationUserInfoDateKey = "date"

    public var eventTime: Date? {
        didSet {
            text = Date().timeElapsedString(sinceDate: eventTime)
        }
    }

    @objc public func update(eventTime: Date?, notificationName: Notification.Name, dateKey: String, object: Any) {
        if let eventTime = eventTime {
            self.eventTime = eventTime
        }

        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main

        center.removeObserver(self)

        center.addObserver(forName: notificationName,
                           object: object,
                           queue: mainQueue) { [weak self] (notification: Notification) in
            if let date = notification.userInfo?[dateKey] as? Date {
                if let eventTime = self?.eventTime {
                    self?.text = date.timeElapsedString(sinceDate: eventTime)
                }
            }
        }
        text = Date().timeElapsedString(sinceDate: eventTime)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        text = Date().timeElapsedString(sinceDate: eventTime)
    }

    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
}
