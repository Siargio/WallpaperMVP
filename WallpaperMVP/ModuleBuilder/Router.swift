//
//  Router.swift
//  WallpaperMVP
//
//  Created by Sergio on 27.02.23.
//

import UIKit

// MARK: - Protocols

//первым создаем роутер
protocol RouterMain: AnyObject {
    var navigationController: UINavigationController? { get set }  // для каждого роутера у нас свой навигейшен контроллер
    var assemblyBuilder: AssemblyBuilderProtocol? { get set } //сборщик у нас
}

// протокол для роутера
protocol RouterProtocol: RouterMain {
    func initialViewController() // начальный
    func showDetail(model: Photo?) // детейл
    //func popTopRoot()
}

// MARK: - Class

final class Router: RouterProtocol { // класс который имплементит или конформит(соответствует), он нужен чтобы мы могли протестировать. Он занимается Только навигацией

    // MARK: - Properties
    
    var navigationController: UINavigationController? // контроллер с которого будет стартовать
    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initialization

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
        navigationController?.viewControllers = [mainViewController]
    }

    func showDetail(model: Photo?) {
        guard let detailViewController = assemblyBuilder?.createDetailModule(router: self, model: model) else { return }
        navigationController?.present(detailViewController, animated: true, completion: nil)
    }
}
