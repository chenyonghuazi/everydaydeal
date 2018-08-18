//
//  WebviewVC.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/23.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import UIKit

class WebviewVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var progressBar: UIProgressView!
    var webAddress:String?
    var theBool: Bool?
    var myTimer: Timer?
    @IBOutlet weak var textView: UITextView!
    @IBAction func Refresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
        
    }
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func backwardButton(_ sender: UIButton) {
        if self.webView.canGoBack{
            self.webView.goBack()
        }
    }
    @IBAction func forwardButton(_ sender: UIButton) {
        if self.webView.canGoForward{
            self.webView.goForward()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let myURL = URL.init(string: webAddress!)
//        let request: URLRequest = URLRequest(url: myURL!)
//        webView.loadRequest(request)
        // Do any additional setup after loading the view.
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
//        let myURL = URL.init(string: "http://www.youtube.com")
//        let request: URLRequest = URLRequest(url: myURL!)
//        webView.loadRequest(request)
        
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
//        navigationBar.backgroundColor = UIColor.clear
//        decorateTheButton()
//        refreshButton.tintColor = UIColor.black
        self.webView.delegate = self
        }
    override var prefersStatusBarHidden: Bool{
        return true
    }
//    override func viewDidAppear(_ animated: Bool) {
//        let myURL = URL.init(string: "www.youtube.com")
//        let request: URLRequest = URLRequest(url: myURL!)
//        webView.loadRequest(request)
    
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let image = #imageLiteral(resourceName: "topitem2")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navigationBar.frame.size.width
        let bannerHeight = navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationBar.topItem?.titleView = imageView
//        navigationItem.titleView = imageView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var copyButton: UIButton!
    
    @IBAction func copyLink(_ sender: UIButton) {
        let clipboard = UIPasteboard.general
        clipboard.string = self.textView.text
        let alert = UIAlertController(title: "完成！", message: self.textView.text, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    func decorateTheButton(){
//        self.copyButton.layer.cornerRadius = self.copyButton.frame.height / 2
//        self.copyButton.clipsToBounds = true
//        let image = #imageLiteral(resourceName: "board3")
//        self.copyButton.backgroundColor = UIColor.white
//        self.copyButton.setBackgroundImage(image, for: .normal)
////        self.copyButton.tintColor =
//
//    }
    
//    func setTitle(){
//        let lists = self.webAddress?.components(separatedBy: ".")
//
//        navigationBar.topItem?.title = lists?[1]
//    }
    
//    @objc func goBack(){
//        dismiss(animated: true, completion: nil)
//    }
    
    func checkURLVaild(urlString:String?) -> Bool{
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView){
        self.progressBar.progress = 0.0
        self.theBool = false
        self.myTimer = Timer.scheduledTimer(timeInterval: 0.01667, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    func funcToCallCalledWhenUIWebViewFinishesLoading() {
        self.theBool = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        self.progressBar.isHidden = true
    }
    
    @objc func timerCallback() {
        if !self.webView.isLoading{
            funcToCallCalledWhenUIWebViewFinishesLoading()
        }else{
            self.progressBar.isHidden = false
        }
        if self.theBool! {
            if self.progressBar.progress >= 1 {
                self.progressBar.isHidden = true
                self.myTimer?.invalidate()
            } else {
                self.progressBar.progress += 0.2
            }
        } else {
            self.progressBar.progress += 0.05
            if self.progressBar.progress >= 0.95 {
                self.progressBar.progress = 0.95
            }
        }
    }
    
    func setTextView(text:String){
        self.textView.text = text
        self.textView.font = UIFont.boldSystemFont(ofSize: 17)
        let deadSpace = textView.bounds.size.height - textView.contentSize.height
        let inset = max(0, deadSpace/2.0)
        textView.contentInset = UIEdgeInsetsMake(inset, textView.contentInset.left, inset, textView.contentInset.right)
        navigationBar.tintColor = textView.backgroundColor
        navigationBar.backgroundColor = textView.backgroundColor
//        self.textView.conte
//        self.textView.layer.borderWidth = 2
//        self.textView.layer.cornerRadius = self.textView.frame.height
//        self.textView.clipsToBounds = true
//        self.textView.layer.backgroundColor = UIColor.gray.cgColor
//        self.textView.layer.borderColor = UIColor(red: 0.11, green: 0.44, blue: 0.17, alpha: 1).cgColor
    }
    
    func setNavigationItem(){
        
        
        
        
        let image = #imageLiteral(resourceName: "topitem2")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navigationBar.frame.size.width
        let bannerHeight = navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationBar.topItem?.titleView = imageView
//        navigationItem.titleView = imageView
        
        //-----
        
//        let label = UILabel()
//        let lists = self.webAddress?.components(separatedBy: ".")
//        label.text = lists?[1]
//        let navItem = UINavigationItem(title: <#T##String#>)
//        navigationBar.
//        navigationBar.setItems([], animated: <#T##Bool#>)
    }

    

}
