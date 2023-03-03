//
//  DetailInfoViewController.swift
//  WallpaperMVP
//
//  Created by Sergio on 1.03.23.
//

import UIKit

protocol DetailInfoViewProtocol: AnyObject {

}

class DetailInfoViewController: UIViewController {

    // MARK: - Properties

    var presenter: DetailInfoPresenterProtocol?

    // MARK: - UIElements
    
    let imageView: UIImageView = {
        let image = UIImage(named: "image")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        label.text = "aflkalfkm aflkklf af akf af alkk flkamf mafwl mlakm la falfm almkmlm mmmafafaf af ff aafaf"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let photographerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "afafnawf jaf ajf faff"
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, photographerLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [saveButton, shareButton])
        stackView.distribution = .fillProportionally
        stackView.spacing = 150
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var futterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoStackView, buttonStackView])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5        //stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(imageView)
        view.addSubview(futterStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: futterStackView.topAnchor, constant: -10),

            shareButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.widthAnchor.constraint(equalToConstant: 70),

            futterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            futterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            futterStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            futterStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.17)
        ])
    }
}

// MARK: - DetailViewProtocol
extension DetailInfoViewController: DetailInfoViewProtocol {
}
