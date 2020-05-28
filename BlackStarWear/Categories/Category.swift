import Foundation

class Category {
    let id, name, image, iconImage, iconImageActive: String
    var subcategories: [Subcategory]
    
    init?(id: String, data: NSDictionary) {
        guard let name = data["name"] as? String,
            let image = data["image"] as? String,
            let iconImage = data["iconImage"] as? String,
            let iconImageActive = data["iconImageActive"] as? String,
            let subcategories = data["subcategories"] as? NSArray
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
        self.subcategories = []
        if subcategories.count != 0 {
            for data in subcategories where data is NSDictionary {
                if let subcategory = Subcategory(data: data as! NSDictionary) {
                    self.subcategories.append(subcategory)
                }
            }
        }
    }
}

class Subcategory {
    let id, name, iconImage: String
    
    init?(data: NSDictionary) {
        guard let id = data["id"] as? String,
            let name = data["name"] as? String,
            let iconImage = data["iconImage"] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.iconImage = iconImage
    }
}

