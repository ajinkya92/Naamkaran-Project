//
//  DataVC.swift
//  Naamkaran Project
//
//  Created by Ajinkya Sonar on 08/11/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class DataVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var pageNumber = 1
    var categoryId = String()
    var genderId = Int()
    var isLoading = false
    var isSearching = false
    var isFavorite = false
    var selectedIndex: Int?
    
    var dataArray = Data()
    var searchQuery = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        getData()
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        
    }
    
}

extension DataVC {
    
    func getData() {
        
        if categoryId == "7" || categoryId == "10" {
            
            let alert = UIAlertController(title: "Sorry for the inconvinence", message: "There is no data", preferredStyle: .alert)
            
            let alertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertActionOk)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            DataService.instance.getNamesData(url: String(format: DATA_LIST_URL, categoryId, genderId, pageNumber)) { (true, returnedData) in
                
                if let returnedData = returnedData {
                    
                    self.dataArray = returnedData
                }
                
                //print(self.dataArray.count)
                
                DispatchQueue.main.async {
                    
                    self.isLoading = false
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            }
            
        }
        
        
    }
    
    
    
}

extension DataVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchQuery.count
        } else {
            return dataArray.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        activityIndicator.startAnimating()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as? DataCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.index = indexPath
        
        if isSearching {
            cell.configureCell(data: searchQuery[indexPath.row])
            activityIndicator.stopAnimating()
        } else {
            
            cell.configureCell(data: dataArray[indexPath.row])
            activityIndicator.stopAnimating()

        }
        
        if !isFavorite {

            if indexPath.row == selectedIndex {

                cell.favButton.setImage(UIImage(named: "favoriteButton"), for: .normal)

            } else {

                cell.favButton.setImage(UIImage(named: "defaultstar"), for: .normal)

            }

        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contextHeight = scrollView.contentSize.height
        
        if offSetY > contextHeight - scrollView.frame.height {
            
            if !isLoading {
                // start an activity indicator
                activityIndicator.startAnimating()
                isSearching = false
                batchFetch()
            }
            
        }
    }
    
    
    
}

extension DataVC {
    
    func batchFetch() {
        
        pageNumber += 1
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            DataService.instance.getNamesData(url: String(format: DATA_LIST_URL, self.categoryId, self.genderId, self.pageNumber), completion: { (true, returnedData) in
                
                if let returnedData = returnedData {
                    self.dataArray.append(contentsOf: returnedData)
                }
                
                self.isLoading = false
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            })
            
        }
        
    }
    
}

extension DataVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchQuery = dataArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}

extension DataVC: DataCellDelegate {
    
    
    func getIndexPathForRow(indexpath: IndexPath, favButton: UIButton) {
        
        isFavorite = !isFavorite
        
        selectedIndex = indexpath.row
        tableView.reloadData()
        isFavorite = false
        print(indexpath.row)
        
        
        
    }
    
    
    
    
}
