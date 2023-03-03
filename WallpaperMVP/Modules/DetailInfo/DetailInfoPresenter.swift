//
//  DetailInfoPresenter.swift
//  WallpaperMVP
//
//  Created by Sergio on 1.03.23.
//

import UIKit

protocol DetailInfoPresenterProtocol: AnyObject {
    func presentDetailInfo()
}

final class DetailInfoPresenter: NSObject {

    // MARK: - Properties

    weak var view: DetailInfoViewProtocol?

    private let router: RouterProtocol?
    private let model: Photo?

    // MARK: - LifeCycle

    init(view: DetailInfoViewProtocol, router: RouterProtocol, model: Photo?) {
        self.view = view
        self.router = router
        self.model = model
    }
}

// MARK: - DetailInfoPresenterProtocol

extension DetailInfoPresenter: DetailInfoPresenterProtocol {

    func presentDetailInfo() {
        guard
            let url = model?.originalSrcUrl,
            let photographer = model?.photographer,
                let imageName = model?.photoTitle
        else {
            return
        }
        let model = DetailInfoViewModel(
            url: url,
            photographer: photographer,
            imageName: imageName)

        view?.displayDetailInfo(viewModel: model)
    }
}
