//
//  GameHistoryViewController.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 22/01/2021.
//

import UIKit
import Kingfisher

class GameHistoryViewController: Controller {
    var summonerName: String = " "
    var summonersGames: [SummonerGamesStat] = []
    var championListUrl: [String] = []
    var profilIconUrl: String = " "
    static let rowHeight: CGFloat = 158

    
    private lazy var summonerNameLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = self.summonerName.typography(.title3)
        $0.textColor = Color.white
    }
    
    private lazy var matchHistoryTab: UITableView = UITableView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(MatchHistoryTableViewCell.self)
        $0.rowHeight = GameHistoryViewController.rowHeight
        $0.separatorStyle = .none
        $0.backgroundColor = Color.black
    }
    
//    private lazy var profilIconImg: UIImageView = UIImageView()..{
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        let url = URL(string: profilIconUrl)!
//        let ressource = ImageResource(downloadURL: url)
//        $0.kf.setImage(with: ressource)
//        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleAndLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar(NavTitleStyle.title("Games"), titleColor: Color.black, leftButton: .back)
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil;
    }
    
    override func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureStyleAndLayout() {
        view.backgroundColor = Color.black
        view.addSubview(matchHistoryTab)
        view.addSubview(summonerNameLabel)
        //view.addSubview(profilIconImg)
        
        NSLayoutConstraint.activate([
            summonerNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._18),
            summonerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            
//            profilIconImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._18),
//            profilIconImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            
            matchHistoryTab.topAnchor.constraint(equalTo: summonerNameLabel.bottomAnchor, constant: Margin._18),
            matchHistoryTab.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            matchHistoryTab.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            matchHistoryTab.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }

}

extension GameHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        summonersGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MatchHistoryTableViewCell = matchHistoryTab.dequeue(for: indexPath)
        cell.configureDate(with: summonersGames[indexPath.row].date)
        cell.configureRole(with: summonersGames[indexPath.row].role)
        cell.configureGameType(with: summonersGames[indexPath.row].gameType)
        cell.configureImage(with: summonersGames[indexPath.row].championUrl)
        cell.configureWin(with: summonersGames[indexPath.row].win)
        cell.configureStats(kills: summonersGames[indexPath.row].kills, deaths: summonersGames[indexPath.row].death, assists: summonersGames[indexPath.row].assists)

        return cell
    }
}
