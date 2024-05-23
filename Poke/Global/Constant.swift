//
//  Constant.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import Foundation
import UIKit
import Kingfisher

struct Constants {
    
    static var shared = Constants()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let BaseURL = "https://pokeapi.co/api/v2/pokemon?"
    
//?limit=1&offset=2

}

//MARK: UIImageView ---------------------------------------------------------

extension UIImageView {

    func setImage(with urlString: String?){
        guard let url = URL.init(string: urlString ?? "") else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}



class CommonMethodsClass {
    
    class func showAlertViewOnWindow(titleStr _: String, messageStr: String?, okBtnTitleStr: String) {
        let alert = UIAlertController(title: "", message: messageStr ?? "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okBtnTitleStr, style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = UIColor.black
        ez.topMostVC?.present(alert, animated: true, completion: nil)
    }
    
}

struct ez {
    static var topMostVC: UIViewController? {
       let topVC = UIApplication.topViewController()
       if topVC == nil {
           print("EZSwiftExtensions Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
       }
       return topVC
   }
}

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = Constants.shared.appDelegate.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UIView {
    
    @IBInspectable var corner: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        } get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
  
}
