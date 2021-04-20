//
//  HomeViewController.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 21/01/2021.
//

import UIKit
import Kingfisher
import MHLoadingButton

class HomeViewController: Controller {

    private let leagueAPI = LeagueCall()
    var summonersGamesTab: [SummonerGamesStat] = []
    
    private lazy var summonerSearchField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 5
        $0.placeholder = "Summoner name"
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.textColor = Color.black
    }
    
    private lazy var searchButton: LoadingButton = LoadingButton(text: "Search", buttonStyle: .fill)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
    }
    
    private lazy var presentationImage: UIImageView = UIImageView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        let url = URL(string: "https://icon-library.com/images/league-of-legends-logo-icon/league-of-legends-logo-icon-24.jpg")!
        let ressource1 = ImageResource(downloadURL: url)
        $0.kf.setImage(with: ressource1)
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleAndLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar(NavTitleStyle.title("Home"), titleColor: Color.black, rightButton: .challenge, rightColor: Color.yellow)
    }
    
    private func configureStyleAndLayout() {
        view.backgroundColor = Color.black
        view.addSubview(summonerSearchField)
        view.addSubview(searchButton)
        view.addSubview(presentationImage)
        
        NSLayoutConstraint.activate([
            presentationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._20),
            presentationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            summonerSearchField.topAnchor.constraint(equalTo: presentationImage.bottomAnchor, constant: Margin._40),
            summonerSearchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            summonerSearchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            
            searchButton.topAnchor.constraint(equalTo: summonerSearchField.bottomAnchor, constant: Margin._20),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: Margin._20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._16),
            ])
    }
    
    @IBAction func searchAction(_ sender: Any) {
        searchButton.indicator = UIActivityIndicatorView()
        leagueAPI.getGameHistory(summonerName: summonerSearchField.text!) { summonerGamesStat in
            self.summonersGamesTab = summonerGamesStat
            DispatchQueue.main.async {
                let gameHistoryView = GameHistoryViewController()
                let gameHistoryWithNavBar = UINavigationController(rootViewController: gameHistoryView)
                gameHistoryWithNavBar.modalPresentationStyle = .fullScreen
                gameHistoryView.summonersGames = self.summonersGamesTab
                gameHistoryView.summonerName = self.summonerSearchField.text!
                self.present(gameHistoryWithNavBar, animated: true, completion: nil)
            }

        }
    }
}
