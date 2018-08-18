//
//  tabViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/4.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase

class tabViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    let lists = ["tool", "phone plan", "make up", "food", "gift card", "pet", "furniture", "daily", "baby", "electronic", "sale", "office","warehouse"]
    
    var fir2:DatabaseReference?
    var handle2:DatabaseHandle?
    var keys = [String]()
    var data = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame.width)
        print(self.view.frame.height)
        fir2 = Database.database().reference()
        // Do any additional setup after loading the view.
        getAllImage2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageV.image = UIImage(named: lists[indexPath.row])
        cell.imageV.layer.cornerRadius = cell.imageV.frame.height / 2
        cell.imageV.clipsToBounds = true
        cell.imageV.contentMode = .scaleAspectFit
//        cell.imageV.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touched))
//        cell.imageV.addGestureRecognizer(tapGesture)
        cell.label.text = lists[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        getAllImage()
        var components = [String]()
        if let data = self.data[lists[indexPath.row]]{
            components = data.components(separatedBy: ",")
        }
        let story = UIStoryboard(name: "Main", bundle: nil)
        let destVC = story.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        destVC.receivingData = components
        destVC.naviTitle = lists[indexPath.row]
        destVC.data = self.data
        present(destVC, animated: true, completion: nil)
    }
    
    func splitCategory(){
        
    }
    
    func getAllImage(){
        
        handle2 = fir2?.child("image").observe(.value, with: { (snapshot) in
            print("get into")
//            print(snapshot)
//            let aa = snapshot.value as? [String:Any]
//            print(aa)
            if snapshot.value != nil{
                if let dict = snapshot.value as? [String:Any]{
//                    print("error 0 ")
//                    if let test = self.data[dict["category"]!] as? String{
//                        print("error1")
//                        self.data[dict["category"]!] = dict["brand"]!
//                    }else{
//                        print("error2")
//                        self.data[dict["category"]!] = self.data[dict["category"]!]! + "," + dict["brand"]!
//                    }
                self.keys = Array(dict.keys)
//                    self.data[""]
//                    print("newdata:\(self.data)")
                    self.forLoopFindChild()
                }
            }
        })
    }
    
    func forLoopFindChild(){
        for key in self.keys{
            handle2 = fir2?.child("image").child(key).observe(.value, with: { (snapshot) in
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

                    }
//                    print("self.data:\(self.data)")
                }
            })
        }
    }
    
//    @objc func touched(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        self.present(mapVC, animated: true, completion: nil)
//    }
    
    

}
