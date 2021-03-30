//
//  GameHistoryViewController.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 22/01/2021.
//

import UIKit
import Kingfisher

class GameHistoryViewController: UIViewController {
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var matchHistoryTab: UITableView!
    @IBOutlet weak var profilIconImg: UIImageView!
    
    var summonerName: String = " "
    var summonersGames: [SummonerGames] = []
    var summonerStats: [SummonerStats] = []

    var championListUrl: [String] = []
    var profilIconUrl: String = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        self.summonerNameLabel.text = summonerName
        
        matchHistoryTab.register(MatchHistoryTableViewCell.nib(), forCellReuseIdentifier: MatchHistoryTableViewCell.identifier)
        matchHistoryTab.delegate = self
        matchHistoryTab.dataSource = self
        
        let url = URL(string: profilIconUrl)!
        let ressource = ImageResource(downloadURL: url)
        profilIconImg.kf.setImage(with: ressource)
        
    }
}

extension GameHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        summonersGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchHistoryTableViewCell.identifier, for: indexPath) as! MatchHistoryTableViewCell
        cell.configureDate(with: summonersGames[indexPath.row].date)
        cell.configureRole(with: summonersGames[indexPath.row].role)
        cell.configureGameType(with: summonersGames[indexPath.row].GameType)
        cell.configureImage(with: summonersGames[indexPath.row].ChampionUrl)
        cell.configureWin(with: summonerStats[indexPath.row].win)
        cell.configureStats(with: summonerStats[indexPath.row].stats)
        return cell
    }
}
