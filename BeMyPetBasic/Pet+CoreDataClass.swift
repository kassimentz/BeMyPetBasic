//
//  Pet+CoreDataClass.swift
//  BeMyPetBasic
//
//  Created by Kassiane S Mentz on 04/10/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import Foundation
import CoreData


public class Pet: NSManagedObject {
    
    class func createWith(nome: String, especie: String?, idade: Int16?, peso: Float?, in context: NSManagedObjectContext) -> Pet? {
        
        let request = NSFetchRequest<Pet>(entityName: "Pet")
        let query = "nome == %@"
        let params = [ nome ]
        
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        if let pet = (try? context.fetch(request))?.first{
            return pet
        }
        
        if let pet = NSEntityDescription.insertNewObject(forEntityName: "Pet", into: context) as? Pet{
            pet.nome = nome
            pet.especie = especie
            pet.idade = idade ?? 0
            pet.peso = peso ?? 0
            
            return pet
            
        }
        
        return nil
    }

}
