//
//  PokeViewModel.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import Foundation
import UIKit

//MARK: delegate ---------------------------------------------------------

protocol PokeHelperParserDelegate {
    func Success()
    func Failed(errormessage: String)
    func SuccessPokeDetails()
    func FailedPokeDetails(errormessage: String)
}



class PokeHelper_Parser {
    
    //MARK: properties ---------------------------------------------------------
    
    var delegate: PokeHelperParserDelegate?
    var arrPoke = [Poke]()
    var objPokeDetails : Poke?
    var page : Int = 1
    var limit : Int = 30
    
    //MARK: others ---------------------------------------------------------
    
    func initWith(helperDelegate: PokeHelperParserDelegate) {
        delegate = helperDelegate
    }
    
    
    func getPokeList(viewController: UIViewController) {
        
        AppManager.sharedIntance.GetMethodAPi(request:  Constants.shared.BaseURL + "offset=\(page)&limit=\(limit)" , httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in
            
            if response["success"] as? Bool ?? true == false{
                self.delegate?.Failed(errormessage: response["status_message"] as? String ?? AppManager.sharedIntance.strErrorMessage)
                return
            }
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: response["results"] as? [AnyObject] ?? [AnyObject](), options: .prettyPrinted)
                print(jsonData)
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode([Poke].self, from: jsonData)
                self.arrPoke.append(contentsOf: result)
                DispatchQueue.main.async {
                    self.delegate?.Success()
                }
                
                
            }catch let error{
                print(error)
            }
            
        }) { (error) in
            DispatchQueue.main.async() {
                // api fail error
                self.delegate?.Failed(errormessage: AppManager.sharedIntance.strErrorMessage)
            }
            return
        }
    }
    
    
    func getPokeDetail(url : String,viewController: UIViewController) {
        
        AppManager.sharedIntance.GetMethodAPi(request:  url , httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in
            
            if response["success"] as? Bool ?? true == false{
                self.delegate?.FailedPokeDetails(errormessage: response["status_message"] as? String ?? AppManager.sharedIntance.strErrorMessage)
                return
            }
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: response as? [String : AnyObject] ?? [String : AnyObject](), options: .prettyPrinted)
                print(jsonData)
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(Poke.self, from: jsonData)
                self.objPokeDetails = result
                DispatchQueue.main.async {
                    self.delegate?.SuccessPokeDetails()
                }
                
                
            }catch let error{
                print(error)
            }
            
        }) { (error) in
            DispatchQueue.main.async() {
                // api fail error
                self.delegate?.FailedPokeDetails(errormessage: AppManager.sharedIntance.strErrorMessage)
            }
            return
        }
    }
    
    
}

