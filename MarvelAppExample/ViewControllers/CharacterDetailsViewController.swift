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
        }
    }
    
    @IBOutlet weak var comicsButton: UIButton! {
        didSet {
            comicsButton.addTarget(self, action: #selector(didPressComicsButton), for: .touchDown)
        }
    }
    
    @IBOutlet weak var seriesButton: UIButton! {
        didSet {
            seriesButton.addTarget(self, action: #selector(didPressSeriesButton), for: .touchDown)
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
    
    @objc func didPressComicsButton() {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "ComicsViewController") as? ComicsViewController else {
            return
        }
        
        let comicsViewModel = ComicsViewModel(withCharacter:viewModel.character)
        destination.configure(withViewModel: comicsViewModel)
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc func didPressSeriesButton() {
        
    }
}
