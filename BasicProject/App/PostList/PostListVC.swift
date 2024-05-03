//
//  ViewController.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import UIKit
import Combine

class PostListVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
       
    var viewModel = PostListViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - LifeCycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        
        viewModel.getPosts()
    }

}

extension PostListVC {
    
    // MARK: Helper Functions
    
    func setupUI() {
        navigationItem.title = "Posts"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        tableView.addLoadMore { [weak self] in
            self?.viewModel.getPosts()
        }
    }
    
    func setupBindings() {
        viewModel.$allPosts.sink { [weak self] posts in
            onMainThread { [weak self] in
                self?.tableView.reloadData()
            }
        }.store(in: &cancellable)
        
        viewModel.$stopLoadMore.sink { [weak self] stop in
            onMainThread { [weak self] in
                if stop {
                    self?.tableView.stopLoadMore()
                }
            }
        }.store(in: &cancellable)
        
        viewModel.$disableLoadMore.sink { [weak self] stop in
            onMainThread { [weak self] in
                if stop {
                    self?.tableView.setLoadMoreEnable(false)
                }
            }
        }.store(in: &cancellable)
    }
}

extension PostListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.allPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.setupData(viewModel.allPosts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.allPosts[indexPath.row]
        
        let vc = PostDetailsVC()
        vc.delegate = self
        vc.post = selectedPost
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostListVC: PostDetailDelegate {
    func funcForSendingData() {
        //
    }
}
