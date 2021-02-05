//
//  ViewController.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import UIKit

class BaseVC : UIViewController {
    
    
    var vSpinner : UIView?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray]


        // Do any additional setup after loading the view.
    }

    func showAlertView(title: String, message: String) {
        
      DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          alert.addAction((UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
      })))
        self.present(alert, animated: true)
      }
    }
    
    func showSpinner(onView : UIView) {
         let spinnerView = UIView.init(frame: onView.bounds)
         spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)//init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .medium)
         ai.color = UIColor.red
         ai.startAnimating()
         ai.center = spinnerView.center
         
         DispatchQueue.main.async {
             spinnerView.addSubview(ai)
            // guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
            var window: UIWindow?

             //guard let window = appDelegate.window else { return }//appDelegate.window else { fatalError() }
             window?.addSubview(spinnerView)
             window?.bringSubviewToFront(spinnerView)
             window?.endEditing(true)
         }
         
         vSpinner = spinnerView
     }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    


}

