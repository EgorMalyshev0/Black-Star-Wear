import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    var categories: [Category] = []
    
    enum ProductSegue: String {
        case showProductsFromCategory = "showProductsFromCategory"
        case showSubcategories = "showSubcategories"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader().loadCategories { categories in
        self.categories = categories
        self.categoriesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = categoriesTableView.indexPath(for: cell) {
            switch segue.identifier {
                case "showSubcategories":
                    guard let vc = segue.destination as? SubcategoriesViewController else {break}
                    let subcategories = categories[index.row].subcategories
                    vc.subcategories = subcategories
                    vc.pageTitle = categories[index.row].name
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
                case "showProductsFromCategory":
                    guard let vc = segue.destination as? ProductsViewController else {break}
                    vc.id = categories[index.row].id ?? "0"
                    vc.pageTitle = categories[index.row].name
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
                default:
                    break
            }
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
        Loader().getImage(string: imageUrlString, completion: { icon in
            cell.categoryImageView.image = icon
        })
        cell.categoryImageView.layer.cornerRadius = cell.categoryImageView.frame.width / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(categories[indexPath.row].id ?? "no")
        if categories[indexPath.row].subcategories.isEmpty == false {
            self.performSegue(withIdentifier: "showSubcategories", sender: tableView.cellForRow(at: indexPath))
        } else {
            self.performSegue(withIdentifier: "showProductsFromCategory", sender: tableView.cellForRow(at: indexPath))
        }
    }
}
