//
//  TVSeriesViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/19.
//

import UIKit

class TVSeriesViewController: UIViewController {
    
    var tvSeriseData: TVSeriesData? = nil
    var tvEpisodeData: [TVEpisodeData] = []

    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        registerNib()
        getData()
        
    }
    
    func setCollectionView(){
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        setCollectionViewFlowLayout()
    }
    
    func registerNib(){
        let nib1 = UINib(nibName: TVSeasonCollectionReusableView.identifier, bundle: .main)
        let nib2 = UINib(nibName: TVEpisodeCollectionViewCell.identifier, bundle: .main)
        
        tvCollectionView.register(nib1, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeasonCollectionReusableView.identifier)
        tvCollectionView.register(nib2, forCellWithReuseIdentifier: TVEpisodeCollectionViewCell.identifier)
    }
    
    func setCollectionViewFlowLayout(){
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(20)
        let phoeSize = self.view.window?.windowScene?.windows.first?.bounds.width ?? UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: phoeSize, height: 150)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
        layout.headerReferenceSize = CGSize(width: phoeSize, height: 100)
        
        tvCollectionView.collectionViewLayout = layout
    }
    
    func getData(){
        //D.P.: 110534
        let dpSeriesID = 110534
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            TMDBAPIManager.shared.callTVSeriesRequest(endPoint: .seriesDetail, series_id: dpSeriesID) { response in
                self.tvSeriseData = response
                for i in 1...response.numberOfSeasons{
                    group.enter()
                    TMDBAPIManager.shared.callTVEpisodeRequest(endPoint: .seriesDetail, series_id: dpSeriesID, season: i, saveData: { response in
                        self.tvEpisodeData.append(response)
                        group.leave()
                    })
                }
                group.leave()
            }
        }
        
        
        group.notify(queue: .main){
            self.tvCollectionView.reloadData()
        }
        
    }

}


extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let tvSeriseData else { return 0 }
        return tvSeriseData.seasons.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        guard !tvEpisodeData.isEmpty else { return 0 }
        return tvEpisodeData[section].episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVEpisodeCollectionViewCell.identifier, for: indexPath) as? TVEpisodeCollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.setUI(tvEpisode: self.tvEpisodeData[indexPath.section].episodes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TVSeasonCollectionReusableView.identifier, for: indexPath) as? TVSeasonCollectionReusableView else { return UICollectionReusableView() }
            
            guard let tvSeriseData else {return cell}
            
            cell.setUI(data: tvSeriseData, season: indexPath.section)
            
            return cell
        } else{
            return UICollectionReusableView()
        }
        
    }

}
