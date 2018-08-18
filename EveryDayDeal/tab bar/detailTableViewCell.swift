//
//  detailTableViewCell.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/7.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

protocol detailProtocoldelegate {
    func presentView(brand:String)
}

class detailTableViewCell: UITableViewCell {
    
    var delegate:detailProtocoldelegate!
    var brandString:String?
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.window?.rootViewController =  detailViewController()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func goToLocation(_ sender: UIButton) {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        self.window?.rootViewController?.present(mapVC, animated: true, completion: nil)
        delegate.presentView(brand:brandString!)
    }
    
    
    
}
