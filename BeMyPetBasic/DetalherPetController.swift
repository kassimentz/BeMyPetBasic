//
//  DetalherPetController.swift
//  BeMyPetBasic
//
//  Created by Kassiane S Mentz on 04/10/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import UIKit
import CoreData

class DetalherPetController: UIViewController {
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    weak var pet: Pet?{
        didSet{
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBOutlet weak var nomeEdit: UITextField!
    @IBOutlet weak var especieEdit: UITextField!
    @IBOutlet weak var idadeEdit: UITextField!
    @IBOutlet weak var pesoEdit: UITextField!
    
    private func updateUI(){
        nomeEdit?.text = pet?.nome
        especieEdit?.text = pet?.especie
        
        if let idade = pet?.idade {
            idadeEdit?.text = String(idade)
        }
        
        if let peso = pet?.peso{
            pesoEdit?.text = String(peso)
        }
    }

    
    // MARK: Handle Navigation by saving or not
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func savePet(_ sender: UIBarButtonItem) {
        
        if let context = managedObjectContext {
        
            if let animal = pet {
                animal.nome = nomeEdit.text
                animal.especie = especieEdit.text
                if let idadeText = idadeEdit.text,
                let idade = Int16(idadeText)
                {
                    animal.idade = idade
                }
            
                if let pesoText = pesoEdit.text,
                    let peso = Float(pesoText)
                {
                    animal.peso = peso
                }
            
            } else {
                if let nome = nomeEdit.text
                {
                    let especie = especieEdit.text
                    var idade: Int16? = nil
                    if let idadeText = idadeEdit.text{
                        idade = Int16(idadeText)
                    }
                
                    var peso: Float? = nil
                    if let pesoText = pesoEdit.text{
                        peso = Float(pesoText)
                    }
                
                    let _ = Pet.createWith(nome: nome,
                                                especie: especie,
                                                idade: idade,
                                                peso: peso,
                                                in: context)
                }
            
            }
        
        
            do{
                try context.save()
            } catch let error {
                print("\(error)")
            }
            
        }
        
        _ = navigationController?.popViewController(animated: true)
    }

}
