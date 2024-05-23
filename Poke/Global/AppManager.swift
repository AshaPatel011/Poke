//
//  AppManager.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import Foundation
import Alamofire

// MARK: - typealias  ---------------------------------------------------------

// api success
typealias apiCalledSuccess = (_ response: [String : AnyObject]) -> ()

// api failure
typealias apiCalledFailure = (_ error: Error) -> ()


class AppManager: NSObject {
    
    static let sharedIntance = AppManager()
    
    let strErrorMessage = "Please try again!!"

    //MARK: Post ---------------------------------------------------------
    
    func GetMethodAPi(request: String,httpMethod: Alamofire.HTTPMethod, params: [String:AnyObject], fromVC: UIViewController, apiSuccess: @escaping apiCalledSuccess, apiFailuer: @escaping apiCalledFailure) {
        
        let url = request.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        AF.request(url ?? "", method:.get,encoding: URLEncoding.default) .responseJSON { (response) in
            print(response)

            switch response.result {
            case let .success(result):
               // the decoded result of type 'Result' that you received from the server.
             print("Result is: \(result)")
             apiSuccess(result as? [String : AnyObject] ?? [String : AnyObject]())
            case let .failure(error):
               // Handle the error.
             print("Error description is: \(error.localizedDescription)")
             apiFailuer(error)

            }
        }
    }
}

