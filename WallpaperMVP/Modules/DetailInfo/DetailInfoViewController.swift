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
    func displayActivityController(items: [String])
    func displayError()
    func displaySuccessMessage()
}

final class DetailInfoViewController: UIViewController {

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
        label.font = .systemFont(ofSize: Metrics.fontOfSizeDescriptionLabel, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = Metrics.minimumScaleFactor
        return label
    }()

    private let photographerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "hjguoygoyg"
        label.font = .systemFont(ofSize: Metrics.fontOfSizePhotographerLabel, weight: .medium)
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        button.layer.cornerRadius = Metrics.cornerRadius
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = Metrics.cornerRadius
        button.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        return button
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, photographerLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Metrics.spacingInfoStackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [saveButton, shareButton])
        stackView.distribution = .fillProportionally
        stackView.spacing = Metrics.spacingButtonStackView
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
            imageView.bottomAnchor.constraint(equalTo: futterStackView.topAnchor, constant: -Metrics.imageViewBottomAnchor),

            shareButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidthAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidthAnchor),

            futterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.futterStackViewLeadingTrailing),
            futterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.futterStackViewLeadingTrailing),
            futterStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.imageViewBottomAnchor),
            futterStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Metrics.heightAnchorMultiply)
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
                self.displayError()
            }
        }
    }

    //MARK: - Actions

    @objc func sharePressed() {
        presenter?.shareDetailInfo()
    }

    @objc func savePressed() {
        presenter?.savePhoto()
    }
}

// MARK: - DetailViewProtocol

extension DetailInfoViewController: DetailInfoViewProtocol {

    func displayDetailInfo(viewModel: DetailInfoViewModel) {
        descriptionLabel.text = viewModel.imageName
        photographerLabel.text = viewModel.photographer
        setPhoto(with: viewModel.url)
    }

    func displayActivityController(items: [String]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }

    func displayError(){
        AlertService.shared.showAlert(viewController: self, type: .error) { [weak self] in
            guard let self = self else { return }
            self.presenter?.presentDetailInfo()
        }
    }

    func displaySuccessMessage() {
        AlertService.shared.showAlert(viewController: self, type: .success)
    }
}

// MARK: - Metrics

extension DetailInfoViewController {

    enum Metrics {
        static let cornerRadius: CGFloat = 10
        static let spacingInfoStackView: CGFloat = 10
        static let spacingButtonStackView: CGFloat = 150
        static let fontOfSizeDescriptionLabel: CGFloat = 18
        static let fontOfSizePhotographerLabel: CGFloat = 19
        static let minimumScaleFactor: CGFloat = 0.7
        static let buttonWidthAnchor: CGFloat = 70
        static let imageViewBottomAnchor: CGFloat = 5
        static let futterStackViewLeadingTrailing: CGFloat = 20
        static let heightAnchorMultiply: CGFloat = 0.2
    }
}
