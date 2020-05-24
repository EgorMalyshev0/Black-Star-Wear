import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesLoader().loadCategories { categories in
        self.categories = categories
        self.categoriesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = categoriesTableView.indexPath(for: cell), let vc = segue.destination as? SubcategoriesViewController, segue.identifier == "showSubcategories" {
            let subcategories = categories[index.row].subcategories
            vc.subcategories = subcategories
            vc.pageTitle = categories[index.row].name
        }
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        cell.categoryLabel.text = categories[indexPath.row].name
        let imageUrlString = categories[indexPath.row].image
        CategoriesLoader().getImage(string: imageUrlString, completion: { icon in
            cell.categoryImageView.image = icon
        })
        cell.categoryImageView.layer.cornerRadius = cell.categoryImageView.frame.width / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if categories[indexPath.row].subcategories.isEmpty == false {
            self.performSegue(withIdentifier: "showSubcategories", sender: tableView.cellForRow(at: indexPath))
        }
    }
}
