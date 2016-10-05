//
//  ListaPetsController.swift
//  BeMyPetBasic
//
//  Created by Kassiane S Mentz on 04/10/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import UIKit
import CoreData

class ListaPetsController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        requestFetchedResultsController()
    }
    
    // MARK: CoreDataTableViewController FetchedResultsController setup
    
    private func requestFetchedResultsController(){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Pet")
        request.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        
        if let context = managedObjectContext {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }

    // MARK: - UITableView data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let pet = fetchedResultsController?.object(at: indexPath) as? Pet{
            cell.textLabel?.text = pet.nome
            cell.detailTextLabel?.text = pet.especie
        }
        
        return cell
    }
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetalherPetController{
            destination.managedObjectContext =  managedObjectContext
            
            if segue.identifier == "insertPet" {
                destination.pet = nil
            } else if let indexPath = tableView.indexPathForSelectedRow,
                let pet = fetchedResultsController?.object(at: indexPath) as? Pet
            {
                destination.pet = pet
            }
        }
    }


}
