//
//  HomeViewModel.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation
import Combine

class PostListViewModel {
    
    @Published var allPosts: [Post] = []
    @Published var stopLoadMore: Bool = false
    @Published var disableLoadMore: Bool = false
    var page = 0
    
    func getPosts() {
        page += 1
        Task {
            do {
                let posts = try await PostController().getPosts(with: page)
                if posts.isEmpty {
                    disableLoadMore = true
                }
                if allPosts.isEmpty {
                    allPosts = posts
                } else {
                    allPosts.append(contentsOf: posts)
                    stopLoadMore = true
                }
                
            } catch let error {
                // handle error
                debugPrint(error.localizedDescription)
            }
        }
    }
}
