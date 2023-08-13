//
//  MovieDetailViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/13.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movieData: TrendMovieData? = nil
    
    var castingPeopleData: [PeopleData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setRegister()
        setNavigation()
    }
    
    func setRegister(){
        let nib1 = UINib(nibName: MovieTitleTableViewCell.identifier, bundle: .main)
        let nib2 = UINib(nibName: MovieOverViewTableViewCell.identifier, bundle: .main)
        let nib3 = UINib(nibName: MovieCastingTableViewCell.identifier, bundle: .main)
        
        tableView.register(nib1, forCellReuseIdentifier: MovieTitleTableViewCell.identifier)
        tableView.register(nib2, forCellReuseIdentifier: MovieOverViewTableViewCell.identifier)
        tableView.register(nib3, forCellReuseIdentifier: MovieCastingTableViewCell.identifier)
    }
    
    func setData(data: TrendMovieData?){
        guard let data else {return}
        movieData = data
        
        TMDBAPIManager.shared.callCreditRequest(endPoint: .credit, movieID: data.id, saveData: { result in
            self.castingPeopleData = result
            self.tableView.reloadData()
        })
        
        
    }
    
    func setNavigation(){
        self.title = "출연/제작"
    }
}


extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return castingPeopleData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieData else {return UITableViewCell()}
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleTableViewCell.identifier) as? MovieTitleTableViewCell else { return UITableViewCell()}
            
            cell.setUI(data: movieData)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieOverViewTableViewCell.identifier) as? MovieOverViewTableViewCell else { return UITableViewCell()}
            
            cell.setUI(text: movieData.overview)
            
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastingTableViewCell.identifier) as? MovieCastingTableViewCell else { return UITableViewCell() }
            
            cell.setUI(data: castingPeopleData[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1:
            return 150
        case 2:
            return 100
        default:
            return 100
        }
    }
    
}
