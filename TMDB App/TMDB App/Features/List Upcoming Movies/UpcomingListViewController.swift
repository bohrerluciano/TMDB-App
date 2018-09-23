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

    // MARK: Views
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: Bundle.main),
                                forCellReuseIdentifier: "UpcomingTableViewCell")
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        return tableView
    }()
    
    // MARK: Private variables
    private var viewModel: UpcomingListViewModel?
    private var loadNextPage = BehaviorSubject<Void>(value:())
    private var disposeBag = DisposeBag()
    
    // MARK: Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UpcomingListViewModel(nextPage: self.loadNextPage)
        self.setupView()
        self.setupRx()
    }
    
    // MARK: Private methods
    private func setupView() {
        self.navigationItem.title = "TMDB"
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    private func setupRx() {
        self.tableView.rx
            .didScroll
            .asObservable()
            .filter({ [weak self] in
                guard let `self` = self else { return false }
                return self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.frame.size.height)
            })
            .throttle(2.0, scheduler: MainScheduler.instance)
            .bind(to: self.loadNextPage)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx
            .modelSelected(Movie.self)
            .asDriver()
            .drive(onNext: { (movie) in
                let vc = MovileDetailsViewController()
                vc.movie = movie
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: self.disposeBag)
        
        self.viewModel?
            .items
            .bind(to: tableView.rx.items(cellIdentifier: "UpcomingTableViewCell",
                                         cellType: UpcomingTableViewCell.self)) { (row, element, cell) in
                                            cell.configure(movie: element)
            }
            .disposed(by: self.disposeBag)
    }
}

