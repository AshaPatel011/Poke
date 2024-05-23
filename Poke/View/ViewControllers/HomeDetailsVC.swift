//
//  HomeDetailsVC.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import UIKit

class HomeDetailsVC: UIViewController {
  

    //MARK: outlets ---------------------------------------------------------
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblAbilites: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblExp: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!

    //MARK: properties ---------------------------------------------------------
    
    var objPoke : Poke?
    
    //MARK: view controller life cycle ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        setupData()
    }
    
    //MARK: Action ---------------------------------------------------------

    @IBAction func btnBackClicked(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Others ---------------------------------------------------------

    
    func setupData(){
        if let pokeData = objPoke{
            lblID.text = "\(pokeData.id ?? 0)"
            lblExp.text = "\(pokeData.base_experience ?? 0)"
            lblName.text = "Hello, \(pokeData.name ?? "")"
            lblAbilites.text = pokeData.abilities?.filter({$0.is_hidden == false}).map({$0.ability?.name ?? ""}).joined(separator: ", ")
            
            img1.setImage(with: pokeData.sprites?.front_default)
            img2.setImage(with: pokeData.sprites?.front_shiny)
            img3.setImage(with: pokeData.sprites?.back_default)
            img4.setImage(with: pokeData.sprites?.back_shiny)

        }
    }
    

}

