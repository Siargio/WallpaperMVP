//
//  MainPresenter.swift
//  WallpaperMVP
//
//  Created by Sergio on 28.02.23.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {

}

final class MainPresenter {
    // MARK: - Properties
    weak var view: MainViewProtocol?
    var router: RouterProtocol?

    // MARK: - Initialization
    init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
