//
//  Date+TimeElapsedString.swift
//  RPUpdatingLabel
//
//  Created by Raunak Poddar on 05/09/19.
//  Copyright © 2019 Raunak Poddar. All rights reserved.
//

import Foundation

extension Date {
    private static func elapsedString(forComponent component: Int,
                                      subComponent: Int,
                                      componentSingular: String,
                                      componentPlural: String,
                                      subComponentSingular: String,
                                      subComponentPlural: String) -> String? {
        var str: String?
        if component > 1 && subComponent > 1 {
            str = "\(component) \(componentPlural) \(subComponent) \(subComponentPlural)"
        } else if component > 1 && subComponent == 1 {
            str = "\(component) \(componentPlural) \(subComponent) \(subComponentSingular)"
        } else if component > 1 {
            str = "\(component) \(componentPlural)"
        } else if component == 1 {
            str = "\(component) \(componentSingular)"
        }
        return str
    }

    func timeElapsedString(sinceDate since: Date?, pastSuffix: String = "ago", futureSuffix: String = "to go") -> String {
        guard let since = since else {
            return "??"
        }

        var dcs: DateComponents
        var suffix: String
        if since < self {
            suffix = pastSuffix
            dcs = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: since, to: self)
        } else {
            suffix = futureSuffix
            dcs = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: self, to: since)
        }

        var str: String?
        let year = dcs.year!
        let month = dcs.month!

        str = Date.elapsedString(forComponent: year,
                                 subComponent: month,
                                 componentSingular: "year",
                                 componentPlural: "years",
                                 subComponentSingular: "month",
                                 subComponentPlural: "months")

        if let str = str {
            return "\(str) \(suffix)"
        }

        let week = dcs.weekOfMonth!
        str = Date.elapsedString(forComponent: month,
                                 subComponent: week,
                                 componentSingular: "month",
                                 componentPlural: "months",
                                 subComponentSingular: "week",
                                 subComponentPlural: "weeks")
        if let str = str {
            return "\(str) \(suffix)"
        }

        let day = dcs.day!
        str = Date.elapsedString(forComponent: week,
                                 subComponent: day,
                                 componentSingular: "week",
                                 componentPlural: "weeks",
                                 subComponentSingular: "day",
                                 subComponentPlural: "days")
        if let str = str {
            return "\(str) \(suffix)"
        }

        let hour = dcs.hour!
        str = Date.elapsedString(forComponent: day,
                                 subComponent: hour,
                                 componentSingular: "day",
                                 componentPlural: "days",
                                 subComponentSingular: "hour",
                                 subComponentPlural: "hours")
        if let str = str {
            return "\(str) \(suffix)"
        }

        let min = dcs.minute!
        str = Date.elapsedString(forComponent: hour,
                                 subComponent: min,
                                 componentSingular: "hour",
                                 componentPlural: "hours",
                                 subComponentSingular: "minute",
                                 subComponentPlural: "minutes")
        if let str = str {
            return "\(str) \(suffix)"
        }

        let sec = dcs.second!
        str = Date.elapsedString(forComponent: min,
                                 subComponent: sec,
                                 componentSingular: "minute",
                                 componentPlural: "minutes",
                                 subComponentSingular: "second",
                                 subComponentPlural: "seconds")
        if let str = str {
            return "\(str) \(suffix)"
        }

        return "\(sec) seconds \(suffix)"
    }
}
