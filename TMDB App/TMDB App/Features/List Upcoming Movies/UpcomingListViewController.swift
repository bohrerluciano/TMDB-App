//
//  UpcomingListViewController.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 19/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Class
final class UpcomingListViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Private variables
    private var disposeBag = DisposeBag()
    
    // MARK: Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        TMDBApi()
            .getUpcoming()
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "UpcomingTableViewCell",
                                         cellType: UpcomingTableViewCell.self)) { (row, element, cell) in
                                            cell.configure(movie: element)
            }
            .disposed(by: self.disposeBag)
        
        self.setupView()
        self.setupRx()
    }
    
    // MARK: Private methods
    private func setupView() {
        
        self.searchTextField.layer.cornerRadius = 16
        
        self.tableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: Bundle.main),
                                forCellReuseIdentifier: "UpcomingTableViewCell")
        self.tableView.estimatedRowHeight = 140
        self.tableView.separatorStyle = .none
    }
    
    private func setupRx() {
        let items = Observable<[String]>.of(["item1","item2","item3","item4","item1","item2","item3","item4","item1","item2","item3","item4"])
        
    }
}

