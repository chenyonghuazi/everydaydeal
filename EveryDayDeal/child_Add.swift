//
//  child_Add.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/29.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
extension ViewController{
    
    func getAllImage2(){
        handle = fir?.child("image").observe(.childAdded, with: { (snapshot) in
//            self.keys.insert(snapshot.key, at: 0)
//            print("now-snapshot:\(snapshot)")
//            print("self.keys\(self.keys)")
            if snapshot.value != nil{
                if let dic = snapshot.value as? [String:String]{
                    self.objects.insert(Model(key:snapshot.key,url:dic["imageID"]!,webAddress: dic["webAddress"]!,
                                              brand: dic["brand"]!, category: dic["category"]!), at: 0)
//                    self.urlList.insert(dic["imageID"]!, at: 0)
//                    self.website.insert(dic["webAddress"]!, at: 0)
                    
//                    print("self.urlList\(self.urlList)")
//                    print("selfwebsite\(self.website)")
                    self.readingMark.insert("未读", at: 0)
                    self.tableV.reloadData()
                }
            }
        })
//        completion(self)
        self.tableV.reloadData()
    }
    
    func getAllImage3(completion:(ViewController) ->()) {
//        var newList = [String]()
//        var newWebsite = [String]()
        handle = fir?.child("image").observe(.childAdded, with: { (snapshot) in
            if !self.keys.contains(snapshot.key){
                self.keys.insert(snapshot.key, at: 0)
            }
//            self.keys.append(snapshot.key)
            print("now-key:\(snapshot.key)")
            print("self.keys\(self.keys)")
            if snapshot.value != nil{
                if let dic = snapshot.value as? [String:String]{
                    if !self.urlList.contains(dic["imageID"]!){
                        self.urlList.insert(dic["imageID"]!, at: 0)
                    }
//                    self.urlList.insert(dic["imageID"]!, at: 0)
//                    self.website.insert(dic["webAddress"]!, at: 0)
                    if !self.website.contains(dic["webAddress"]!){
                        self.website.insert(dic["webAddress"]!, at: 0)
                    }
                    print("self.urlList\(self.urlList)")
                    print("selfwebsite\(self.website)")
                    self.tableV.reloadData()
                }
            }
        })
        self.tableV.reloadData()
        completion(self)
    }
//
//    func completion(){
//        self.fir?.removeAllObservers()
//    }
    
    
}

