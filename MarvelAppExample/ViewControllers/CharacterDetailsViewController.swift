//
//  CharacterDetailsViewController.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 26/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.sd_setImage(with: viewModel.thumbnailUrl!, completed:nil)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text =
                viewModel.character.description != "" ? viewModel.character.description : "No description available"
            descriptionLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var comicsButton: MarvelButton! {
        didSet {
            comicsButton.tag = MarvelCollectionType.Comics.rawValue
            comicsButton.addTarget(self, action: #selector(goToCollection), for: .touchDown)
        }
    }
    
    @IBOutlet weak var seriesButton: MarvelButton! {
        didSet {
            seriesButton.tag = MarvelCollectionType.Series.rawValue
            seriesButton.addTarget(self, action: #selector(goToCollection), for: .touchDown)
        }
    }
    
    @IBOutlet weak var storiesButton: MarvelButton! {
        didSet {
            storiesButton.tag = MarvelCollectionType.Stories.rawValue
            storiesButton.addTarget(self, action: #selector(goToCollection), for: .touchDown)
        }
    }
    
    @IBOutlet weak var eventsButton: MarvelButton! {
        didSet {
            eventsButton.tag = MarvelCollectionType.Events.rawValue
            eventsButton.addTarget(self, action: #selector(goToCollection), for: .touchDown)
        }
    }
    
    private var viewModel:CharacterDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    func configure(withViewModel viewModel:CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = viewModel.character.name
    }
    
    @objc func goToCollection(_ sender:UIButton) {
        
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "CollectionsViewController") as? CollectionsViewController,
              let collection = MarvelCollectionType(rawValue: sender.tag) else {
            return
        }
            
        let collectionViewModel = MarvelCollectionViewModel(withCharacter: viewModel.character, andCollection: collection)
        
        destination.configure(withViewModel: collectionViewModel)
        
        navigationController?.pushViewController(destination, animated: true)
    }
}
