//
//  child_Add_tab.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/7.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import UIKit

extension tabViewController{
    
    func getAllImage2(){
        handle2 = fir2?.child("image").observe(.childAdded, with: { (snapshot) in
            if snapshot.value != nil{
                if let dict = snapshot.value as? [String:String]{
                    if let _ = self.data[dict["category"]!]{
                        //                            print("error1")
                        if !(self.data[dict["category"]!]?.contains(dict["brand"]!))!{
                            self.data[dict["category"]!] = self.data[dict["category"]!]! + "," + dict["brand"]!
                        }else{
                            //do nothing to prevent duplication
                        }
                        
                        //                            print("self.data:\(self.data)")
                    }else{
                        //                            print("error2")
                        self.data[dict["category"]!] = dict["brand"]!
                        //                            print("self.data:\(self.data)")
                    }
                    
                    if let _ = self.data[(dict["brand"]!)]{
                        //do nothing
                    }else{
                        self.data[dict["brand"]!] = dict["imageID"]! + ".jpg"
                    }
                    
                }
            }
        })
    }
}
