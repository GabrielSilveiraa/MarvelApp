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
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersViewModel()
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableViewCell") as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        let character = viewModel.characters[indexPath.row]
        cell.configure(withCharacter: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CharacterTableViewCell.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count-4 {
            activityIndicator.startAnimating()
            viewModel.loadMoreCharacters()
        }
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController else {
            return
        }
        let character = viewModel.characters[indexPath.row]
        destination.configure(withViewModel: CharacterDetailsViewModel(withCharacter: character))
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

