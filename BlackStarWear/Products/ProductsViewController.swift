import UIKit

class ProductsViewController: UIViewController {
    
    var products: [Product] = []
    var id = "308"
    var pageTitle = ""
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pageTitle
        guard id.isEmpty == false else {return}
        Loader().loadProduct(id: id) { products in
            self.products = products
            self.productsCollectionView.reloadData()
        }
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "Product", for: indexPath) as! ProductCollectionViewCell
        cell.productLabel.text = products[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width/2 - 22.5
        let h = w / 0.6
        return CGSize(width: w, height: h)
    }
    
}
