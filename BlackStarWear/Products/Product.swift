import Foundation

struct Product {
    let id, name, mainImage, price, description: String
    let oldPrice, tag: String?
    var offers: [String]
    var productImages: [String]
    var intPrice: Int {
        let doublePrice = Double(price)!
            return Int(doublePrice)
    }
    var intOldPrice: Int? {
        if let oldPrice = oldPrice {
            return Int(Double(oldPrice)!)
        }
        return nil
    }
        
    init?(id: String, data: NSDictionary) {
        guard let name = data["name"] as? String,
            let mainImage = data["mainImage"] as? String,
            let price = data["price"] as? String,
            let description = data["description"] as? String,
            let oldPrice = data["oldPrice"] as? String?,
            let tag = data["tag"] as? String?,
            let offers = data["offers"] as? NSArray,
            let productImages = data["productImages"] as? NSArray
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.mainImage = mainImage
        self.price = price
        self.description = description
        self.oldPrice = oldPrice
        self.tag = tag
        self.offers = []
        self.productImages = []
        if offers.count != 0 {
            for offer in offers where offer is NSDictionary {
                if let offer = Offer(data: offer as! NSDictionary) {
                    self.offers.append(offer.size)
                }
            }
        }
        if productImages.count != 0 {
            for img in productImages where img is NSDictionary {
                if let image = ProductImage(data: img as! NSDictionary) {
                    self.productImages.append(image.imageURL)
                }
            }
        }
    }
}

struct Offer {
    let size: String
    let productOfferID: String
    
    init?(data: NSDictionary) {
        guard let size = data["size"] as? String,
            let productOfferID = data["productOfferID"] as? String
        else {
            return nil
        }
        self.size = size
        self.productOfferID = productOfferID
    }
}

struct ProductImage {
    let imageURL: String
    
    init?(data: NSDictionary) {
        guard let imageURL = data["imageURL"] as? String
        else {
            return nil
        }
        self.imageURL = imageURL
    }
}

