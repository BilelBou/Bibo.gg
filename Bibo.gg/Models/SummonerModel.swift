//
//  SummonerModel.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 22/01/2021.
//

import Foundation
import LeagueAPI

struct SummonerGamesStat {
    var role: String
    var date: Date
    var championUrl: String
    var gameType: QueueMode.QueueModes
    var win: Bool
    var kills: Int
    var death: Int
    var assists: Int
}
