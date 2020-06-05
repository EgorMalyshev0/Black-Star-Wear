import UIKit

class ProductDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var product: Product?

    @IBOutlet weak var productImagesView: UIView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var bagButton: UIButton!
    @IBAction func addToBagButton(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Выберите размер", preferredStyle: .actionSheet)
        let sizes = product!.offers
        for size in sizes {
            let btn = UIAlertAction(title: size, style: .default) { (action) in
                if let product = self.product {
                    let productInBag = ProductInBag(product: product)
                    productInBag.size = size
                    Persistance.shared.addProductToBag(product: productInBag)
                }
            }
            alert.addAction(btn)
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {
            return
        }
        productNameLabel.text = product.name
        productPriceLabel.text = "\(product.intPrice) ₽"
        productDescriptionLabel.text = product.description
        bagButton.layer.cornerRadius = 10
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: productImagesView.frame.size.height))
        scroll.isPagingEnabled = true
        productImagesView.addSubview(scroll)
        for (index, img) in product.productImages.enumerated() {
            let view = UIImageView(frame: CGRect(x: scroll.frame.size.width * CGFloat(index), y: 0, width: productImagesView.frame.size.width, height: productImagesView.frame.size.height))
            Loader().getImage(string: img) { (image) in
                view.image = image
            }
            view.contentMode = .scaleAspectFill
            scroll.addSubview(view)
        }
        scroll.contentSize = CGSize(width: view.frame.size.width * CGFloat(product.productImages.count), height: scroll.frame.size.height)
        scroll.delegate = self
        imagesPageControl.numberOfPages = product.productImages.count
        imagesPageControl.currentPage = 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        imagesPageControl.currentPage = Int(pageIndex)
    }
}
