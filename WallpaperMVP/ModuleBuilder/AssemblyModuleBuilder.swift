//
//  AssemblyModuleBuilder.swift
//  WallpaperMVP
//
//  Created by Sergio on 27.02.23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    //func createDetailModule(router: RouterProtocol, model: Photo?) -> UIViewController
}

final class AssemblyModuleBuilder:
    // инициализация первого контроллера ViewController
    AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    // инициализация второго контроллера ViewController
}

