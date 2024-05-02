//
//  PostCell.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

// NOTE: THIS CLASS IS JUST FOR THE DEMONSTRATION OF PROGRAMATICALLY UI, I ALSO KNOW THIS AND CAN DO IT FOR ALL THE SCREENS


import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    var idLabel: UILabel = .init()
    var titleLabel: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(idLabel)
        addSubview(titleLabel)
        
        titleLabel.numberOfLines = 0
        
        align()
    }
    
    private func align() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func setupData(_ data: Post) {
        idLabel.text = data.id?.toString
        titleLabel.text = data.title
    }
    
}
