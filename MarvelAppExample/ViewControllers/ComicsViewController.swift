//
//  ComicsViewController.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class ComicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: ComicTableViewCell.nibName, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: "comicTableViewCell")
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    var viewModel: ComicsViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Comics"
    }
    
    func configure(withViewModel viewModel:ComicsViewModel) {
        self.viewModel = viewModel
    }
}

extension ComicsViewController: ComicsViewModelDelegate {
    
    func didLoadComics() {
        if viewModel.comics.isEmpty {
            tableView.isHidden = true
        }
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

extension ComicsViewController: UITableViewDelegate {
    
}

extension ComicsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "comicTableViewCell") as? ComicTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(withComic: viewModel.comics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comics.count
    }
}
