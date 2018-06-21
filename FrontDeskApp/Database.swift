//
//  Database.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/20/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import Foundation
import SQLite

class Database{
    static let instance = Database()
    private let db: Connection?
    
    private let users = Table("users")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String?>("firstName")
    private let lastName = Expression<String?>("lastName")
    private let participantNumber = Expression<String?>("participantNumber")
    private let ticketNumber = Expression<String?>("ticketNumber")
    private let date = Expression<String?>("date")
    private let time = Expression<String?>("time")
    

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/Stephencelis.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(users.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(participantNumber)
                table.column(ticketNumber)
                table.column(date)
                table.column(time)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addUser(cfirstName: String, clastName: String, cparticipantNumber: String, cticketNumber: String, cdate: String, ctime: String) ->Int64? {
        do {
            let insert = users.insert(firstName <- cfirstName, lastName <- clastName, participantNumber <- cparticipantNumber, ticketNumber <- cticketNumber, date <- cdate, time <- ctime)
            let id = try db!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getUsers() -> [User] {
        var users = [User]()
        
        do {
            for user in try db!.prepare(self.users) {
                users.append(User(id: user[id],
                                 firstName: user[firstName]!,
                                 lastName: user[lastName]!,
                                 participantNumber: user[participantNumber]!,
                                 ticketNumber: user[ticketNumber]!,
                                 date: user[date]!,
                                 time: user[time]!))
            }
        } catch{
            print("Select failed")
        }
        
        return users
    }
}























