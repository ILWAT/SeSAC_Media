//
//  ViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let mainView = HomeView()
    
    var trendMovieData: TrendMovieData = TrendMovieData(page: 0, results: [], totalPages: 0, totalResults: 0) {
        didSet{
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    
        callAPI()
        
    }
    
    override func configure() {
        mainView.collectionView.register(TrendMovieCollectionViewCell.self, forCellWithReuseIdentifier: TrendMovieCollectionViewCell.identifier)
    }

    override func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(tappedLeftBarButtonItem(_ :)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(tappedRightBarButtonItem(_ :)))
        self.navigationItem.backButtonTitle = ""
    }
    
    func callAPI(){
        TMDBAPIManager.shared.callTrendMovieRequest(endPoint: .trendWeek, saveData: { result in
            self.trendMovieData = result
        })
        
    }
    
    @objc func tappedLeftBarButtonItem(_ sender: UIBarButtonItem){
        print("tapped left")
    }
    
    @objc func tappedRightBarButtonItem(_ sender: UIBarButtonItem){
        print("tapped rigtht")
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendMovieData.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else{ return UICollectionViewCell() }
        
        cell.showData(data: trendMovieData.results[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = storyboard?.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        
        nextVC.setData(data: trendMovieData.results[indexPath.row])
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
}
