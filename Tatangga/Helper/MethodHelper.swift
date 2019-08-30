//
//  MethodHelper.swift
//  Tatangga
//
//  Created by Qiarra on 29/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import Foundation

func dateFormatter(date: Date) -> String {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let myString = formatter.string(from: Date()) // string purpose I add here
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "dd-MMM-yyyy"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    
    return myStringafd
}
