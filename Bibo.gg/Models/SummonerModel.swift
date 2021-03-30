//
//  SummonerModel.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 22/01/2021.
//

import Foundation
import LeagueAPI

struct Summoner {
    var summonerId: SummonerId
    var accountId: AccountId
    var summonerPuuid: SummonerPuuid
    var iconID: ProfileIconId
}

struct SummonerGames {
    var role: String
    var date: Date
    var champion: ChampionId
    var lane: String
    var GameType: QueueMode.QueueModes
    var ChampionUrl: String
}

struct SummonerStats {
    var win:Bool
    var stats:String
}
