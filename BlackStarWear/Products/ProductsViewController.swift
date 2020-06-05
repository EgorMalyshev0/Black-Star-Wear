import UIKit

class ProductsViewController: UIViewController {
    
    var products: [Product] = []
    var id = ""
    var pageTitle = ""
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pageTitle
        Loader().loadProducts(id: id) { products in
            self.products = products
            self.productsCollectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let index = productsCollectionView.indexPath(for: cell), segue.identifier == "showProductDetails", let vc = segue.destination as? ProductDetailsViewController {
            vc.product = products[index.row]
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
        let str = products[indexPath.row].mainImage
        Loader().getImage(string: str) { (img) in
            cell.productImageView.image = img
        }
        cell.priceLabel.text = "\(products[indexPath.row].intPrice) руб."
        
        if products[indexPath.row].oldPrice != nil {
            if let intOldPrice = products[indexPath.row].intOldPrice {
                cell.oldPriceLabel.text = "\(intOldPrice) руб."
                let attrOldPrice = NSMutableAttributedString(string: "\(intOldPrice) руб.")
                attrOldPrice.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attrOldPrice.length))
                cell.oldPriceLabel.attributedText = attrOldPrice
            }
            if let tag = products[indexPath.row].tag {
                cell.tagLabel.text = tag
            } else {
                cell.tagView.isHidden = true
            }
            return cell
        } else {
            cell.oldPriceLabel.isHidden = true
            cell.priceLabel.textColor = .black
            if let tag = products[indexPath.row].tag {
                cell.tagLabel.text = tag
                cell.tagView.backgroundColor = .systemGreen
            } else {
                cell.tagView.isHidden = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width/2 - 22.5
        let h = w / 0.6
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
