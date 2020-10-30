//
//  ShowDetailsViewController.swift
//  CMoneyTask
//
//  Created by TANG,QI-RONG on 2020/10/28.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    var detailsData: CMoneyData?

    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var showIDLabel: UILabel!
    
    @IBOutlet weak var showTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIDLabel.text       = "\(detailsData!.id)"
        showTitleLabel.text    = detailsData?.title

        URLSession.shared.dataTask(with: detailsData!.url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.detailsImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
