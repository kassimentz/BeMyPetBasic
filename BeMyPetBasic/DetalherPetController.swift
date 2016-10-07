//
//  DetalherPetController.swift
//  BeMyPetBasic
//
//  Created by Kassiane S Mentz on 04/10/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import UIKit
import CoreData

class DetalherPetController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    weak var managedObjectContext: NSManagedObjectContext?
    

    @IBOutlet weak var nomeEdit: UITextField!
    @IBOutlet weak var especieEdit: UITextField!
    @IBOutlet weak var idadeEdit: UITextField!
    @IBOutlet weak var pesoEdit: UITextField!
    @IBOutlet weak var pickerEspecie: UIPickerView!
    
    let pickerDataEspecie = ["Gato","Cachorro", "Passarinho","Hamster"]
    
    weak var pet: Pet?{
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerEspecie.dataSource = self
        pickerEspecie.delegate = self
        updateUI()
    }
    
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

    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataEspecie.count
    }
    
    //MARK: Delegates
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataEspecie[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        especieEdit.text = pickerDataEspecie[row]
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
