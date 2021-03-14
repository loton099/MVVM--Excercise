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
        
        viewModel.requestfavouriteSuceeded = { [weak self] favouriteUser in
            guard let self = self else { return }
            if let index =  self.viewModel.updateUserFavouritesByReturningIndex(favouritesInfo:favouriteUser ) {
                if let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UserListingTableViewCell {
                    cell.updateFavourite(status: favouriteUser.isfavourite, atIndex: index)
                }
            }
        }
    }
    
}

//MARK: TableView Delegate / Datasource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserListingTableViewCell.identifier, for: indexPath) as? UserListingTableViewCell {
            cell.delegate = self
            cell.configureData(self.viewModel.itemAt(indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showUserDetails(self.viewModel.itemAt(indexPath.row))
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController: Tappable {
    func favouriteRequestedof(data: Displayable) {
        viewModel.performFavouriteWith(data: data as! User)
    }
}

//MARK: Detail Screen navigation methods
extension ViewController {
    
    func showUserDetails(_ data: Displayable) {
        let detailsVC = Storyboards.Main.instantiateVC(UserDetailsViewController.self)
        let viewModel = UserDetailsViewModel(userDetails: data)
        detailsVC.viewModel = viewModel
        detailsVC.viewModel?.setfavouriteAction = { [weak self]  updatedDetails in
            guard let self = self else { return }
            if let index =  self.viewModel.updateUserFavouritesByReturningIndex(favouritesInfo: updatedDetails as! User ) {
                if let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UserListingTableViewCell {
                    cell.updateFavourite(status: updatedDetails.isfavourite, atIndex: index)
                }
            }
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
