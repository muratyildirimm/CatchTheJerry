
import UIKit

class ViewController: UIViewController {
  // MARK: IBOutlet
   @IBOutlet weak var scoreLabel: UILabel!
   @IBOutlet weak var timeLabel: UILabel!
   @IBOutlet weak var highScoreLabel: UILabel!
   @IBOutlet weak var image1: UIImageView!
   @IBOutlet weak var image2: UIImageView!
   @IBOutlet weak var image3: UIImageView!
   @IBOutlet weak var image4: UIImageView!
   @IBOutlet weak var image5: UIImageView!
   @IBOutlet weak var image6: UIImageView!
   @IBOutlet weak var image7: UIImageView!
   @IBOutlet weak var image8: UIImageView!
   @IBOutlet weak var image9: UIImageView!
  
  // MARK: Variables
  var score = 0
  var kennyArray = [UIImageView]()
  var time = 5
  var timer = Timer()
  var hideTimer = Timer()
  var highScore = 0
  
   override func viewDidLoad() {
      super.viewDidLoad()
     // Store the high score in user defaults
      var highScore = UserDefaults.standard.object(forKey: "highscore")
      if highScore == nil
      {
         highScore = 0
         highScoreLabel.text = "High Score: \(highScore!)"
      }
      
      if let newHighScore = highScore as? Int
      {
         highScore = newHighScore
         highScoreLabel.text = "High Score: \(highScore!)"
      }
     // I added gesture recognizer to all Image View to catch the pick up every tap
      touchable()
      timeLabel.text = String(time)
     // Timer
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
      kennyArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
      hideKenny()
      hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
   }
  // Hide Kenny function
  @objc func hideKenny(){
      for kenny in kennyArray{
         kenny.isHidden = true
      }
     let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
      kennyArray[random].isHidden = false
  }
   // Reducing time function
   @objc func countDown(){
      time -= 1
      timeLabel.text = String(time)

      if time <= 0 {
         timeLabel.text = "Time Finished"
         timer.invalidate()
         hideTimer.invalidate()
         for kenny in kennyArray{
            kenny.isHidden = false
            kenny.isUserInteractionEnabled = true
         }
         if self.score > self.highScore {
            self.highScore = self.score
            self.highScoreLabel.text = "High Score: \(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
         }
         // Creating alert controller
         let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: .alert)
        // Creating alert action
         let okButton = UIAlertAction(title: "Ok", style: .cancel){
            (UIAlertAction) in
            self.score = 0
            for kenny in self.kennyArray{
               
               kenny.isUserInteractionEnabled = false
            }
         }
         // Creating alert action
         let replayButton = UIAlertAction(title: "Replay", style: .default){
            (UIAlertAction) in
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.time = 5
            self.timeLabel.text = "Time: \(self.time)"
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
         }
        // Adding action to controller
         alert.addAction(okButton)
         alert.addAction(replayButton)
        // Present the alert
         self.present(alert, animated: true)
      }
   }
   // Increase the score whit every catch
   @objc func imageTouched(){
      score += 1
      scoreLabel.text = "Score: \(score)"
   }
  
  func touchable(){
      image1.isUserInteractionEnabled = true
      image2.isUserInteractionEnabled = true
      image3.isUserInteractionEnabled = true
      image4.isUserInteractionEnabled = true
      image5.isUserInteractionEnabled = true
      image6.isUserInteractionEnabled = true
      image7.isUserInteractionEnabled = true
      image8.isUserInteractionEnabled = true
      image9.isUserInteractionEnabled = true
      
      let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(imageTouched))
      
      image1.addGestureRecognizer(gestureRecognizer1)
      image2.addGestureRecognizer(gestureRecognizer2)
      image3.addGestureRecognizer(gestureRecognizer3)
      image4.addGestureRecognizer(gestureRecognizer4)
      image5.addGestureRecognizer(gestureRecognizer5)
      image6.addGestureRecognizer(gestureRecognizer6)
      image7.addGestureRecognizer(gestureRecognizer7)
      image8.addGestureRecognizer(gestureRecognizer8)
      image9.addGestureRecognizer(gestureRecognizer9)
   }
}
