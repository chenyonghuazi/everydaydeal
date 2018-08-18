//
//  TableViewCell.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/20.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import UIKit
import Firebase



class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var readingMark: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    //    var urlList2 = [String]()
    var detailText:String?
    @IBOutlet weak var imageV: UIImageView!
    var imageID:URL?
    var webAddress:String?
//    var delegate:TableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToWeb))
//        self.imageView?.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
        
//        self.detailTextLabel?.text = detailText
    }
    
    func setImage(){
        let placeImage = #imageLiteral(resourceName: "placeholder2")
        self.imageV.sd_setImage(with: imageID, placeholderImage: placeImage)
//        self.imageV.image = placeImage
        self.imageV.contentMode = .scaleAspectFill
        self.imageV.layer.cornerRadius = 6.0
        self.imageV.clipsToBounds = true
    }
    
    
     

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    @objc func goToWeb(){
//        if self.textLabel?.text != nil{
//            let story = UIStoryboard(name: "Main", bundle: nil)
//            let destVC = story.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
//            destVC.webAddress = self.textLabel?.text
////            self.present
//        }
//    }

}
