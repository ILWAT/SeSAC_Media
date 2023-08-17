//
//  ViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    var trendMovieData: TrendMovieData = TrendMovieData(page: 0, results: [], totalPages: 0, totalResults: 0) {
        didSet{
            self.collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        setCollectioView()
        setNaviagation()
        callAPI()
        
    }
    
    func callAPI(){
        TMDBAPIManager.shared.callTrendMovieRequest(endPoint: .trendWeek, saveData: { result in
            self.trendMovieData = result
        })
        
    }
    
    func setCollectioView(){
        let nib = UINib(nibName: TrendMovieCollectionViewCell.identifier, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: TrendMovieCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let itemWitdh = UIScreen.main.bounds.width - (spacing * 2)
    
        layout.itemSize = CGSize(width: itemWitdh, height: itemWitdh) // 1:1 비율 아이템
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }

    func setNaviagation(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(tappedLeftBarButtonItem(_ :)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(tappedRightBarButtonItem(_ :)))
        self.navigationItem.backButtonTitle = ""
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as! TrendMovieCollectionViewCell
        
        cell.setUI(data: trendMovieData.results[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = storyboard?.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        
        nextVC.setData(data: trendMovieData.results[indexPath.row])
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
