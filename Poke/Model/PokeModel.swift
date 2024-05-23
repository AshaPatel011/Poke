//
//  PokeModel.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import Foundation

struct PokeBaseModel : Codable{
    
    var count : Int?
    var next : String?
    var previous : String?
    var results : [Poke]?
    
}


struct Poke : Codable{
    
    var name : String?
    var url : String?
    var base_experience : Int?
    var id : Int?
    var abilities : [PokeAbility]?
    var sprites : PokeSprites?

}

struct PokeAbility : Codable{
    
    var ability : PokeAbilityDetail?
    var is_hidden : Bool?
    
}

struct PokeAbilityDetail : Codable{
    
    var name : String?
    
}


struct PokeSprites : Codable{
    
    var back_default : String?
    var back_shiny : String?
    var front_default : String?
    var front_shiny : String?

}


