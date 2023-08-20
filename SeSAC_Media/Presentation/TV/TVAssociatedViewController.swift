//
//  TVAssociatedViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/20.
//

import UIKit

class TVAssociatedViewController: UIViewController {

    @IBOutlet weak var associatedContentCollectionView: UICollectionView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var similarData = TVSimilarData(page: 0, results: [], totalPages: 0, totalResults: 0)
    var videoData = TVVideoData(id: 0, results: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setData()
    }
    
    func setCollectionView(){
        let nib = UINib(nibName: AssociatedCollectionViewCell.identifier, bundle: .main)
        associatedContentCollectionView.register(nib, forCellWithReuseIdentifier: AssociatedCollectionViewCell.identifier)
        
        associatedContentCollectionView.delegate = self
        associatedContentCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(20)
        let phoeSize = self.view.window?.windowScene?.windows.first?.bounds.width ?? UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: phoeSize, height: 150)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
        
        associatedContentCollectionView.collectionViewLayout = layout
    }
    
    func setData(){
        let dispatchGroup = DispatchGroup()
        
        //D.P.: 110534
        dispatchGroup.enter()
        TMDBAPIManager.shared.callTVSimilarRequest(endPoint: .similar, series_id: 110534) { result in
            self.similarData = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        TMDBAPIManager.shared.callTVVideoRequest(endPoint: .video, series_id: 110534) { result in
            self.videoData = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.associatedContentCollectionView.reloadData()
        }
    }
    
    @IBAction func tappedSegmeted(_ sender: UISegmentedControl) {
        associatedContentCollectionView.reloadData()
    }
}

extension TVAssociatedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedController.selectedSegmentIndex == 0{
            return similarData.results.count
        } else {
            return videoData.results.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssociatedCollectionViewCell.identifier, for: indexPath) as? AssociatedCollectionViewCell else { return UICollectionViewCell() }
        
        if segmentedController.selectedSegmentIndex == 0{
            cell.setUI(segmented: segmentedController.selectedSegmentIndex, similarData: similarData.results[indexPath.row])
        } else {
            cell.setUI(segmented: segmentedController.selectedSegmentIndex, videoData: videoData.results[indexPath.row])
        }
        
        return cell
    }
}


