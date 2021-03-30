//
//  LeagueAPICall.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 21/01/2021.
//

import Foundation
import LeagueAPI

class LeagueCall {
    let league = LeagueAPI(APIToken: "RGAPI-1704e1cc-1916-4bf3-815f-e044b2aaab7c")

    func getSummonerID(summonerName: String, completion:@escaping (([SummonerGames], String, [SummonerStats]) -> Void)) {
        league.lolAPI.getSummoner(byName: summonerName, on: .EUW) { (summonerData, errorMsg) in
            if let summonerData = summonerData {
                let summoner = Summoner.init(summonerId: summonerData.id, accountId: summonerData.accountId, summonerPuuid: summonerData.puuid, iconID: summonerData.iconId)
                    self.getSummonerHistory(accountID: summoner.accountId) { summonersGames, summonerstats in
                        self.league.lolAPI.getProfileIcon(by: summoner.iconID) { (profileIcon, errorMsg) in
                            if let profileIcon = profileIcon {
                                print("Success!")
                                completion(summonersGames, profileIcon.profileIcon.url, summonerstats)
                            }
                            else {
                                print("Request failed cause: \(errorMsg ?? "No error description")")
                            }
                        }
                    }
                print("Success!")
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getSummonerHistory(accountID: AccountId, completion:@escaping (([SummonerGames], [SummonerStats]) -> Void)) {
        var summonerGames: [SummonerGames] =  []
        var summonerStats: [SummonerStats] = []

        let group = DispatchGroup()
        league.lolAPI.getMatchList(by: accountID, on: .EUW, beginIndex: 0, endIndex: 10) { (matchList, errorMsg) in
            if let matchList = matchList {
                for match in matchList.matches {
                    group.enter()
                    self.league.lolAPI.getChampionDetails(by: match.championId) { (champion, errorMsg) in
                        if let champion = champion {
                            summonerGames.append(SummonerGames.init(role: match.lane, date: match.gameDate.date, champion: match.championId, lane: match.lane, GameType: match.queue.mode, ChampionUrl: (champion.images?.square.url)!))
                        }
                        else {
                            print("Request failed cause: \(errorMsg ?? "No error description")")
                        }
                        self.league.lolAPI.getMatch(by: match.gameId, on: .EUW) { (game, errorMsg) in
                            if let game = game {
                                for participants in game.participantsInfo {
                                    if (participants.championId == champion?.championId) {
                                        let teamID = participants.teamId
                                        for team in game.teamsInfo {
                                            if team.teamId == teamID {
                                                summonerStats.append(SummonerStats.init(win: team.win, stats: String(participants.stats.kills) +  "/" + String(participants.stats.deaths) + "/" + String(participants.stats.assists)))
                                                group.leave()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    completion(summonerGames, summonerStats)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}
