//
//  AssemblyModuleBuilder.swift
//  WallpaperMVP
//
//  Created by Sergio on 27.02.23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, model: Photo?) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // инициализация первого контроллера ViewController
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    // инициализация второго контроллера ViewController
    func createDetailModule(router: RouterProtocol, model: Photo?) -> UIViewController {
        let view = DetailInfoViewController()
        let presenter = DetailInfoPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
}
