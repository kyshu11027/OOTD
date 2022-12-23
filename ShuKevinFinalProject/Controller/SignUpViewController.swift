//
//  SignUpViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/22/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    private let user: User = User.sharedInstance
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.backgroundView.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTapped(_:)))
        
        backgroundView.addGestureRecognizer(tap)
    }
    
    //in case the background is tapped, we close everrything
    @objc func backgroundDidTapped(_ tap: UITapGestureRecognizer) {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    
    @IBAction func cancelButtonDidPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func conditionsFulfilled() -> Bool{
        if (emailTextField.text ?? "" == "") ||
            (usernameTextField.text ?? "" == "") ||
            (passwordTextField.text ?? "" == "") ||
            (confirmPasswordTextField.text ?? "" == "") ||
            (confirmPasswordTextField.text ?? "" != passwordTextField.text ?? ""){
            
            return false
            
        }
        
        return true
    }
    
    func clearFields(){
        passwordTextField.text = ""
        
        confirmPasswordTextField.text = ""

    }
    
    @IBAction func signUpDidTapped(_ sender: Any) {
        
        if conditionsFulfilled(){
            
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(result, error) in
                
                //if no errors show authenticated page
                if error == nil{
                    //self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                    
                    
                    let id: String = Auth.auth().currentUser?.uid ?? ""
                    let email: String = Auth.auth().currentUser?.email ?? ""
                    
                    self.user.logIn(id: id, email: email)
                    self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                }
                else{
                    print("Error communicating with Firebase: \(String(describing: error))")
                }
                
                
            })
        }
        else{
            //we have a repeated question so make an alert and present it.
            let alert = UIAlertController(title: "Error", message: "Your inputs are empty or your passwords do not match", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.clearFields()}) //completion calls cancel function
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func emailDoneDidTapped(_ sender: Any) {
        emailTextField.resignFirstResponder()
        
        
    }
    @IBAction func usernameDidTapped(_ sender: Any) {
        
        usernameTextField.resignFirstResponder()
    }
    
    @IBAction func passwordDoneDidTapped(_ sender: Any) {
        passwordTextField.resignFirstResponder()
        
    }
    
    @IBAction func confirmDoneDidTapped(_ sender: Any) {
        confirmPasswordTextField.resignFirstResponder()
    }
}
