//
//  ProjectListCell.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import UIKit

class ProjectListCell: UITableViewCell {
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: ProjectViewModel? {
        didSet {
            updateValues()
        }
    }
    
    func configure(withViewModel viewModel: ProjectViewModel,
                   atIndexPath indexPath: IndexPath) {
        self.viewModel = viewModel
        backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(rgb: 0xFDECED) 
    }
}

extension ProjectListCell {
    func updateValues() {
        projectName.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        starsCount.text = viewModel?.starsCount
    }
}
