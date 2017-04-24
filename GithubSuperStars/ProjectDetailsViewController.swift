//
//  ProjectDetailsViewController.swift
//  GithubSuperStars
//
//  Created by Hardik on 22/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    ///MARK: IBOutlet properties
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startsCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var readMeTextView: UITextView!
    
    @IBOutlet weak var readMeWebView: UIWebView!
    
    ///MARK: Store properties
    var project: Project?
    
    ///MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let project = project {
            let viewModel = ProjectDetailsViewModel(project: project)
            configureViewData(withViewModel: viewModel)
        }
        
        loadAvatarImage()
        downloadAndDisplayReadMe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        decorateView()
    }
    
    /// apply required decoration on View components
    private func decorateView() {
        startsCountLabel.addBoarderAndRoundCorner(forCorner: [UIRectCorner.topLeft, UIRectCorner.bottomLeft])
        forkCountLabel.addBoarderAndRoundCorner(forCorner: [UIRectCorner.topRight, UIRectCorner.bottomRight])
        
        avatar.circular()
    }
    
    /// display repo and user details
    private func configureViewData(withViewModel viewModel: ProjectDetailsViewModel) {
        title = viewModel.repoName

        descriptionLabel.text = viewModel.description
        username.text = viewModel.username
        
        startsCountLabel.text = viewModel.starsCount
        forkCountLabel.text = viewModel.forksCount
    }

    
    // download avtar image and load on imageview
    private func loadAvatarImage() {
        
        DispatchQueue.global().async { [weak self] in

            guard let weakSelf = self else { return }
            
            if let project = weakSelf.project,
                let user = project.user,
                let avatarURL = URL(string: user.avtarURLString) {
                do {
                    let imageData = try Data(contentsOf: avatarURL)
                    
                    DispatchQueue.main.async {
                        weakSelf.avatar.image = UIImage(data: imageData)
                    }
                } catch {
                    //Error
                }
            }
        }
    }
    
    /// download readme data and display
    private func downloadAndDisplayReadMe() {
        if let project = project {
            DispatchQueue.global().async { [weak self] in
                guard let weakSelf = self else { return }

                NetworkManager.default.getReadMe(forProject: project, completionHandler: { result in
                    switch (result) {
                    case .success(let readMeArray):
                        
                        DispatchQueue.main.async {
                            if let readMeObject = readMeArray.first as? ReadMe {
                                weakSelf.loadWebView(withURLString: readMeObject.htmlUrl)
                            }
                        }
                        
                    case .failure(let error):
                        break
                    }
                })
            }
        }
    }
    
    private func loadWebView(withURLString urlString: String) {
        if let readMeURL = URL(string: urlString) {
            let urlRequest = URLRequest(url: readMeURL)
            readMeWebView.loadRequest(urlRequest)
        }
    }
    
//    private func loadReadMeText(withURLString urlString: String) {
//        
//        if let readMeURL = URL(string: urlString) {
//            
//            do {
//                let readMeData = try Data(contentsOf: readMeURL)
//                let readMeDataString = String(data: readMeData, encoding: .utf8)
//                readMeTextView.text = readMeDataString
// 
//            } catch {
//                //Error
//            }
//
//           
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
