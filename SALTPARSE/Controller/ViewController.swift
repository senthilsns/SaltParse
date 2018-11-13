//
//  ViewController.swift
//  SALTPARSE
//
//  Created by SALTSIDE on 13/11/18.
//  Copyright © 2018 SALTSIDE. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    // Array of Person Model class
    var arrayOfList : [InfoModel] = []{
        // Reload data when data set
        didSet{
       DispatchQueue.main.async {
          self.tableView.reloadData()
       }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        
        setupTableView()
        getInfoFromAPI()
        

    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfoFromAPI() {
        
        let urlString = "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data"
        
        //creating a NSURL
        let url = NSURL(string: urlString)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            
            do {
                let decoder = JSONDecoder()
                self.arrayOfList = try decoder.decode([InfoModel].self, from: (data)!)
                
                print(self.arrayOfList)
            }catch {
                // Error
            }
            
        }).resume()
    }
        
    


}

extension ViewController {
    
    func setupTableView()  {
    
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //MARK:UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        var cell : SaltCell? = tableView.dequeueReusableCell(withIdentifier: "SaltCell") as? SaltCell
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "SaltCell") as? SaltCell

        }
        
        let listObj = arrayOfList[indexPath.row]
        cell?.titleLabel.text = listObj.title
        cell?.descriptionLabel.text = listObj.description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 172.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        let listObj = arrayOfList[indexPath.row]
        vc?.titleLabel?.text = listObj.title!
        vc?.DescriptionView?.text = listObj.description
        vc?.imageStr = listObj.image!
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
}

