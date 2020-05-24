import UIKit

class CategoriesLoader {
    
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
            for (_, data) in jsonCategories {
                categories.append(data)
            }
            return categories
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
