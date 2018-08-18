//
//  ViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/20.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SafariServices


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableV: UITableView!
    var keys = [String]()
    var urlList = [String]()
    var website = [String]()
    var resources = [String:Any]()
    var finalTextViewText:String?
    var readingMark = [String]()
    var objects = [Model]()
    var filteredObjects = [Model]()
    var url:URL?
    var fir:DatabaseReference?
    var handle:DatabaseHandle?
    var refreshController:UIRefreshControl = UIRefreshControl()
    
    var isSearch:Bool = false
//    var selectedImage:URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
//        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        navigationBar.topItem?.title = "EveryDayDeal"
//        self.view.addSubview(navigationBar)
//        self.navigationController?.navigationBar.topItem?.title = "Everday Deal"
        
        fir = Database.database().reference()
//        print("viewLoadAgain!")
        getAllImage2()
//        let width = self.view.frame.width
//        let height = self.view.frame.height
//        let ratio = height / width
//        print("width:\(width)")
//        print("height:\(height)")
//        print("ratio:\(ratio)" )
        self.tableV.separatorStyle = .none
        setRefreshVC()
//        updateDataBase()
        setSearchBar()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewDidAppear")
//        updateDataBase()
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("viewWillAppear")
//        updateDataBase()
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisAppear")
//        updateDataBase()
    }
    
    
    
    var newChild:String!
    
    func sortAllIamge(lists: [String]) -> [String]{
        var newList = [Int]()
        var returnList = [String]()
        for item in lists{
            newList.append(Int(item)!)
        }
//        newList = newList.sorted()
        newList = newList.sorted(by: {$0 > $1})
        for index in newList{
            returnList.append(String(index))
        }
        return returnList
    }
    

    func getAllImage(){
        
        handle = fir?.child("image").observe(.value, with: { (snapshot) in
            print(snapshot)
            
//            print("2")
//            print(snapshot)
//
//            print("4")
//            print(snapshot.exists())
            if let dict = snapshot.value as? [String:Any]{
                print(dict)
                self.keys = Array(dict.keys)
                self.resources = (snapshot.value as? [String:Any])!
//                print("resources:")
//                print(self.resources)
                print(self.keys)
                self.keys = self.sortAllIamge(lists: self.keys)
//                print("sorted\(self.keys)")
//                self.fir?.removeObserver(withHandle: self.handle!)
                self.forLoopFindChild(completion: {
                    self.fir?.removeAllObservers()
                })
                
//                self.keys.append(snapshot.value as! String)
            }
        })
        
    }
    func extractKeyToText(model:[Model], path: IndexPath) -> String{
        print("functionCall:\(path.row)")
        
        let webAddress = model[path.row].webAddress
        
//        print("webAddress:\(webAddress)")
        let key = model[path.row].key!
//        print("key:\(key)")
        let indexForKey1 = key.index(key.startIndex, offsetBy: 3) // year
        let indexForKey1_half = key.index(key.startIndex, offsetBy: 4) // month
        let indexForKey2 = key.index(key.startIndex, offsetBy: 5) //month
        let indexForKey2_half = key.index(key.startIndex, offsetBy: 6)//day
        let indexForKey3 = key.index(key.startIndex, offsetBy: 7)//day
        let SecondPartOfTextView = key[...indexForKey1]
        let ThirdPartOfTextView = key[indexForKey1_half...indexForKey2]
        let FourthPartOfTextView = key[indexForKey2_half...indexForKey3]
        let firstPartOfTextView = (webAddress!.components(separatedBy: "."))[1]
        var finalTextViewText = firstPartOfTextView + " " + SecondPartOfTextView
        finalTextViewText = finalTextViewText + "-" + ThirdPartOfTextView
        finalTextViewText = finalTextViewText + "-" + FourthPartOfTextView
        return finalTextViewText
    }
    
    func alertChooseControl(model:[Model], path: IndexPath){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = UIColor.black
        let alertOpenImageAction = UIAlertAction(title: "查看大图", style: .default) { (action) in
            let story = UIStoryboard(name: "Main", bundle: nil)
            let destVC = story.instantiateViewController(withIdentifier: "PictureViewController") as! PictureViewController
            destVC.image = URL(string:model[path.row].url! + ".jpg")
            self.present(destVC, animated: true, completion: nil)
        }
        let alertOpenWebAction = UIAlertAction(title: "打开网页(beta)", style: .default) { (action) in
            
            let webAddress = model[path.row].webAddress
            let webVC = UIStoryboard(name: "Main", bundle: nil)
            let destVC = webVC.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
            destVC.webAddress = webAddress
            let url = URL.init(string:webAddress!)
            let urlrequest = URLRequest(url: url!)
            self.present(destVC, animated: true) {
                if destVC.checkURLVaild(urlString: webAddress){
                    destVC.webView.loadRequest(urlrequest)
                    destVC.webViewDidStartLoad(destVC.webView) // progress bar
                    self.finalTextViewText = self.extractKeyToText(model:model, path: path)
                    
                    destVC.setTextView(text: self.finalTextViewText!)
                    destVC.setNavigationItem()
                }
                
            }
//            self.readingMark[path.row] = "已读"
//            self.tableV.reloadData()
            self.updateReadingMark(model:model[path.row], path: path)
            self.tableV.reloadData()
        }
        
        let alertOpenSafari = UIAlertAction(title: "用Safari打开网页", style: .default) { (action) in
            let webAddress = model[path.row].webAddress
            let safari = SFSafariViewController(url: URL(string:webAddress!)!)
            self.present(safari, animated: true, completion: nil)
//            self.readingMark[path.row] = "已读"
//            self.tableV.reloadData()
            self.updateReadingMark(model:model[path.row], path: path)
            self.tableV.reloadData()
        }
        let alertCancelAction = UIAlertAction(title: "取消", style: .cancel)
        alert.addAction(alertOpenImageAction)
        alert.addAction(alertOpenSafari)
        alert.addAction(alertOpenWebAction)
        alert.addAction(alertCancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func forLoopFindChild(completion:() -> ()){
//        let time = currentDate()
        for Key in keys {
//            newChild = time + String(Key)
//            if fir?.child("image").child(newC
//            print("Key")
//            print(Key)
            handle = fir?.child("image").child(Key).observe(.value, with: { (SnapShot) in
//                print(self.fir?.child("image").child(Key))
//                print(SnapShot.exists())
                
                if SnapShot.exists() || SnapShot.value != nil{
                    if let dictionary = SnapShot.value as? [String:String]{
//                        print(dictionary)
                        if dictionary["imageID"] != nil{
                            self.resources[dictionary["imageID"]!] = dictionary["webAddress"]
                            self.urlList.append(dictionary["imageID"]!)
                            self.website.append(dictionary["webAddress"]!)
//                            print("urlList")
//                            print(self.urlList)
//                            print("resources")
//                            print(self.resources)
//                            print("webAddress:" + dictionary["webAddress"]!)
//                            print("imageID:" + dictionary["imageID"]!)
                            self.tableV.reloadData()
//                            self.fir?.removeObserver(withHandle: self.handle!)
                        }
                        
                        
                    }
                }
            })
            completion()
        }
//        print("imageID.count")
//        print(self.urlList.count)
    }
    
    func currentDate() -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-DD"
        let current = dateFormat.string(from: Date())
        return current
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch{
            return self.filteredObjects.count
        }else{
            return self.objects.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        let url = URL(string:urlList[indexPath.row] + ".jpg")
        
        if isSearch{
            url = URL(string: self.filteredObjects[indexPath.row].url! + ".jpg")
            if UserDefaults.standard.value(forKey: "readingMark") != nil{
                var currentData = UserDefaults.standard.value(forKey: "readingMark") as! [String:String]
                if currentData[self.filteredObjects[indexPath.row].key!] != nil {
                    cell.readingMark.text = "已读"
                }else{
                    cell.readingMark.text = "未读"
                }
            }else{
                cell.readingMark.text = "未读"}
            if self.filteredObjects[indexPath.row].webAddress != nil{
                cell.detailLabel.text = extractKeyToText(model: filteredObjects, path: indexPath)
            }
        }else{
            url = URL(string: self.objects[indexPath.row].url! + ".jpg")
            if UserDefaults.standard.value(forKey: "readingMark") != nil{
                var currentData = UserDefaults.standard.value(forKey: "readingMark") as! [String:String]
                if currentData[self.objects[indexPath.row].key!] != nil {
                    cell.readingMark.text = "已读"
                }else{
                    cell.readingMark.text = "未读"
                }
            }else{
                cell.readingMark.text = "未读"}
            if self.objects[indexPath.row].webAddress != nil{
                cell.detailLabel.text = extractKeyToText(model: objects, path: indexPath)
            }
            
        }
        
        cell.imageID = url
        cell.setImage()
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let webAddress = website[indexPath.row]
//        let videoURL = URL(string: webAddress)!
//        let safariVC = SFSafariViewController(url: videoURL)
//
//        present(safariVC, animated: true, completion: nil)
//        let url2 = URL(string:urlList[indexPath.row] + ".jpg")
        if isSearch{
            alertChooseControl(model: filteredObjects, path: indexPath)
        }else{
            alertChooseControl(model: objects, path: indexPath)
        }
        
        
        
        
        //-----------
//        tableView.deselectRow(at: indexPath, animated: true)
//        let webVC = UIStoryboard(name: "Main", bundle: nil)
//        let destVC = webVC.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
//        destVC.webAddress = webAddress
//        let url = URL.init(string:webAddress)
//        let urlrequest = URLRequest(url: url!)
//        present(destVC, animated: true) {
//            destVC.webView.loadRequest(urlrequest)
//            destVC.setTextView(text: webAddress)
//            destVC.setNavigationItem()
//        }
        
//        destVC.webView.loadRequest(urlrequest)
        }
        
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.estimatedRowHeight = 200
//        return UITableViewAutomaticDimension
        return 250
    }

   

}



