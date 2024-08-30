//
//  CompetitionsViewModel.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI
import CoreData

final class CompetitionsViewModel: ObservableObject {
    
    @Published var isAdd: Bool = false
    @Published var isAddPart: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var currentEvName = ""
    
    @Published var icons: [String] = ["figure.strengthtraining.traditional", "figure.run", "medal.fill", "figure.australian.football", "figure.volleyball", "figure.basketball"]
    @Published var currentIcon = ""

    @Published var evPhoto = ""
    @Published var evName = ""
    @Published var evDescr = ""
    @Published var evNote = ""
    @Published var evDate: Date = Date()
    @Published var evTime: Date = Date()

    @Published var events: [EventModel] = []
    @Published var selectedEvent: EventModel?

    func addEvent() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "EventModel", into: context) as! EventModel

        loan.evPhoto = evPhoto
        loan.evName = evName
        loan.evDescr = evDescr
        loan.evNote = evNote
        loan.evDate = evDate
        loan.evTime = evTime

        CoreDataStack.shared.saveContext()
    }

    func fetchEvents() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EventModel>(entityName: "EventModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.events = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.events = []
        }
    }
    
    @Published var partName = ""
    @Published var partEvent = ""

    @Published var participants: [PartModel] = []
    @Published var selectedParticipants: PartModel?

    func addPart() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PartModel", into: context) as! PartModel

        loan.partName = partName
        loan.partEvent = partEvent

        CoreDataStack.shared.saveContext()
    }

    func fetchEParts() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PartModel>(entityName: "PartModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.participants = result.filter{($0.partEvent ?? "") == currentEvName}

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.participants = []
        }
    }
}
