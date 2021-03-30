//
//  HomeViewController.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 21/01/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var summonerSearch: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    private let leagueAPI = LeagueCall()
    var summonersGamesTab: [SummonerGames] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchImageView = UIImageView()
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        summonerSearch.rightView = searchImageView
        summonerSearch.rightViewMode = .always
        
        searchButton.layer.cornerRadius = 10
    }
    @IBAction func searchAction(_ sender: Any) {
        leagueAPI.getSummonerID(summonerName: summonerSearch.text!) { summonersGames, profilIcon, summonerStats in
            self.summonersGamesTab = summonersGames
            DispatchQueue.main.async {
                let gameHistoryView = self.storyboard?.instantiateViewController(identifier: "GameHistoryViewController") as! GameHistoryViewController
                gameHistoryView.summonersGames = self.summonersGamesTab
                gameHistoryView.summonerName = self.summonerSearch.text!
                gameHistoryView.modalPresentationStyle = .fullScreen
                gameHistoryView.profilIconUrl = profilIcon
                gameHistoryView.summonerStats = summonerStats
                self.show(gameHistoryView, sender: self)
            }
        }
    }
}
