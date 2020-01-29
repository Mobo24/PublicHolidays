//
//  HolidayRequest.swift
//  PublicHolidays
//
//  Created by Mobolaji Moronfolu on 1/15/20.
//  Copyright © 2020 Mobolaji Moronfolu. All rights reserved.
//

import Foundation

struct HolidayRequest{
    let ResourceURL: URL
    let API_KEY = "####"
    
    enum HolidayError: Error{
        case noDataAvailable
        case cantProcessData
    }
    
    init(CountryCode:String){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from :date)
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(CountryCode)&year=\(currentYear)"
        guard let ResourceURL = URL(string: resourceString) else {fatalError()}
        self.ResourceURL = ResourceURL
    }
    func getHolidays(completionHandler: @escaping(Result<[HolidayDetail], HolidayError>) -> Void){
      let dataTask = URLSession.shared.dataTask(with: ResourceURL) { (data, _, _) in
            guard let jsonData = data else{
                completionHandler(.failure(.noDataAvailable))
                return
            }
                do{
                       let decoder = JSONDecoder()
                       let holidayResponses = try decoder.decode(holidayResponse.self, from: jsonData)
                       print("Holiday Res: \(holidayResponses)")
                       let holidayDetails = holidayResponses.response.holidays
                       completionHandler(.success(holidayDetails))
                   }
                   catch {
                       completionHandler(.failure(.cantProcessData))
                   }
    }
    
    dataTask.resume()
}
}
