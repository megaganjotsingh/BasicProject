//
//  HomeController .swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation

struct Post: Decodable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

class PostController {
    func getPosts(with page: Int) async throws -> [Post] {
        let postsUrlString = BASE_URL + "posts"
        
        let request: Request<[Post]> = .init(path: postsUrlString, method: .GET, query: [("_page", "\(page)"), ("_limit", "10")])
        let posts = try await NetworkManager().send(request)
        
        return posts.value
    }
}
