import UIKit

class BagViewController: UIViewController {

    var productsInBag: [ProductInBag] = []
    
    @IBOutlet weak var bagTableView: UITableView!
    @IBOutlet weak var finalButton: UIButton!
    @IBOutlet weak var finalCostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalButton.layer.cornerRadius = finalButton.frame.size.height / 2
        finalCostLabel.text = "\(countFinalCost()) руб."
        changeFinalButtonText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let products = Persistance.shared.retrieveProductsInBag()
        self.productsInBag = products
        bagTableView.reloadData()
        countFinalCost()
        changeFinalButtonText()
    }
    
    @IBAction func finalButtonAction(_ sender: Any) {
        if productsInBag.count == 0 {
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    func countFinalCost() {
        var count = 0
        for product in productsInBag {
            count += product.price
        }
        self.finalCostLabel.text = "\(count) руб."
    }
    func changeFinalButtonText() {
        if productsInBag.count == 0 {
            finalButton.setTitle("ВЕРНУТЬСЯ В КАТАЛОГ", for: .normal)
        } else {
            finalButton.setTitle("ОФОРМИТЬ ЗАКАЗ", for: .normal)
        }
    }
  
}

extension BagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsInBag.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagProduct") as! BagTableViewCell
        cell.nameLabel.text = productsInBag[indexPath.row].name
        cell.sizeLabel.text = "Размер: " + productsInBag[indexPath.row].size
        cell.priceLabel.text = "\(productsInBag[indexPath.row].price) руб."
        cell.trashButtonAction = { [unowned self] in
            Persistance.shared.deleteOneProduct(product: self.productsInBag[indexPath.row])
            self.productsInBag.remove(at: indexPath.row)
            tableView.reloadData()
            self.countFinalCost()
            self.changeFinalButtonText()
        }
        Loader().getImage(string: productsInBag[indexPath.row].mainImage) { (image) in
            cell.bagProductImageView.image = image
        }
        return cell
    }
}
