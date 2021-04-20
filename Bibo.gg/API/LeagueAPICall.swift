//
//  LeagueAPICall.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 21/01/2021.
//

import Foundation
import LeagueAPI

class LeagueCall {
    let league = LeagueAPI(APIToken:"APIKEY")

    func getGameHistory(summonerName: String, completion:@escaping ([SummonerGamesStat]) -> Void) {
        var summonerGamesStats: [SummonerGamesStat] =  []
        let group = DispatchGroup()

        league.lolAPI.getSummoner(byName: summonerName, on: .EUW) { (summonerData, errorMsg) in
            if let summonerData = summonerData {
                self.league.lolAPI.getMatchList(by: summonerData.accountId, on: .EUW, beginIndex: 0, endIndex: 20) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        for match in matchList.matches {
                            group.enter()
                            self.league.lolAPI.getMatch(by: match.gameId, on: .EUW) { (game, errorMsg) in
                                if let game = game {
                                    for participant in game.participants {
                                        if participant.player.accountId == summonerData.accountId {
                                            for participantInfo in game.participantsInfo {
                                                if participantInfo.participantId == participant.participantId {
                                                    for team in game.teamsInfo {
                                                        if team.teamId == participantInfo.teamId {
                                                            self.league.lolAPI.getChampionDetails(by: participantInfo.championId) { (ChampionDetails, errorMsg) in
                                                                if let championDetails = ChampionDetails {
                                                                    summonerGamesStats.append(SummonerGamesStat.init(role: match.role, date: match.gameDate.date, championUrl: (championDetails.images?.square.url)!, gameType: match.queue.mode, win: team.win, kills: participantInfo.stats.kills, death: participantInfo.stats.deaths, assists: participantInfo.stats.assists))
                                                                    group.leave()
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    group.notify(queue: DispatchQueue.main) {
                        completion(summonerGamesStats)
                    }
                }
            }
        }
    }
}
