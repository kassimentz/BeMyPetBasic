//
//  Pet+CoreDataProperties.swift
//  BeMyPetBasic
//
//  Created by Kassiane S Mentz on 04/10/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet");
    }

    @NSManaged public var nome: String?
    @NSManaged public var especie: String?
    @NSManaged public var idade: Int16
    @NSManaged public var peso: Float

}
