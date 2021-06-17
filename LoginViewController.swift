import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var LoginBtn: UIButton!
    @IBOutlet var SignupBtn: UIButton!
    @IBOutlet var helpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackground(name: "background_image.jpeg")
        // Do any additional setup after loading the view.

        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
        self.usernameField.placeholder = "Name"
        self.passwordField.placeholder = "Pass"
        
        if LoginBtn != nil {
            self.LoginBtn.layer.cornerRadius = 10
            self.LoginBtn.backgroundColor = UIColor.clear
            self.LoginBtn.layer.shadowOpacity = 0.4
            self.LoginBtn.layer.shadowRadius = 10
            self.LoginBtn.layer.shadowColor = UIColor.black.cgColor
            self.LoginBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        
        if SignupBtn != nil {
            self.SignupBtn.layer.cornerRadius = 10
            self.SignupBtn.backgroundColor = UIColor.clear
            self.SignupBtn.layer.shadowOpacity = 0.4
            self.SignupBtn.layer.shadowRadius = 10
            self.SignupBtn.layer.shadowColor = UIColor.black.cgColor
            self.SignupBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        
        if helpBtn != nil {
            self.helpBtn.layer.cornerRadius = 10
            self.helpBtn.backgroundColor = UIColor.white
            self.helpBtn.layer.shadowOpacity = 0.4
            self.helpBtn.layer.shadowRadius = 10
            self.helpBtn.layer.shadowColor = UIColor.black.cgColor
            self.helpBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        
        /*
         
        // Need Liftup in tapped
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
         
        */
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        let username = usernameField.text
        let password = passwordField.text
        
        if(username == "" || password == "") {
            
        }
    }
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // KeyBoard permissions
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                } else {
                    let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                    self.view.frame.origin.y -= suggestionHeight
                }
            }
        }
    
    @objc func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    
    @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
