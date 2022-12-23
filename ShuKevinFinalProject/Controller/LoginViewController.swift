//
//  LoginViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/21/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    
    private let user = User.sharedInstance
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTapped(_:)))
        
        backgroundView.addGestureRecognizer(tap)
    }
    
    //in case the background is tapped, we close everrything
    @objc func backgroundDidTapped(_ tap: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    @IBAction func cancelButtonDidPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func noneEmpty() -> Bool{
        if (emailTextField.text ?? "" == "") ||
            (passwordTextField.text ?? "" == ""){
            
            return false
        }
        
        return true
    }
    
    
    @IBAction func logInDidTapped(_ sender: Any) {
        if noneEmpty(){
            
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().signIn(withEmail: email, password: password){
                result, error in
                
                if error == nil {
                    //self.performSegue(withIdentifier: "LogInSegue", sender: nil)
                    
                    let id: String = Auth.auth().currentUser?.uid ?? ""
                    let email: String = Auth.auth().currentUser?.email ?? ""
                    
                    self.user.logIn(id: id, email: email)
                    self.performSegue(withIdentifier: "LogInSegue", sender: nil)
                    
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Sign in failed", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.passwordTextField.text! = ""}) //completion calls cancel function
                    
                    alert.addAction(okAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
                
                
                
            }
            
            
            
        }
        else{
            
            let alert = UIAlertController(title: "Error", message: "Your inputs are empty", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.passwordTextField.text! = ""}) //completion calls cancel function
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    
    //following two functions close keyboard when done is pressed
    @IBAction func emailDoneDidTapped(_ sender: Any) {
        emailTextField.resignFirstResponder()
    }
    
    
    @IBAction func passwordDoneDidTapped(_ sender: Any) {
        passwordTextField.resignFirstResponder()
    }
}
