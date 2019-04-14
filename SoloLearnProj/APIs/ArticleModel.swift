
import Foundation

struct ArticleResponseModel : Codable {
    let response: Results
}

struct Results: Codable {
    let results : [ArticleModel]
    let currentPage: Int
    let pages: Int
}

struct ArticleModel : Codable {
    let sectionName: String
    let webPublicationDate: String
    let webTitle: String
    let fields: Fields
}

struct Fields : Codable {
    let thumbnail : String?
    let bodyText: String
}
