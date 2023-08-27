//
//  ReusableOnboardingViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/27.
//

import UIKit

class ReusableOnboardingViewController: UIViewController {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lastCheckButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.isHidden = true
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .tintColor
        config.baseForegroundColor = .white
        button.configuration = config
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        lastCheckButton.addTarget(self, action: #selector(tappedLastCheckButton), for: .touchUpInside)
        setUI()
    }
    
    func setUI(){
        self.view.addSubviews(views: [imageView, descriptionLabel, lastCheckButton])
        self.view.backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints(){
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(imageView.snp.width)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.centerY.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.leading.trailing.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
        lastCheckButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(imageView)
            make.height.equalTo(50)
        }
        
    }
    
    func setImage(systemName: String){
        imageView.image = UIImage(systemName: systemName)
        descriptionLabel.text = systemName
    }
    
    func setLastButton(visible: Bool){
        lastCheckButton.isHidden = visible
    }
    
    @objc func tappedLastCheckButton(_ sender: UIButton){
        UserDefaults.standard.set(true, forKey: "isLaunched")
        print(UserDefaults.standard.bool(forKey: "isLaunched"))
    }

}
