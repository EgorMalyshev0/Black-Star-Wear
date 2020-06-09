import UIKit
import SVProgressHUD

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories: [Category] = []
    var subcategories: [Subcategory] = []
    var categoriesShowed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader().loadCategories { categories in
        self.categories = categories
        self.categoriesTableView.reloadData()
        }
        changeNavigationItem()
    }
    
    @objc func backbtn() {
        categoriesShowed = !categoriesShowed
        categoriesTableView.reloadData()
        changeNavigationItem()
    }
    
    func changeNavigationItem(name: String = "Категории") {
        if categoriesShowed {
            navigationItem.title = name
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.title = name
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backbtn))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if categoriesShowed {
            if let cell = sender as? UITableViewCell, let index = categoriesTableView.indexPath(for: cell), segue.identifier == "showProductsFromCategory", let vc = segue.destination as? ProductsViewController {
                    vc.id = categories[index.row].id
                    vc.pageTitle = categories[index.row].name
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
            }
        } else {
            if let cell = sender as? UITableViewCell, let index = categoriesTableView.indexPath(for: cell), segue.identifier == "showProductsFromCategory", let vc = segue.destination as? ProductsViewController {
            vc.id = subcategories[index.row].id
            vc.pageTitle = subcategories[index.row].name
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            }
        }
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoriesShowed {
            return categories.count
        } else {
            return subcategories.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        if categoriesShowed {
            cell.categoryLabel.text = categories[indexPath.row].name
            let imageUrlString = categories[indexPath.row].image
            Loader().getImage(string: imageUrlString, completion: { icon in
                cell.categoryImageView.image = icon
            })
            return cell
        } else {
            cell.categoryLabel.text = subcategories[indexPath.row].name
            let imageUrlString = subcategories[indexPath.row].iconImage
            Loader().getImage(string: imageUrlString, completion: { icon in
                cell.categoryImageView.image = icon
            })
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if categoriesShowed {
            if categories[indexPath.row].subcategories.isEmpty == false {
                categoriesShowed = !categoriesShowed
                self.subcategories = categories[indexPath.row].subcategories
                changeNavigationItem(name: categories[indexPath.row].name)
                self.categoriesTableView.reloadData()
            } else {
                self.performSegue(withIdentifier: "showProductsFromCategory", sender: tableView.cellForRow(at: indexPath))
            }
        } else {
            self.performSegue(withIdentifier: "showProductsFromCategory", sender: tableView.cellForRow(at: indexPath))
        }
    }
}
