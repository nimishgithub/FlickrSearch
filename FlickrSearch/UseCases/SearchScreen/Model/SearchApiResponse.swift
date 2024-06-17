import Foundation
// MARK: - Welcome
struct SearchApiResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: Date
    let generator: String
    let items: [SearchResultItem]
}
