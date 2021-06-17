import UIKit

class AwsQuizViewController: UIViewController {
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var judgeImageView: UIImageView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // background color
        view.backgroundColor = UIColor(red: 240/255, green: 238/255, blue: 237/255, alpha: 0.99)
        
        if answerButton1 != nil {
            self.answerButton1.layer.cornerRadius = 12
            self.answerButton1.backgroundColor = UIColor.systemBlue
            self.answerButton1.layer.shadowOpacity = 0.4
            self.answerButton1.layer.shadowRadius = 12
            self.answerButton1.layer.shadowColor = UIColor.black.cgColor
            self.answerButton1.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        if answerButton2 != nil {
            self.answerButton2.layer.cornerRadius = 12
            self.answerButton2.backgroundColor = UIColor.systemBlue
            self.answerButton2.layer.shadowOpacity = 0.4
            self.answerButton2.layer.shadowRadius = 12
            self.answerButton2.layer.shadowColor = UIColor.black.cgColor
            self.answerButton2.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        if answerButton3 != nil {
            self.answerButton3.layer.cornerRadius = 12
            self.answerButton3.backgroundColor = UIColor.systemBlue
            self.answerButton3.layer.shadowOpacity = 0.4
            self.answerButton3.layer.shadowRadius = 12
            self.answerButton3.layer.shadowColor = UIColor.black.cgColor
            self.answerButton3.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        if answerButton4 != nil {
            self.answerButton4.layer.cornerRadius = 12
            self.answerButton4.backgroundColor = UIColor.systemBlue
            self.answerButton4.layer.shadowOpacity = 0.4
            self.answerButton4.layer.shadowRadius = 12
            self.answerButton4.layer.shadowColor = UIColor.black.cgColor
            self.answerButton4.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        if quizTextView != nil {
            self.quizTextView.layer.cornerRadius = 11.5
            self.quizTextView.backgroundColor = UIColor.white
            self.quizTextView.layer.shadowOpacity = 0.4
            self.quizTextView.layer.shadowRadius = 11.5
            self.quizTextView.layer.shadowColor = UIColor.black.cgColor
            self.quizTextView.layer.shadowOffset = CGSize(width: 6, height: 6)
        }
        
        csvArray = loadCSV(fileName: "quiz")
        print(csvArray)
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        if quizNumberLabel != nil {
            quizNumberLabel.text = "Question..."
        }
        if quizTextView != nil {
            quizTextView.text = quizArray[0];
        }
        if answerButton1 != nil {
            answerButton1.setTitle(quizArray[2], for: .normal)
        }
        if answerButton2 != nil {
            answerButton2.setTitle(quizArray[3], for: .normal)
        }
        if answerButton3 != nil {
            answerButton3.setTitle(quizArray[4], for: .normal)
        }
        if answerButton4 != nil {
            answerButton4.setTitle(quizArray[5], for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.description as? ScoreViewController
        scoreVC?.correct = correctCount
    }
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("Correct")
            judgeImageView.image = UIImage(named: "correct.jpeg")
        } else {
            print("Incorrect")
            judgeImageView.image = UIImage(named: "incorrect.jpeg")
        }
        print("SCORE: \(correctCount)")
        judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("Error")
        }
        return csvArray
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
