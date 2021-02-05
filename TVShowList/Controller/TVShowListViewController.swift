//
//  TVShowListViewController.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import UIKit
import Alamofire

class TVShowListViewController: BaseVC {
    
    @IBOutlet weak var m_collectionView_TVShowList : UICollectionView!
    @IBOutlet weak var m_searchBar : UISearchBar!
    @IBOutlet weak var m_activityIndicator : UIActivityIndicatorView!
    
    var objTVShowListView = TVShowListView()
    var array_TVShowList = [struct_EachtvShow]()
    var array_SearchedTVShowList = [struct_AllSearchedTVShows]()
    var searchActive : Bool = false
    var index : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.m_collectionView_TVShowList.register(Cell_Poster.nib, forCellWithReuseIdentifier: Cell_Poster.identifier)
        objTVShowListView.delegate = self
        self.title = "SHOWS"
        self.callAPIForTVShowList()
        
        
        

    }
    
    func callAPIForTVShowList() {
        
        if NetworkConnectivity.isConnectedToInternet() == true {
            self.m_activityIndicator.isHidden = false
            m_activityIndicator.startAnimating()
            objTVShowListView.callAPI(url_: baseURL + ServiceNames.showPage, search: false, isforListing: true) { (response, success) in
                self.m_activityIndicator.isHidden = true
                if success == true {
                    
                    self.m_collectionView_TVShowList.reloadData()
                } else {
                    self.showAlertView(title: "TV Shows Listing", message: (response as? String ?? "FAILED"))
                }
            }
            
        }
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
        if segue.identifier == "TVShowDetailsSegue" {
            print("Do pass object here")
            guard let vc = segue.destination as? TVShowDetailsTableViewController else { return }
            vc.currentID = searchActive == false ? self.array_TVShowList[index].id : self.array_SearchedTVShowList[index].show?.id
        }
        

    }

}


extension TVShowListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchActive == false ? self.array_TVShowList.count : self.array_SearchedTVShowList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell_Poster.identifier, for: indexPath) as? Cell_Poster {
            Cell.delegate = self
            if searchActive == false {
                Cell.item = self.array_TVShowList[indexPath.row]
            } else {
                Cell.item1 = self.array_SearchedTVShowList[indexPath.row].show
            }
            return Cell
        }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "TVShowDetailsSegue", sender: nil)
    }
   
    
    
}


extension TVShowListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = true
        if self.m_searchBar.text != "" {
            
            let URL_STRING = baseURL + ServiceNames.search + self.m_searchBar.text!
            if NetworkConnectivity.isConnectedToInternet() == true {
                self.showSpinner(onView: (self.view)!)
                objTVShowListView.callAPI(url_: URL_STRING, search: true, isforListing: true) { (response, success) in
                    self.removeSpinner()
                    if success == true {
                        self.m_collectionView_TVShowList.reloadData()
                    } else {
                        self.showAlertView(title: "TV Shows Listing", message: (response as? String ?? "FAILED"))
                    }
                }
                
            }
            
            
            
        }else {
             self.searchActive = false
            self.callAPIForTVShowList()
        }
    }
    
    
    
    
    
}












extension TVShowListViewController : UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let noOfCellsInRow = 2
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
    let height = Int((collectionView.bounds.height / 2.5))
    return CGSize(width: size, height: height)
  }
}




extension TVShowListViewController : protocol_TVShowListView {
    func passResult(result: Any) {
        if result is [struct_EachtvShow] {
            self.array_TVShowList = result as! [struct_EachtvShow]
           
        } else if result is [struct_AllSearchedTVShows] {
            self.array_SearchedTVShowList = result as! [struct_AllSearchedTVShows]

        } else {
            self.array_TVShowList.removeAll()
            self.array_SearchedTVShowList.removeAll()
        }
    }
    
    
}

extension TVShowListViewController : protocol_Cell_Poster {
    func passID() {
       
    }
    
    
}
