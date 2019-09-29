//
//  LifeEventsTableViewController.swift
//  LifeEvents
//
//  Created by Raunak Poddar on 05/09/19.
//  Copyright © 2019 Raunak Poddar. All rights reserved.
//

import UIKit
import RPUpdatingLabel


extension DateFormatter {
    private static var _mediumDateTimeStyleWithLocalTimezone: DateFormatter!
    static var mediumDateTimeStyleWithLocalTimeZone: DateFormatter {
        if let _mediumDateTimeStyleWithLocalTimezone = _mediumDateTimeStyleWithLocalTimezone {
            return _mediumDateTimeStyleWithLocalTimezone
        }
        _mediumDateTimeStyleWithLocalTimezone = DateFormatter()
        _mediumDateTimeStyleWithLocalTimezone.dateStyle = .medium
        _mediumDateTimeStyleWithLocalTimezone.timeStyle = .medium
        _mediumDateTimeStyleWithLocalTimezone.timeZone = TimeZone.autoupdatingCurrent
        return _mediumDateTimeStyleWithLocalTimezone
    }
}

class LifeEventsTableViewController: UITableViewController {
    
    let numEvents = 300
    
    var events = [Date]()
    
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 3.0,
                                     repeats: true,
                                     block: { [weak self] (timer) in
                                        NotificationCenter.default.post(name: RPUpdatingLabel.ClockUpdateNotification,
                                                                        object: self,
                                                                        userInfo: ["date": Date()])
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        events.append(date)
        
        events.append(date.addingTimeInterval(70.0))
        events.append(date.addingTimeInterval(-70.0))
        
        for _ in 2...numEvents {
            let ti = Int.random(in: ClosedRange<Int>(uncheckedBounds: (lower: -99999, upper: 99999)))
            let eventDate = date.addingTimeInterval(TimeInterval(ti))
            events.append(eventDate)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeEventCell") as! LifeEventCell
        cell.dateLabel.text = DateFormatter.mediumDateTimeStyleWithLocalTimeZone.string(from: events[indexPath.row])
        cell.elapsedTimeLabel.update(eventTime: events[indexPath.row], notificationName: RPUpdatingLabel.ClockUpdateNotification, dateKey:  RPUpdatingLabel.NotificationUserInfoDateKey, object: self)
        return cell
    }

}
