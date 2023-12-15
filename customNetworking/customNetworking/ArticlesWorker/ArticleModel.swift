import Foundation

struct ArticleModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id, title, completed
    }
}
