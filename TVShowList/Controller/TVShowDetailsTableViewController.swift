//
//  TVShowDetailsTableViewController.swift
//  TVShowList
//
//  Created by Rashma on 05/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import UIKit
import Cosmos

class TVShowDetailsTableViewController: UITableViewController {
    
    
    
    var currentID : Int!
    var objTVShowListView = TVShowListView()
    @IBOutlet weak var starrating : CosmosView!
    @IBOutlet weak var m_imgView_TVShow : UIImageView!
    @IBOutlet weak var m_lbl_description : UILabel!
    @IBOutlet weak var m_lbl_status : UILabel!
    @IBOutlet weak var m_lbl_premieredDate : UILabel!
    @IBOutlet weak var m_lbl_runtime : UILabel!
    @IBOutlet weak var m_lbl_officialSite : UILabel!
    @IBOutlet weak var m_lbl_rating : UILabel!
    @IBOutlet weak var m_lbl_url : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.callgetShowDetailsAPI()
        starrating.didFinishTouchingCosmos = didFinishTouchingCosmos
        starrating.rating = objTVShowListView.getStarRatinedValue(ID : currentID)
        
        
        
        
        
        
        
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print(rating)
        objTVShowListView.saveRatingsToCoreData(ID: currentID, rating: rating)
        let alert = UIAlertController(title: title, message: "Your rating is " + "\(rating)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction((UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
                
        })))
          self.present(alert, animated: true)
        
    }
    
    func callgetShowDetailsAPI() {
        objTVShowListView.callAPI(url_: baseURL + ServiceNames.showSinglePage + ((self.currentID! as NSNumber).stringValue), search: false, isforListing: false) { (response, success) in
            if success == true {
                guard let item = response as? struct_ShowDetails else {
                    return
                }
                self.title = item.name
                self.m_lbl_description.text = item.summary ?? ""
                self.m_lbl_status.text = "Status : " + (item.status ?? "")
                self.m_lbl_premieredDate.text = "Premeried date : " + (item.premiered ?? "")
                self.m_lbl_runtime.text = "Run time : " + ("\(item.runtime)" )
                self.m_lbl_officialSite.text = "Official site : " + (item.officialSite ?? "")
                self.m_lbl_rating.text = "Rating : " + ("\(item.rating?.average)" )
                self.m_lbl_url.text = "Url : " + (item.url ?? "")
                if let url =  item.image?.original {
                    self.m_imgView_TVShow.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named:"img_Loader"))
                    self.fetchImage(url: url, completed: { ret in
                        self.tableView.backgroundView = UIImageView(image: ret)
                        self.view.backgroundColor = .clear
                        
                        let blurEffect = UIBlurEffect(style: .dark)
                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
                        blurEffectView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width
                            , height: 2000)
                        
                        self.tableView.addSubview(blurEffectView)
                        self.tableView.sendSubviewToBack(blurEffectView)
                    })
                }
                else {
                    self.m_imgView_TVShow.image = UIImage(named:"img_Loader")
                }
            } else {
                
            }
        }
        
        
        
        
    }
    
    func fetchImage(url: String , completed: @escaping (UIImage) -> ()) {
        let imageURL = URL(string: url)
        var image: UIImage?
        if let url = imageURL {
            let imageData = try? Data(contentsOf: url)
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData!)
                        completed(image!)
                        
                    }
                    else {
                        completed(UIImage(named: "cancel-red")!)
                    }
                    
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 281
            
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    
}


