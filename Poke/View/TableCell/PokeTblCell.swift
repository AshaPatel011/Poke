//
//  PokeTblCell.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import UIKit

class PokeTblCell: UITableViewCell {

    //MARK: outlets ---------------------------------------------------------
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnTitle: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        btnTitle.layer.cornerRadius = 23
        btnTitle.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: others ---------------------------------------------------------
    
    func setupData(_ poke : Poke?){
        
        if let objPoke = poke{
            lblTitle.text = objPoke.name?.capitalized
            btnTitle.setTitle(String(objPoke.name?.prefix(1) ?? "").capitalized, for: .normal)
        }
        
    }
    

}
