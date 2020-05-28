import Foundation

class Product {
    let id, name, mainImage, price: String
    let oldPrice, tag: String?
    
    init?(id: String, data: NSDictionary) {
        guard let name = data["name"] as? String,
            let mainImage = data["mainImage"] as? String,
            let price = data["price"] as? String,
            let oldPrice = data["oldPrice"] as? String?,
            let tag = data["tag"] as? String?
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.mainImage = mainImage
        self.price = price
        self.oldPrice = oldPrice
        self.tag = tag
    }
}
