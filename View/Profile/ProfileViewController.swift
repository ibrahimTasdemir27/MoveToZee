//
//  ProfileViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//
import Foundation
import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    var profileName = UILabel()
    var profileSurname = UILabel()
    var profileImage = UIImageView()
    var profileNumber = UILabel()
    var profileSignOut = UIButton(type: .system)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        
        //Layout
        profileName.text = "  Name :"
        profileName.textColor = .black
        profileName.backgroundColor = .white
        profileName.layer.borderWidth = 1
        profileName.layer.borderColor = UIColor.black.cgColor
        profileName.frame = CGRect(x: width * 0.3, y: height * 0.21, width: 263, height: 34)
        view.addSubview(profileName)
        
        profileSurname.text = "  Surname :"
        profileName.numberOfLines = 1
        profileSurname.textColor = .black
        profileSurname.backgroundColor = .white
        profileSurname.layer.borderWidth = 1
        profileSurname.layer.borderColor = UIColor.black.cgColor
        profileSurname.frame = CGRect(x: width * 0.3, y: height * 0.28, width: 263, height: 34)
        view.addSubview(profileSurname)
        
        profileImage = UIImageView(image: UIImage(named: "AppIcon"))
        profileImage.frame = CGRect(x: width * 0.09, y: height * 0.225, width: 80, height: 80)
        profileImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = 5
        profileImage.layer.borderColor = UIColor.black.cgColor
        view.addSubview(profileImage)
        
        profileNumber.text = "  Phone Number : "
        profileNumber.textColor = .black
        profileNumber.backgroundColor = .white
        profileNumber.layer.borderWidth = 1
        profileNumber.layer.borderColor = UIColor.black.cgColor
        profileNumber.frame = CGRect(x: width * 0.09 , y: height * 0.35, width: 349, height: 34)
        view.addSubview(profileNumber)
        
        profileSignOut.setTitle("Sign Out", for: UIControl.State.normal)
        profileSignOut.setTitleColor(UIColor.black ,for: UIControl.State.normal)
        profileSignOut.backgroundColor = .darkGray
        profileSignOut.layer.borderWidth = 1
        profileSignOut.layer.cornerRadius = 8
        profileSignOut.layer.borderColor = UIColor.black.cgColor
        profileSignOut.frame = CGRect(x: width * 0.360, y: height * 0.45, width: 132, height: 50)
        profileSignOut.translatesAutoresizingMaskIntoConstraints = false
        profileSignOut.tag = 1
        profileSignOut.addTarget(self, action: #selector(signOut), for: UIControl.Event.touchUpInside)
        view.addSubview(profileSignOut)
        print(profileSignOut.frame.size.width)
        
    }
    
    @objc func signOut(){
        let activeUser = Auth.auth().currentUser
        do{
            try? Auth.auth().signOut()
            performSegue(withIdentifier: "toLogin", sender: nil)
        }catch{
            showAlert(title: "Failure", message: error.localizedDescription ?? "Try Again")
        }
        
        
    }
    
    
   

}
