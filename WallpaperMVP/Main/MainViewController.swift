//
//  ViewController.swift
//  WallpaperMVP
//
//  Created by Sergio on 27.02.23.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {

    // MARK: - Properties
    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }


}

extension MainViewController: MainViewProtocol {

}
