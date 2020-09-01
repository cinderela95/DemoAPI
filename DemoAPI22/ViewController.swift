//
//  ViewController.swift
//  DemoAPI22
//
//  Created by Phan Minh Thang on 9/1/20.
//  Copyright © 2020 Phan Minh Thang. All rights reserved.
//

import UIKit

struct Result: Codable {
    var data: [UserInfo] = []
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userInfo: [UserInfo] = []
    var image: UIImage?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getData()
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! JsonTableViewCell
        let user = userInfo[indexPath.row]
        cell.getData(data: user)
        return cell
    }
    
    
    func getData() {
        let jsonUrl = "http://demo0737597.mockable.io/master_data"
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                self.userInfo = result.data
                DispatchQueue.main.async {
                    self.tblTableView.reloadData()
                    self.lblNoData.isHidden = !(self.userInfo.count == 0)
                    if self.userInfo.count == 0 {
                        self.lblNoData.isHidden = true
                    }
                    else {
                        self.lblNoData.isHidden = false
                    }
                }
            }
            catch {
                self.lblNoData.isHidden = false
                self.tblTableView.isHidden = true
            }
        }.resume()
        
    }
    
    
    @IBOutlet weak var tblTableView: UITableView!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tblTableView.reloadData()
        tblTableView.delegate = self
        tblTableView.dataSource = self
        tblTableView.register(UINib(nibName: "JsonTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
         
        // Do any additional setup after loading the view.
    }
    
    
}

