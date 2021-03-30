//
//  MatchHistoryTableViewCell.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 22/01/2021.
//

import UIKit
import LeagueAPI
import Kingfisher

class MatchHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var imageChamp: UIImageView!
    @IBOutlet weak var summonerSpellImg1: UIImageView!
    @IBOutlet weak var summonerSpellImg2: UIImageView!

    static let identifier = "MatchHistoryTableViewCell"

    static func nib() -> UINib {
           return UINib(nibName: "MatchHistoryTableViewCell", bundle: nil)
    }

    public func configureGameType(with GameType: QueueMode.QueueModes) {
        self.gameTypeLabel.text = "\(GameType)"
    }
    
    public func configureDate(with date: Date) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YY"
        let stringDate = df.string(from: date)
        self.date.text = stringDate
    }
    
    public func configureRole(with role: String) {
        self.role.text = role
    }
    
    public func configureImage(with imageUrl: String) {
        let url = URL(string: imageUrl)!
        let ressource = ImageResource(downloadURL: url)
        imageChamp.kf.setImage(with: ressource)
    }
    
    public func configureSummonersSpell(with imageUrl: [String]) {
        let url = URL(string: imageUrl[0])!

        let ressource1 = ImageResource(downloadURL: url)

        summonerSpellImg1.kf.setImage(with: ressource1)

    }
    
    public func configureWin(with win:Bool) {
        if win == true {
            self.backgroundColor = UIColor.green
        } else {
            self.backgroundColor = UIColor.red
        }
    }
    
    public func configureStats(with stats:String) {
        statsLabel.text = stats
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
