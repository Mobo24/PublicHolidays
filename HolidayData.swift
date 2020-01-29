//
//  HolidayData.swift
//  PublicHolidays
//
//  Created by Mobolaji Moronfolu on 1/15/20.
//  Copyright © 2020 Mobolaji Moronfolu. All rights reserved.
//

import Foundation

struct holidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable{
    var holidays: [HolidayDetail]
}
struct HolidayDetail: Decodable {
    var name: String
    var date: HolidayDate
}
struct HolidayDate: Decodable {
    var iso : String
    var dateTime: TimeAndDate
}

struct TimeAndDate: Decodable{
    var year: String
    var month: String
    var day: String
    
}
