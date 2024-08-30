//
//  ParticipantsViewModel.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI
import CoreData

final class ParticipantsViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false
    
    @Published var photos: [String] = ["1", "2", "3", "4"]
    @Published var currentPhoto = ""
    
    @Published var statuses: [String] = ["Sent", "Accepted", "Rejected"]
    @Published var currentStatus = ""

    @Published var parPhoto = ""
    @Published var parName = ""
    @Published var parSpec = ""
    @Published var parAge = ""
    @Published var parEx = ""
    @Published var parNote = ""
    @Published var parStatus = ""
    
    @Published var participantss: [ParticipantModel] = []
    @Published var selectedParticipant: ParticipantModel?

    func addParticipant() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ParticipantModel", into: context) as! ParticipantModel

        loan.parPhoto = parPhoto
        loan.parName = parName
        loan.parSpec = parSpec
        loan.parAge = parAge
        loan.parEx = parEx
        loan.parNote = parNote
        loan.parStatus = parStatus

        CoreDataStack.shared.saveContext()
    }

    func fetchParticipants() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ParticipantModel>(entityName: "ParticipantModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.participantss = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.participantss = []
        }
    }
}
