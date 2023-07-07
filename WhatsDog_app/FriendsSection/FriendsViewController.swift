//
//  FriendsViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private var friends         = Friends
    private var filteredFriends  = [Friend]()

    private var tableView: UITableView = .init(frame: .zero, style: .grouped)
    private var closeButton            = UIBarButtonItem()
    private var searchController       = UISearchController(searchResultsController: nil)
    
    private var isFiltering: Bool {
        return !searchBarIsEmpty && searchController.isActive
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
    }
    
    deinit {
        print("Friends ViewController is dead")
    }
}

// MARK: - Setup Views
extension FriendsViewController {
    
    private func setupViews() {
        setupTableView()
        configureBarItems()
    }
    
    private func configureBarItems() {
        navigationItem.searchController = searchController
        configureSearchController()

        navigationItem.title                                    = "Frinds results"
        navigationItem.largeTitleDisplayMode                    = .always
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor           = .systemRed
        navigationController?.navigationBar.shadowImage         = UIImage()
        navigationItem.rightBarButtonItem                       = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                                                  style: .done,
                                                                                  target: self,
                                                                                  action: #selector(rightBarButtonAction(sender:))
                                                                )
        navigationController?.navigationItem.backButtonDisplayMode      = .minimal
        navigationController?.navigationItem.backButtonTitle            = ""
        navigationController?.navigationItem.backButtonDisplayMode      = .default
        navigationController?.navigationItem.backBarButtonItem?.title   = "Back"
    }
    
    
    private func configureSearchController() {
        searchController.searchBar.placeholder = "Enter your friend's name"
        
        // Здесь мы обозначаем, что получателем изменения поисковой информации должен быть наш класс
        searchController.searchResultsUpdater = self
        
        // По умолчанию нельзя взаимодействовать с контенто во время поиска, это значение мы ставим в значение false, чтобы мы могли это делать
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Позволяет отпустить строку поиска при переходе на другой экран
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableViewConstraints()
        
        tableView.separatorInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        tableView.rowHeight = 70
        
        tableView.register(FriendsCell.self, forCellReuseIdentifier: "FrindsCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func tableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Actions
extension FriendsViewController {
    
    @objc
    private func rightBarButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension FriendsViewController {
    
    private func isNowFiltering() -> [Friend] {
        switch isFiltering {
        case true:
            return filteredFriends
        case false:
            return friends
        }
    }
    
}

// MARK: - TableView Delegate
extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileDetailViewController()
        
        let rightFrinds = isNowFiltering()
        
        vc.setupInfoFor(name: rightFrinds[indexPath.row].name,
                        avatar: rightFrinds[indexPath.row].avatar,
                        resultDescripton: rightFrinds[indexPath.row].resultBreed,
                        resultImage: rightFrinds[indexPath.row].resultImage
                        )
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - TableView DataSource
extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        }
          return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FrindsCell", for: indexPath) as? FriendsCell else { fatalError() }
        
        var friend: Friend
        
        if isFiltering {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = friends[indexPath.row]
        }
        
        cell.configureView(friend: friend)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension FriendsViewController: UISearchResultsUpdating {
    
    // Каждый раз когда пользователь будет контактировать с searchBar, он будет вызывать данный метод, который в свою очередь будет фильровать наш контент методом filterContentForSearchText
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
    
        filteredFriends = friends.filter({ (friend: Friend) -> Bool in
            return friend.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

