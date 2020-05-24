//
//  SubcategoryViewController.swift
//  BlackStarWear
//
//  Created by Egor Malyshev on 21.05.2020.
//  Copyright © 2020 Egor Malyshev. All rights reserved.
//

import UIKit

class SubcategoriesViewController: UIViewController {
    
    @IBOutlet weak var subcategoryTableView: UITableView!
    
    var subcategories: [Subcategory] = []
    var pageTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pageTitle
    }
}

extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        cell.categoryLabel.text = subcategories[indexPath.row].name
        let imageUrlString = subcategories[indexPath.row].iconImage
        CategoriesLoader().getImage(string: imageUrlString, completion: { icon in
            cell.categoryImageView.image = icon
        })
        return cell
    }
}
