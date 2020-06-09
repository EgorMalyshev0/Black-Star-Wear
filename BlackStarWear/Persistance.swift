import Foundation
import RealmSwift
import Realm

class ProductInBag: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var mainImage: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var size: String = ""
    
    convenience init(product: Product) {
        self.init()
        self.id = product.id
        self.name = product.name
        self.mainImage = product.mainImage
        self.price = product.intPrice
    }
}

class Persistance {
    
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func addProductToBag(product: ProductInBag) {
        try! realm.write{
            realm.add(product)
        }
    }
    func deleteProducts(products: [ProductInBag]) {
        try! realm.write {
            realm.delete(products)
        }
    }
    func deleteOneProduct(product: ProductInBag) {
        try! realm.write {
            realm.delete(product)
        }
    }
    func retrieveProductsInBag() -> [ProductInBag] {
        let result = realm.objects(ProductInBag.self)
        let allProducts = Array(result)
        return allProducts
    }
    func retrieveProductAtId(id: String) -> Results<ProductInBag>{
        let product = realm.objects(ProductInBag.self).filter("id == '\(id)'")
        return product
    }
    
}
