//
//  ViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 28.07.2022.
//

import Alamofire
import FirebaseAuth
import UIKit

class ViewController: UIViewController {
    @IBOutlet var loginPassword: UITextField!
    @IBOutlet var loginEmail: UITextField!
    @IBOutlet var loginImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginImage.image = UIImage(named: "background")
        loginImage.contentMode = .scaleAspectFill
    }

    @IBAction func loginLog(_ sender: Any) {
        // Giriş yap
        // Email ve ya şifre boş mu
        if loginEmail.text != "" && loginPassword.text != "" {
            // Email ve şifre dolu -> Formatlar doğru mu
            if isValidEmail(loginEmail.text!) == true {
                // Doğru Format
                // Şifreye bakalım
                if loginPassword.text!.count > 8 {
                    // Şifre ve email formatı doğru
                    Auth.auth().signIn(withEmail: loginEmail.text!, password: loginPassword.text!) { _, error in
                        if let error = error {
                            self.showAlert(title: "Failure", message: error.localizedDescription ?? "Try Again")
                        }
                        // Giriş başarılı
                        else {
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                        }
                    }
                } else {
                    // Şifre formatı hatalı
                    showAlert(title: "Password cannot be shorter than 8 characters.", message: "Please try again")
                }
            }
        } else {
            if loginEmail.text == "" && loginPassword.text == "" {
                // Şifre ve email boş
                showAlert(title: "E-mail and Password empty", message: "Please enter your E-mail and Password")
            }
            if loginEmail.text == "" {
                // Email boş
                showAlert(title: "E-mail cannot be empty", message: "Please enter your E-mail")
            }
            if loginPassword.text == "" {
                // Şifre boş
                showAlert(title: "Password cannot be blank", message: "Please enter your password")
            }
        }
    }

    @IBAction func loginSubscribe(_ sender: Any) {
        // Kayıt ol
        // Email ve ya şifre boş mu
        guard loginPassword.text != "" && loginEmail.text != "" else {
            if loginEmail.text == "" && loginPassword.text == "" {
                showAlert(title: "E-mail and Password empty", message: "Please enter your E-mail and Password")
            }
            if loginEmail.text == "" {
                showAlert(title: "E-mail cannot be empty ", message: "Please enter your E-mail")
                return
            } else if isValidEmail(loginEmail.text!) == false {
                showAlert(title: "Failure E-mail format", message: "Please enter an E-mail in the correct format")
                return
            } else if loginPassword.text == "" {
                showAlert(title: "Password cannot be empty", message: "Please enter your password")
                return
            } else if loginPassword.text!.count < 8 {
                showAlert(title: "Password cannot be shorter than 8 characters", message: "Please try again")
                return
            }

            return
        }

        guard isValidEmail(loginEmail.text!) == true else {
            showAlert(title: "Failure E-mail format", message: "Please enter an E-mail in the correct format")
            return
        }

        guard loginPassword.text!.count > 8 else {
            showAlert(title: "Password cannot be shorter than 8 characters", message: "Please try again")
            return
        }

        // Kontroller Tamam
        // Üye olacak

        Auth.auth().createUser(withEmail: loginEmail.text!, password: loginPassword.text!) { _, error in
            if let error = error {
                self.showAlert(title: "Failure", message: error.localizedDescription ?? "Try Again")
            }
            // Üye oluşturuldu
            self.performSegue(withIdentifier: "toTabBar", sender: nil)
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okeyButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)

        alert.addAction(okeyButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{1,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
