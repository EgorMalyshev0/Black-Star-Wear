import UIKit

class BagTableViewCell: UITableViewCell {

    @IBOutlet weak var bagProductImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    var trashButtonAction: (()->()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func deleteFromBag(_ sender: UIButton) {
        trashButtonAction()
    }
}
