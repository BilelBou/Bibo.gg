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
    //@IBOutlet weak var gameTypeLabel: UILabel!
    //@IBOutlet weak var date: UILabel!
    //@IBOutlet weak var role: UILabel!
    //@IBOutlet weak var statsLabel: UILabel!
    //@IBOutlet weak var imageChamp: UIImageView!
    
    private lazy var containerView: UIView = UIView()..{
        $0.backgroundColor = Color.darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.frame.size = CGSize(width: 100, height: 142)
        $0.layer.cornerRadius = 10
    }
    
    private lazy var gameTypeLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var date: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = Color.black
    }
    
    private lazy var role: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var statsLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var imageChamp:UIImageView = UIImageView()..{
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    static let identifier = "MatchHistoryTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStyleAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStyleAndLayout() {
        contentView.backgroundColor = Color.black
        contentView.addSubview(containerView)
        //containerView.addSubview(gameTypeLabel)
        containerView.addSubview(date)
        containerView.addSubview(role)
        containerView.addSubview(statsLabel)
        containerView.addSubview(imageChamp)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin._16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin._16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margin._16),
            
            date.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._12),
            date.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._12),
            
            imageChamp.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._12),
            imageChamp.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._12),
            
            statsLabel.topAnchor.constraint(equalTo: imageChamp.bottomAnchor, constant: Margin._12),
            statsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._12),
            
            role.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._12),
            role.leadingAnchor.constraint(equalTo: imageChamp.trailingAnchor, constant: Margin._12)
        ])

        
    }
    
    public func configureGameType(with GameType: QueueMode.QueueModes) {
        self.gameTypeLabel.text = "\(GameType)"
    }
    
    public func configureDate(with date: Date) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YY"
        let stringDate = df.string(from: date)
        self.date.attributedText = stringDate.typography(.caption, color: Color.black)
    }
    
    public func configureRole(with role: String) {
        self.role.attributedText = role.typography(.title3, color: Color.black)
    }
    
    public func configureImage(with imageUrl: String) {
        let url = URL(string: imageUrl)!
        let ressource = ImageResource(downloadURL: url)
        imageChamp.kf.setImage(with: ressource)
    }
    
    public func configureWin(with win:Bool) {
        if win == true {
            self.containerView.backgroundColor = Color.green
        } else {
            self.containerView.backgroundColor = Color.red
        }
    }
    
    public func configureStats(with stats:String) {
        statsLabel.attributedText = stats.typography(.title1, color: Color.black)
    }
}
