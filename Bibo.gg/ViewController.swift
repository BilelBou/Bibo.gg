//
//  ViewController.swift
//  Bibo.gg
//
//  Created by Bilel Bouricha on 21/01/2021.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let league = LeagueAPI(APIToken: "RGAPI-cd8c1272-5aa6-413e-9ddf-303036472abe")

        league.lolAPI.getSummoner(byName: "xBibo12", on: .EUW) {(summoner, errorMsg) in
            if let summoner = summoner {
                print("Success!")
                print(summoner)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        // Do any additional setup after loading the view.
    }


}

