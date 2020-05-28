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
        if let doublePrice = Double(products[indexPath.row].price) {
            let intPrice = Int(doublePrice)
            cell.priceLabel.text = "\(intPrice) руб."
        } else {cell.priceLabel.text = products[indexPath.row].price}
        
        if let oldPrice = products[indexPath.row].oldPrice {
            if let doubleOldPrice = Double(oldPrice) {
                let intOldPrice = Int(doubleOldPrice)
                cell.oldPriceLabel.text = "\(intOldPrice) руб."
                let attrOldPrice = NSMutableAttributedString(string: "\(intOldPrice) руб.")
                attrOldPrice.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attrOldPrice.length))
                cell.oldPriceLabel.attributedText = attrOldPrice
            } else {cell.priceLabel.text = oldPrice}
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
    
}
