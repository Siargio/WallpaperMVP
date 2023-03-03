//
//  DetailInfoViewController.swift
//  WallpaperMVP
//
//  Created by Sergio on 1.03.23.
//

import UIKit
import Kingfisher

protocol DetailInfoViewProtocol: AnyObject {
    func displayDetailInfo(viewModel: DetailInfoViewModel)
}

class DetailInfoViewController: UIViewController {

    // MARK: - Properties

    var presenter: DetailInfoPresenterProtocol?

    // MARK: - UIElements
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private let photographerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "hjguoygoyg"
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, photographerLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
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
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupHierarchy()
        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.presentDetailInfo()
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
            imageView.bottomAnchor.constraint(equalTo: futterStackView.topAnchor, constant: -5),

            shareButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.widthAnchor.constraint(equalToConstant: 70),

            futterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            futterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            futterStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            futterStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }

    private func setPhoto(with url: URL) {
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.futterStackView.isHidden = false
            case .failure:
                print("fafim")
                //self.displayError()
            }
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailInfoViewController: DetailInfoViewProtocol {
    func displayDetailInfo(viewModel: DetailInfoViewModel) {
        descriptionLabel.text = viewModel.imageName
        photographerLabel.text = viewModel.photographer
        setPhoto(with: viewModel.url)
    }

}
