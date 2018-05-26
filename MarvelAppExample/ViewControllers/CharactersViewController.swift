//
//  CharactersViewController.swift
//  MarvelAppExample
//
//  Created by Gabriel Miranda Silveira on 25/05/18.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit


class CharactersViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: CharacterTableViewCell.nibName, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: "characterTableViewCell")
        }
    }
    
    private var viewModel: CharactersViewModel! {
        didSet {
            viewModel.delegate = self
            viewModel.loadCharacters()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = CharactersViewModel()
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Characters"
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func didLoadCharacters() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableViewCell") as? CharacterTableViewCell,
            let character = viewModel.characters?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(withCharacter: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters?.count ?? 0
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController,
            let character = viewModel.characters?[indexPath.row] else {
            return
        }
        destination.configure(withViewModel: CharacterDetailsViewModel(withCharacter: character))
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

