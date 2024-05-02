//
//  PostDetailsVC.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation
import UIKit
import Combine

class PostDetailsVC: UIViewController {
    // MARK: - Outlets
    
    
    // MARK: - Properties
       
    var viewModel = PostDetailViewModel()
    var post: Post?
    
    private var cancellable = Set<AnyCancellable>()
    private var titleLabel = LabelFactory()
    private var descriptionLabel = LabelFactory()
    
    // MARK: - LifeCycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension PostDetailsVC {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, descriptionLabel)
        align()
        
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        titleLabel.text = post?.title
        descriptionLabel.text = post?.body
    }
    
    func align() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
}
