import Foundation
import SwiftSoup

// MARK: - Item
struct SearchResultItem: Codable, Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let media: Media
    let dateTaken: Date
    let description: String
    let published: Date
    let author, authorID, tags: String

    var imageURLString: String {
        media.m
    }

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorID = "author_id"
        case tags
    }

    func extractedImageSize(from description: String) -> (width: Int, height: Int)? {
        guard let doc = try? SwiftSoup.parse(description),
           let imgElement = try? doc.select("img").first(),
           let widthStr = try? imgElement.attr("width"),
           let width = Int(widthStr),
           let heightStr = try? imgElement.attr("height"),
           let height = Int(heightStr) else {
            return nil
        }
        return (width, height)
    }

    struct Media: Codable {
        let m: String
    }
}

