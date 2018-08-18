//
//  searchBarVC.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/6.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate{
    
    
    
    func setSearchBar(){
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: (self.navigationBar.frame.height), width: self.view.frame.width, height: 50))
        searchbar.delegate = self
        searchbar.placeholder = "Enter Brand"
        self.tableV.tableHeaderView = searchbar
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancelKeyboard))
        let fspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [fspace,barButton]
        searchbar.inputAccessoryView = toolBar
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            self.filteredObjects = [Model]()
            self.isSearch = false
            self.view.endEditing(true)
            self.tableV.reloadData()
        }else{
            self.isSearch = true
            self.filteredObjects = objects.filter({ (model) -> Bool in
                return (model.brand!.contains(searchBar.text!.lowercased()))
            })
            self.tableV.reloadData()
        }
        self.tableV.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func cancelKeyboard(){
        self.view.endEditing(true)
    }
}
