//
//  ChosenWarTypeViewController.swift
//  wildbite
//
//  Created by Yunus Gündüz on 6.05.2023.
//

import UIKit
import Alamofire
import Kingfisher


 

class ChosenWarTypeViewController: UIViewController {

    
    
    @IBOutlet weak var enemynameLabel: UILabel!
    @IBOutlet weak var enemyRole: UILabel!
    @IBOutlet weak var enemyLevel: UILabel!
    @IBOutlet weak var enemyDamage: UILabel!
    @IBOutlet weak var enemyPower: UILabel!
    @IBOutlet weak var enemyDefance: UILabel!
    @IBOutlet weak var enemySpeed: UILabel!
    @IBOutlet weak var enemyHealth: UILabel!
    
    @IBOutlet weak var enemyProfileImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }
    
    fileprivate func loadWarProfileEnemy() {
        let myUserID = UserDefaults.standard.value(forKey: "userID")
        
        let myUserToken = UserDefaults.standard.value(forKey: "userToken")
        let myChoosenWartype = UserDefaults.standard.value(forKey: "choosenWartype") as! Int
        print("User Id: \(myUserID!)")
        
        print("User Token: \(myUserToken!)")
        print("User myChoosenWartype: \(myChoosenWartype)")
        
        let token = "\(myUserToken!)"
        
        let headers: HTTPHeaders = [
            
            .authorization(bearerToken: token),
            .accept("application/json")
            
        ]
        
        
        
        AF.request("http://yunusgunduz.site/wildbite/public/api/random-race-user?race=\(myChoosenWartype))" , headers: headers )
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData { [self]  response in
                debugPrint(response)
                
                switch response.result {
                case .success:
                    print("Validation Successful")
                    
                    let chosenWar = try? JSONDecoder().decode(ChosenWar.self, from: response.data!)
                    
                    
                    
                    
                    print(chosenWar!)
                   
                    if(chosenWar == nil){
                        loadWarProfileEnemy()
                    }else{
                        
                        if let enemyID = chosenWar?.user.id{
                            
                            if(myUserID as! Int == enemyID){
                                loadWarProfileEnemy()
                            }
                         
                        }
                        // enemy name
                        if let enemyNamem = chosenWar?.user.name{
                            
                            enemynameLabel.text = "Name: \(enemyNamem)"
                        }
                        // enemy Type
                        
                            switch myChoosenWartype {
                                case 1:
                                    enemyRole.text = "Role: HUNTER "
                                case 2:
                                    enemyRole.text = "Role: WEREWOLF "
                                case 3:
                                    enemyRole.text = "Role: VAMPIRE "
                                case 4:
                                    enemyRole.text = "Role: WITCH "
                                default:
                                    enemyRole.text = "-"
                            }
                           
                        
                        // enemy level
                        if let enemyLevelm = chosenWar?.user.level{
                            
                            enemyLevel.text = "Level: \(enemyLevelm)"
                        }
                        //enemy Damage
                        if let enemyDamagem = chosenWar?.user.totalDamage{
                            
                            enemyDamage.text = "Damage: \(enemyDamagem)"
                        }
                        
                        //enemy Power
                        if let enemyPowerm = chosenWar?.user.power{
                            
                            enemyPower.text = "Power: \(enemyPowerm)"
                        }
                        
                        //enemy Defence
                        if let enemyDefensem = chosenWar?.user.defense{
                            
                            enemyDefance.text = "Defense: \(enemyDefensem)"
                        }
                        
                        //enemy Speed
                        if let enemySpeedm = chosenWar?.user.speed{
                            
                            enemySpeed.text = "Speed: \(enemySpeedm)"
                        }
                        
                        //enemy Health
                        if let enemyHealthm = chosenWar?.user.maximumHealth{
                            
                            enemyHealth.text = "Health: \(enemyHealthm)"
                        }
                        //enemy Health
                        if let enemyimagem = chosenWar?.user.image{
                            
                            let url = URL(string: "\(enemyimagem)")
                            DispatchQueue.main.async{ [self] in
                                enemyProfileImage.kf.setImage(with: url)
                            }
                           
                            
                             
                        }
                        
                        
                        
                    }
                   
                    
                    
                case let .failure(err):
                    print("Hata oldi")
                    print(err.errorDescription!)
                }
                
            }
    }
    @IBAction func againChooseButton(_ sender: Any) {
        
        let myChoosenNumber = UserDefaults.standard.value(forKey: "choosenWarNumber")
        if(myChoosenNumber as! String == "random" ){
            let random = Int.random(in: 1...4)
            
            UserDefaults.standard.set(random, forKey: "choosenWartype")
        }
        
      
       
       
        
        let WarSaldiranUserName = UserDefaults.standard.string(forKey: "WarSaldiranUserName")
        let WarSaldiranUserRole = UserDefaults.standard.integer(forKey: "WarSaldiranUserRole")
        let WarSaldiranUserExp = UserDefaults.standard.integer(forKey: "WarSaldiranUserExp")
        let WarSaldiranUserLevel = UserDefaults.standard.integer(forKey: "WarSaldiranUserLevel")
        let WarSaldiranUserGold = UserDefaults.standard.integer(forKey: "WarSaldiranUserGold")
        let WarSaldiranUserCurrentHealth = UserDefaults.standard.integer(forKey: "WarSaldiranUserCurrentHealth")
        let WarSaldiranUserMaximumHealth = UserDefaults.standard.integer(forKey: "WarSaldiranUserMaximumHealth")
        let WarSaldiranUserCurrentEnergy = UserDefaults.standard.integer(forKey: "WarSaldiranUserCurrentEnergy")
        let WarSaldiranUserMaximumEnergy = UserDefaults.standard.integer(forKey: "WarSaldiranUserMaximumEnergy")
        let WarSaldiranUserNightMissionState = UserDefaults.standard.integer(forKey: "WarSaldiranUserNightMissionState")
        let WarSaldiranUserTotalDamage = UserDefaults.standard.integer(forKey: "WarSaldiranUserTotalDamage")
        let WarSaldiranUserPower = UserDefaults.standard.integer(forKey: "WarSaldiranUserPower")
        let WarSaldiranUserDefense = UserDefaults.standard.integer(forKey: "WarSaldiranUserDefense")
        let WarSaldiranUserSpeed = UserDefaults.standard.integer(forKey: "WarSaldiranUserSpeed")
        let WarSaldiranUserRacename = UserDefaults.standard.integer(forKey: "WarSaldiranUserRacename")
        let usertoken = UserDefaults.standard.string(forKey: "userToken")
        // api  start
       let headers: HTTPHeaders = [
           .authorization(bearerToken: usertoken!),
           .accept("application/json")
       ]
       
        
        let nightMissionParameters = NightMissionYapi(gold: 0, current_health: 0, maximum_health: 0, current_energy: -1, maximum_energy: 0, level: 0, night_mission_state: "\(WarSaldiranUserNightMissionState)", exp: 0 )
        
      AF.request("https://yunusgunduz.site/wildbite/public/api/night-mission",
                 method: .put,
                 parameters: nightMissionParameters,
                 headers: headers)
      .validate(statusCode: 200..<500)
      .validate(contentType: ["application/json"])
      .responseData {  response in
          debugPrint(response)
          switch response.result {
          case .success:
                  let NightMissionresponse = try? JSONDecoder().decode(NightMissionModel.self,  from: response.data!)
                  debugPrint(NightMissionresponse!)
                
                  self.loadWarProfileEnemy()
                  
          case let .failure(error):
              print(error.errorDescription!)
              print("hata")
          }
      }
    // api end
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWarProfileEnemy()
        let nightMissionType = UserDefaults.standard.integer(forKey: "NightMissionType")
        dump("nightMissionType: \(nightMissionType)")
            }
    }
   
    


