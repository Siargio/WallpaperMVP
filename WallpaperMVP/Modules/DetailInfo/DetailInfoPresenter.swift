//
//  DetailInfoPresenter.swift
//  WallpaperMVP
//
//  Created by Sergio on 1.03.23.
//

import UIKit

protocol DetailInfoPresenterProtocol: AnyObject {
}

final class DetailInfoPresenter: NSObject {
    // MARK: - Properties
    weak var view: DetailInfoViewProtocol?

    private let router: RouterProtocol?
    private let model: FlowLayoutCell

    // MARK: - Initialization
    init(view: DetailInfoViewProtocol, router: RouterProtocol, model: FlowLayoutCell) {
        self.view = view
        self.router = router
        self.model = model
    }
}

extension DetailInfoPresenter: DetailInfoPresenterProtocol {

}
