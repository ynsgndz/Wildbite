//
//  SettingsViewController.swift
//  wildbite
//
//  Created by Yunus Gunduz on 5.04.2023.
//

import UIKit
import Alamofire

class ProfileSettViewController: UIViewController {

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userRaceLabel: UILabel!
    
    @IBOutlet weak var userLevelLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var userExpLabel: UILabel!
    
    @IBOutlet weak var userTotalDamageLabel: UILabel!
    
    @IBOutlet weak var userTotalWarLabel: UILabel!
    
    @IBOutlet weak var userTotalWarWinLabel: UILabel!
    
    @IBOutlet weak var userTotalWarLoseLabel: UILabel!
    
    @IBOutlet weak var userTotalWarGoldLabel: UILabel!
    
    @IBOutlet weak var userTotalHuntLabel: UILabel!
    
    @IBOutlet weak var userTotalSuccessHuntLabel: UILabel!
    
    
    @IBOutlet weak var gucLabel: UILabel!
    
    
    @IBOutlet weak var defansLabel: UILabel!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    
    @IBOutlet weak var gucProgressView: UIProgressView!
    
    
    @IBOutlet weak var defansProgressView: UIProgressView!
    
    
    @IBOutlet weak var hizProgressView: UIProgressView!
    
    
    @IBOutlet weak var AdminPanelButtonText: UIButton!
   // let myUserRole = UserDefaults.standard.value(forKey: "userRole")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        gucProgressView.transform = gucProgressView.transform.scaledBy(x: 1, y: 5)
        defansProgressView.transform = defansProgressView.transform.scaledBy(x: 1, y: 5)
        hizProgressView.transform = hizProgressView.transform.scaledBy(x: 1, y: 5)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
      
        
        let myUserID = UserDefaults.standard.value(forKey: "userID")
        let myUserName = UserDefaults.standard.value(forKey: "userName")
        let myUserToken = UserDefaults.standard.value(forKey: "userToken")
        print("User Id: \(myUserID!)")
        print("User Name: \(myUserName!)")
        print("User Token: \(myUserToken!)")
        
                let token = "\(myUserToken!)"
                
                let headers: HTTPHeaders = [
                
                    .authorization(bearerToken: token),
                    .accept("application/json")
                    
                ]
        
        DispatchQueue.main.async {
            AF.request("http://yunusgunduz.site/wildbite/public/api/user/\(myUserID!))" , headers: headers )
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { [self]  response in
                    
                    
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        
                        let profileModelresponse = try? JSONDecoder().decode(ProfileModel.self, from: response.data!)
                        debugPrint(profileModelresponse!)
                        
                        print(profileModelresponse!.user.name)
                        print("Race: \(profileModelresponse!.race.raceName)")
                        
                        
                        userNameLabel.text = "Username: \(profileModelresponse!.user.name)"
                        
                        userRaceLabel.text = "Race: \(profileModelresponse!.race.raceName)"
                        switch profileModelresponse!.race.raceName {
                        case "0":
                            userRaceLabel.text = "Race: Hunter"
                        case "1":
                            userRaceLabel.text = "Race: Werewolf"
                        case "2":
                            userRaceLabel.text = "Race: Vampire"
                        
                        default:
                            userRaceLabel.text = "Race: None"
                        }
                        
                        userLevelLabel.text = "Level: \(profileModelresponse!.user.level)"
                        userEmailLabel.text = "Email: \(profileModelresponse!.user.email)"
                        userExpLabel.text = "Experience: \(profileModelresponse!.user.exp)"
                        userTotalDamageLabel.text = "Damage: \(profileModelresponse!.user.totalDamage)"
                        
                        let warTotals = profileModelresponse!.user.warTotal
                        let warWin = Double (profileModelresponse!.user.warTotalWin)
                        let warLose = Double (profileModelresponse!.user.warTotalLose)
                        
                       
                      
                        if(warLose! != 0){
                            let kda:Double = (warWin ?? 1) / (warLose ?? 1)
                            debugPrint("\(warTotals)  \(warWin!)  \(warLose!) \(kda) (WWR)")
                            userTotalWarLabel.text = "WAR WIN RATE: \(kda) (WWR) "
                        }else{
                            userTotalWarLabel.text = "WAR WIN RATE: \(warWin!) (WWR)"
                        }
                        
                        
                        
                        userTotalWarWinLabel.text = "Total War Win: \(profileModelresponse!.user.warTotalWin)"
                        userTotalWarLoseLabel.text = "Total War Lose: \(profileModelresponse!.user.warTotalLose)"
                        userTotalWarGoldLabel.text = "Total War Gold: \(profileModelresponse!.user.warTotalGold)"
                        userTotalHuntLabel.text = "Total Hunt: \(profileModelresponse!.user.totalHunt)"
                        userTotalSuccessHuntLabel.text = "Total Hunt Win: \(profileModelresponse!.user.totalSuccessHunt)"
                        
                        let gucValue = Float(profileModelresponse!.user.power)!
                        let defValue = Float(profileModelresponse!.user.defense)!
                        let hizValue = Float(profileModelresponse!.user.speed)!
                        
                        gucLabel.text = "\(Int(gucValue))"
                        defansLabel.text = "\(Int(defValue))"
                        speedLabel.text = "\(Int(hizValue))"
                        
                        if(gucValue > 99.0 || defValue > 99.0 || hizValue > 99.0){
                            gucProgressView.progress = (gucValue )/1000
                             
                            defansProgressView.progress = (defValue )/1000
                             
                            hizProgressView.progress = (hizValue )/1000
                        } else {
                            gucProgressView.progress = (gucValue )/10
                             
                            defansProgressView.progress = (defValue )/10
                             
                            hizProgressView.progress = (hizValue )/10
                        }
                     let myUserRole = profileModelresponse!.user.role
                        print("Debug: user role\(myUserRole)")
                        if(myUserRole   == "4"){
                            AdminPanelButtonText.isHidden = false
                        }else{
                            AdminPanelButtonText.isHidden = true
                        }
                        
                        profileModelresponse!.item.forEach { Item in
                            print("Item Name: \(Item.name) Level")
                            print(Item.name)
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    case let .failure(error):
                        print(error.errorDescription!)
                        print("hata")
                    }
                }
        }
    }

   
    @IBAction func AdminPanelButton(_ sender: Any) {
    }
    
}
