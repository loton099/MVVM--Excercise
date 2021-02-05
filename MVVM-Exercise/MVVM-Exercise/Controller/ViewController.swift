//
//  ViewController.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import UIKit

class ViewController: BaseViewController {
    
    //MARK: Properties
    lazy var viewModel = UserViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDetails()
    }
    
    fileprivate func setupUI() {
        self.tableView.register(NibFiles.UserListingTableViewCell.instance, forCellReuseIdentifier: UserListingTableViewCell.identifier)
    }
    
    fileprivate func fetchDetails() {
        viewModel.fetchUsersDetails()
    }
    
    //MARK:- BaseViewController  methods
    override func viewModelObject() -> BaseViewModel? {
        return viewModel
    }
    
    override func setUpViewModelCallbacks() {
        super.setUpViewModelCallbacks()
        
        let viewModel = viewModelObject() as! UserViewModel
        
        viewModel.requestSucceeded = {  [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
        
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     if let cell = tableView.dequeueReusableCell(withIdentifier: UserListingTableViewCell.identifier, for: indexPath) as? UserListingTableViewCell {
        cell.configureData(self.viewModel.itemAt(indexPath.row))
        return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
