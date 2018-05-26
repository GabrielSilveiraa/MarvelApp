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
    
    private var viewModel:CharacterDetailsViewModel! {
        didSet {
//            viewModel.dele
        }
    }
    
    func configure(withViewModel viewModel:CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
