//
//  DetailViewController.swift
//  SALTPARSE
//
//  Created by SALTSIDE on 13/11/18.
//  Copyright © 2018 SALTSIDE. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var saltImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var DescriptionView: UITextView!
    
    var imageStr : String = ""
    var titleStr : String = ""
    var descriptionStr :String = ""
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
        
        // Set Data
        self.titleLabel.text = titleStr
        self.DescriptionView.text = descriptionStr
        saltImageView.downloaded(from:imageStr )

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
