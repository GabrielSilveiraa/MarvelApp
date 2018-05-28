//
//  CollectionsViewController.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: MarvelGenericTableViewCell.nibName, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: MarvelGenericTableViewCell.identifier)
            tableView.allowsSelection = false
            tableView.backgroundColor = Colors.blackMarvel
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = UIColor.white
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var noDataLabel: UILabel! {
        didSet {
            let collectionName = viewModel.collectionType.toString.lowercased()
            noDataLabel.text = "There's no \(collectionName)"
            noDataLabel.textColor = UIColor.white
            noDataLabel.isHidden = true
        }
    }
    
    var viewModel: MarvelCollectionViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = viewModel.collectionType.toString
    }
    
    func configure(withViewModel viewModel:MarvelCollectionViewModel) {
        self.viewModel = viewModel
    }
}

extension CollectionsViewController: MarvelCollectionViewModelDelegate {
    
    func didLoadCollection() {
        if viewModel.collection.isEmpty {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        }
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

extension CollectionsViewController: UITableViewDelegate {
    
}

extension CollectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarvelGenericTableViewCell.identifier) as? MarvelGenericTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(withMarvelCollection: viewModel.collection[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.collection.count
    }
}
