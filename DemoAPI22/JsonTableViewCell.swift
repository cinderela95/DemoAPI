//
//  JsonTableViewCell.swift
//  DemoAPI22
//
//  Created by Phan Minh Thang on 9/1/20.
//  Copyright © 2020 Phan Minh Thang. All rights reserved.
//

import UIKit

class JsonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgImage: UIImageView!
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    
    func getData(data: UserInfo) {
        lblAge.text = String(data.age)
        lblUserName.text = data.userName
        lblLocation.text = data.location
        lblGender.text = data.gender
        
        URLSession.shared.dataTask(with: URL(string: data.image)!) { (data, reponse, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgImage.image = image
            }
        }.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
