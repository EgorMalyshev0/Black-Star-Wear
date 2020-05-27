import UIKit

class Loader {
    
    func loadCategories(completion: @escaping([Category]) -> Void) {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!
        if let data = try? Data(contentsOf: url) {
            if let loadedCategories = parseCategories(json: data) {
                completion(loadedCategories)
            } else { print("NOPE")}
        }
    }
    
    func parseCategories(json: Data) -> [Category]? {
        var categories: [Category] = []
        let decoder = JSONDecoder()
        if let jsonCategories = try? decoder.decode([String:Category].self, from: json){
            var count = categories.count
            for (id, data) in jsonCategories {
                categories.append(data)
                categories[count].id = id
                count = categories.count
            }
            return categories
        } else { return nil }
    }
    
    func loadProduct(id: String, completion: @escaping([Product]) -> Void) {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + id)!
        if let data = try? Data(contentsOf: url) {
            if let loadedProducts = parseProducts(json: data) {
                completion(loadedProducts)
                print("Products: \(loadedProducts.count)")
            } else { print("NO")}
        }
    }
    
    func parseProducts(json: Data) -> [Product]? {
        var products: [Product] = []
        let decoder = JSONDecoder()
        if let jsonCategories = try? decoder.decode([String:Product].self, from: json){
            var count = products.count
            for (id, data) in jsonCategories {
                products.append(data)
                products[count].id = id
                count = products.count
            }
            return products
        } else { return nil }
    }
    
    func getImage (string: String, completion: @escaping(UIImage) -> Void) {
        DispatchQueue.global().async {
            let blackStarUrl = "https://blackstarshop.ru/"
            guard let url = URL(string: blackStarUrl + string), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion (image)
            }
        }
    }
}
