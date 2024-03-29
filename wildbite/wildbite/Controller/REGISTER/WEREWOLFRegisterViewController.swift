//
//  GhostRegisterViewController.swift
//  wildbite
//
//  Created by Yunus Gunduz on 13.04.2023.
//

import UIKit
import Alamofire

class WEREWOLFRegisterViewController: UIViewController {

    
    @IBOutlet weak var powerProgress: UIProgressView!
    
    @IBOutlet weak var defProgress: UIProgressView!
    
    
    @IBOutlet weak var speedProgress: UIProgressView!
    
    @IBOutlet weak var smartProgress: UIProgressView!
    
    @IBOutlet weak var powValueLabel: UILabel!
    @IBOutlet weak var defValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var smartValueLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RegisterBackground.png")!)
        powerProgress.progress = 0.3
        defProgress.progress = 0.2
        speedProgress.progress = 0.5
       // smartProgress.progress = 0.3
        
        powValueLabel.text = "3"
        defValueLabel.text = "2"
        speedValueLabel.text = "5"
     //   smartValueLabel.text = "3"
        
      
    }
    
    
    @IBAction func selectbutton(_ sender: Any) {
        var userrole = 1
        var userlevel = 1
        var userexp = 0
        var userwartotal = 0
        var userwarwin = 0
        var userwarlose = 0
        var userwargold = 0
        var usergold = 100
        var userdiamond = 0
        var usertotalhunt  = 0
        var usersuccesshunt  = 0
        var usercurrenthealth  = 100
        var usermaxhealth  = 100
        var usercurrentenergy  = 10
        var usermaxenergy  = 10
        var userregenerate_health_range = 1
        
        
        var userrace = 2
        var userpower = 3
        var userdefense = 2
        var userspeed  = 5
       
        var totaldamage = 10
        let random = Int.random(in: 1...6)
        var userimage = "http://backhub.site/wildbite/image/user/kurtadam/\(Int.random(in: 1...6)).png"
        
       var usernameUSS = UserDefaults.standard.string(forKey: "RegisterUserName")
       var usertokenUSS = UserDefaults.standard.string(forKey: "RegisterUserToken")
       var useridUSS = UserDefaults.standard.integer(forKey: "RegisterUserID")
       var useremailUSS = UserDefaults.standard.string(forKey: "RegisterUserEmail")
       var userpasswordUSS = UserDefaults.standard.string(forKey: "RegisterPassword")
        
         
            let headers: HTTPHeaders = [
            
                .authorization(bearerToken: usertokenUSS!),
                .accept("application/json")
                
            ]

        let registerraceparameters =  RegisterRace(name: usernameUSS!, email: useremailUSS!, password: userpasswordUSS!, role: userrole, race: userrace, level: userlevel, night_mission_state:"1", exp: userexp, war_total: userwartotal, war_total_win: userwarwin, war_total_lose: userwarlose, war_total_gold: userwargold, gold: usergold, diamond: userdiamond, total_damage: totaldamage, power: userpower, defense: userdefense, speed: userspeed, total_hunt: usertotalhunt, total_success_hunt: usersuccesshunt, current_health: usercurrenthealth, maximum_health: usermaxhealth, regenerate_health_range: userregenerate_health_range, current_energy: usercurrentenergy, maximum_energy: usermaxenergy, image: userimage)
          
           AF.request("http://backhub.site/wildbite/public/api/user/\(useridUSS)",
                      method: .put,
                      parameters: registerraceparameters,
                      headers: headers)
           .validate(statusCode: 200..<500)
           .validate(contentType: ["application/json"])
           .responseData { [self] response in
               debugPrint(response)
                
               switch response.result {
               case .success:
                   print("Register Successful")
                       self.performSegue(withIdentifier: "registerRaceToLogin", sender: nil)
                       let registerRaceresponse = try? JSONDecoder().decode(RegisterRaceModel.self,  from: response.data!)

                   debugPrint(registerRaceresponse ?? "ne oldi")
                   if(registerRaceresponse?.the1 == nil){
                       print("Debug: Message:  \(registerRaceresponse?.the1 ?? "bisey oldu")")
                       return
                   }
                 
                   
                  
                       
                       
                       
                       if(registerRaceresponse!.the1 == "User updated"){
                           self.performSegue(withIdentifier: "registerRaceToLogin", sender: nil)
                      
                       
                       
                       
                    
                   }else{
                       print("DEBUG: Kayit olunamadi mesaji döndü")
                   }
                    
                   
                   
               case let .failure(error):
                   print(error.errorDescription!)
                   print("hata")
               }
           }

         
       }
        
       
    }

 
    



