import UIKit

class Loader {
    
    func loadCategories(completion: @escaping([Category]) -> Void) {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                var categories: [Category] = []
                for (key, data) in jsonDict where data is NSDictionary {
                    if let category = Category(id: key as! String, data: data as! NSDictionary) {
                        categories.append(category)
                    }
                }
                DispatchQueue.main.async {
                    completion(categories)
                }
            }
        }
        task.resume()
    }
    
    func loadProducts(id: String, completion: @escaping([Product]) -> Void) {
        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + id)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                var products: [Product] = []
                for (key, data) in jsonDict where data is NSDictionary {
                    if let product = Product(id: key as! String, data: data as! NSDictionary) {
                        products.append(product)
                    }
                }
                DispatchQueue.main.async {
                    completion(products)
                }
            }
        }
        task.resume()
    }

//    func loadProduct(id: String, completion: @escaping([Product]) -> Void) {
//        let url = URL(string: "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + id)!
//        if let data = try? Data(contentsOf: url) {
//            if let loadedProducts = parseProducts(json: data) {
//                completion(loadedProducts)
//                print("Products: \(loadedProducts.count)")
//            } else { print("NO")}
//        }
//    }
//
//    func parseProducts(json: Data) -> [Product]? {
//        var products: [Product] = []
//        let decoder = JSONDecoder()
//        if let jsonCategories = try? decoder.decode([String:Product].self, from: json){
//            var count = products.count
//            for (id, data) in jsonCategories {
//                products.append(data)
//                products[count].id = id
//                count = products.count
//            }
//            return products
//        } else { return nil }
//    }

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
