//
//  Students+CoreDataProperties.swift
//  Coredata_prog_1
//
//  Created by Navdeep on 04/08/2023.
//
//

import Foundation
import CoreData


extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var noOfTimeClicked: Int16

}

extension Students : Identifiable {

}
