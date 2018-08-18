//
//  PictureViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/26.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var image:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let placeImage = #imageLiteral(resourceName: "placeholder2")
        if image != nil{
            self.imageV.sd_setImage(with: image, placeholderImage: placeImage)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
//    func setImageV(){
//        self.imageV.image = image
//        self.imageV.contentMode = .scaleAspectFit
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
