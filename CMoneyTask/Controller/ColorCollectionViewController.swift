//
//  ColorCollectionViewController.swift
//  CMoneyTask
//
//  Created by TANG,QI-RONG on 2020/10/28.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CMoneyDataCell"

class ColorCollectionViewController: UICollectionViewController {

    var cMoneyData = [CMoneyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlStr = "https://jsonplaceholder.typicode.com/photos".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        
            let url = URL(string: urlStr) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let results = try? decoder.decode([CMoneyData].self, from: data) {
                    self.cMoneyData = results
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }.resume()
        }
        
        //Cell
        let width = (collectionView.bounds.width - 0 * 3) / 4
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cMoneyData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BackGroundCollectionViewCell
    
        let moneyData = cMoneyData[indexPath.row]
        cell.idLabel.text = "\(moneyData.id)"
        cell.titleLebel.text = moneyData.title
        
        //小圖示
        URLSession.shared.dataTask(with: moneyData.thumbnailUrl) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.backGroundImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    @IBSegueAction func showDetailSegue(_ coder: NSCoder) -> ShowDetailsViewController? {
        
        let destinationController = ShowDetailsViewController(coder: coder)
        if let cell = collectionView.indexPathsForSelectedItems?.first?.row {
            
            destinationController?.detailsData = cMoneyData[cell]
        }
        
        return destinationController
    }
    

}
