//
//  AddGarmentViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/23/22.
//

import UIKit

class AddGarmentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    let defaultImage: UIImage? = UIImage(named: "OOTD")
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var garmentTypeSegControl: UISegmentedControl!
    
    @IBOutlet weak var dressCodeSegControl: UISegmentedControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    typealias AddCompletionHandler = (UIImage?, String?, String?, String?) -> Void
    
    var completionHandler: AddCompletionHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize the view
        saveButton.tintColor = .gray
        imageView.image = defaultImage
        self.nameTextField.delegate = self
        
        //allow for the background to be tapped
        self.backgroundView.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTapped(_:)))
        
        backgroundView.addGestureRecognizer(tap)
        
    }
    
    //in case the background is tapped, we close everrything
    @objc func backgroundDidTapped(_ tap: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()

    }
    
    //open up camera roll so photo can be chosen
    @IBAction func cameraRollDidTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        

    }
    
    //open up the camera so that we can choose a photo
    @IBAction func cameraDidTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    //returning the chosen image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        imageView.image = image
        picker.dismiss(animated: true)
        
        
        //after the picker is dismissed, we need to check if the fields are filled to turn on the button or not
        if allFieldsFilled(){
            saveButton.tintColor = .systemBlue
        }
        else{
            saveButton.tintColor = .gray
        }
    }
    
    
    //if the user presses cancel when the new view is up
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    //check if any changes to the textField are made so we can change the color of the button
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if allFieldsFilled(){
            saveButton.tintColor = .systemBlue
        }
        else{
            saveButton.tintColor = .gray
        }
        
        return true
    }
    
    
    //if done is tapped, we should close the keyboard popup
    @IBAction func doneDidTapped(_ sender: Any) {
        nameTextField.resignFirstResponder()
    }
    
    //helper function to determine if all the fields are filled
    func allFieldsFilled() -> Bool{
        
        if (imageView.image != defaultImage) && (nameTextField.text != ""){
            
            return true
        }
        
        return false
    }
    
    @IBAction func cancelDidPressed(_ sender: UIBarButtonItem){
        nameTextField.text = ""
        imageView.image = defaultImage
        
        if let completionHandler = completionHandler {
            completionHandler(nil, nil, nil, nil)
        }
        
    }
    
    
    @IBAction func saveDidPressed(_ sender: UIBarButtonItem) {
        
        if allFieldsFilled(){
            
            //we can now run our completionHandler
            if let completionHandler = completionHandler {
                
                //save all of our values
                let image = imageView.image
                let name = nameTextField.text
                let type = garmentTypeSegControl.titleForSegment(at: garmentTypeSegControl.selectedSegmentIndex)?.lowercased()
                let dressCode = dressCodeSegControl.titleForSegment(at: dressCodeSegControl.selectedSegmentIndex)?.lowercased()
                
                
                completionHandler(image, name, type, dressCode)
            }
            
            
        }
        else{
            
            let alert = UIAlertController(title: "Warning!", message: "You need to fill out all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
}
