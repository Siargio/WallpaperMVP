//
//  ViewController.swift
//  WallpaperMVP
//
//  Created by Sergio on 27.02.23.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func displayPhotos(model: [Photo])
    func updateNextPage(page: Int)
    func displayError()
}

final class MainViewController: UIViewController {

    // MARK: - Properties

    var presenter: MainPresenterProtocol?

    private var nextPage: Int = 1
    private var isSearching: Bool = false

    private var photos: [Photo]? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - UIElements

    lazy var searchBar: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.showsSearchResultsController = true
        searchController.automaticallyShowsScopeBar = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Name Or Symbole"
        return searchController
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupHierarchy()
        setupLayout()
        setupNavigationController()
        startSettings()
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(collectionView)
    }

    private func setupNavigationController() {
        let searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }

    private func startSettings() {
        presenter?.fetchData(page: nextPage)
    }
}

// MARK: - Extension UICollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = photos?.count else { return 20 }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayoutCell.identifier, for: indexPath) as? FlowLayoutCell else {
            return UICollectionViewCell()
        }

        if let photos = photos {
            print("afaaf")
            cell.configureCell(url: photos[indexPath.row].mediumSrcUrl)
        }
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2 - 15, height: view.frame.width / 2 - 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photos = photos else { return }
        presenter?.tapOnThePhoto(model: photos[indexPath.row])

    }
}
// MARK: - UISearchResultsUpdating & UISearchControllerDelegate

extension MainViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.isEmpty {
            print("fafa")
        }
    }
}

// MARK: - UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {
    
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func displayPhotos(model: [Photo]) {
        if (photos?.append(contentsOf: model)) == nil {
            photos = model
        }
    }

    func updateNextPage(page: Int) {
        nextPage = page
    }

    func displayError() {
//        AlertService.shared.showAlert(viewController: self, type: .error) { [weak self] in
//            guard let self = self else { return }
//            self.presenter?.fetchData(page: self.nextPage)
//        }
    }
}
