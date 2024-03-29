//
//  RegisterViewController.swift
//  wildbite
//
//  Created by Yunus Gunduz on 29.03.2023.
//

import UIKit
import Alamofire

struct Register: Encodable {
    let email: String
    let name: String
    let password: String
    let password_confirmation: String
    let image: String
    let role:Int
 
    
    
    
}
class RegisterViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
     
    
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        userRegister()
    }
    
    
    
    
    func userRegister() {
       
        if(mailTextField.text == "" || passwordTextField.text == "" || usernameTextField.text == "" ){
            
            return
        }
        
        let register = Register(email: mailTextField.text!, name: usernameTextField.text!, password: passwordTextField.text!, password_confirmation: passwordTextField.text!, image: "null.jpg", role: 1)
       
       AF.request("https://backhub.site/wildbite/public/api/register",
                  method: .post,
                  parameters: register,
                  encoder: JSONParameterEncoder.default)
       .validate(statusCode: 200..<300)
       .validate(contentType: ["application/json"])
       .responseData { [self] response in
           debugPrint(response)
           if(response.response?.statusCode == 500){
               self.usernameTextField.backgroundColor = UIColor.yellow
           }
           switch response.result {
           case .success:
               print("Register Successful")
               
               let registerResponse = try? JSONDecoder().decode(RegisterModel.self, from: response.data!)

               debugPrint(registerResponse ?? "ne oldi")
               if(registerResponse?.message == nil || self.mailTextField.text == "" || self.passwordTextField.text == ""){
                   print("Debug: Message:  \(registerResponse?.message ?? "bisey oldu")")
                   return
               }
             
               
              print("Debug: endpoint response")
               print("User name: \(registerResponse!.user.name)")
               print("User token: \(registerResponse!.token)")
               print("User ID: \(registerResponse!.user.id)")
               print("User email: \(registerResponse!.user.email)")
               print("User message: \(registerResponse!.message)")
                   
                   
                   
                   
               if(registerResponse!.message == "Accoun created."){
                   self.performSegue(withIdentifier: "registerStepTwo", sender: nil)
                  
                   
                   UserDefaults.standard.set(registerResponse!.user.name, forKey: "RegisterUserName")
                   UserDefaults.standard.set(passwordTextField.text!, forKey: "RegisterPassword")
                   UserDefaults.standard.set(registerResponse!.token, forKey: "RegisterUserToken")
                   UserDefaults.standard.set(registerResponse!.user.id, forKey: "RegisterUserID")
                   
                   UserDefaults.standard.set(registerResponse!.user.email, forKey: "RegisterUserEmail")
                   
                
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
