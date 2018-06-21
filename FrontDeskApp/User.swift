//
//  user.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/20/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import Foundation

class User{
    let id: Int64?
    private var firstName: String
    private var lastName: String
    private var participantNumber: String
    private var ticketNumber: String
    private var date: String
    private var time: String
    
    init (id: Int64){
        self.id = id
        firstName = ""
        lastName = ""
        participantNumber = ""
        ticketNumber = ""
        date = ""
        time = ""
    }
    
    init (id: Int64, firstName: String, lastName: String, participantNumber: String, ticketNumber: String, date: String, time: String){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.participantNumber = participantNumber
        self.ticketNumber = ticketNumber
        self.date = date
        self.time = time
    }
}
