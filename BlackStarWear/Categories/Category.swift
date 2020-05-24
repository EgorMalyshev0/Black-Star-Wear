import Foundation

struct Category: Codable {
    let name: String
    let subcategories: [Subcategory]
    let image: String
}

struct Subcategory: Codable {
//    let id: String
    let name: String
    let iconImage: String
}
