// Project:       Lab2
// Class Name:    ViewController
// Date:          09/06/18
// Author:        Casey White
// Description:
// Rock, Paper, Scissor game application
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ivPlayer: UIImageView!
    @IBOutlet weak var ivComputer: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    
    // game variables
    var player:Int = 0
    var computer:Int = 0
    var playerScore:Int = 0
    var computerScore:Int = 0
    
    // game constants
    let ROCK:Int = 0
    let PAPER:Int = 1
    let SCISSORS:Int = 2
    
    // determine the winner
    func winner()
    {
        if player == ROCK
        {
            if computer == ROCK
            {
                lblScore.text = "It's a Tie! \(playerScore) To \(computerScore)"
            }
            if computer == PAPER
            {
                computerScore += 1
                lblScore.text = "You Lose! \(playerScore) To \(computerScore)"
            }
            if computer == SCISSORS
            {
                playerScore += 1
                lblScore.text = "You Win! \(playerScore) To \(computerScore)"
            }
        }
        if player == PAPER
        {
            if computer == PAPER
            {
                lblScore.text = "It's a Tie! \(playerScore) To \(computerScore)"
            }
            if computer == SCISSORS
            {
                computerScore += 1
                lblScore.text = "You Lose! \(playerScore) To \(computerScore)"
            }
            if computer == ROCK
            {
                playerScore += 1
                lblScore.text = "You Win! \(playerScore) To \(computerScore)"
            }
        }
        if player == SCISSORS
        {
            if computer == SCISSORS
            {
                lblScore.text = "It's a Tie! \(playerScore) To \(computerScore)"
            }
            if computer == ROCK
            {
                computerScore += 1
                lblScore.text = "You Lose! \(playerScore) To \(computerScore)"
            }
            if computer == PAPER
            {
                playerScore += 1
                lblScore.text = "You Win! \(playerScore) To \(computerScore)"
            }
        }    }
    
    func computerChoose()
    {
        // generate a random number from 0 to 2 (Rock=0, paper=1, scissors=2)
        computer = Int(arc4random()) % 3
        
        // display the correct image
        if computer == ROCK
        {
            ivComputer.image = UIImage(named:"rock")
        }
        if computer == PAPER
        {
            ivComputer.image = UIImage(named:"paper")
        }
        if computer == SCISSORS
        {
            ivComputer.image = UIImage(named:"scissors")
        }
    }
    
    @IBAction func btnRock(_ sender: UIButton)
    {
        // set player to rock
        ivPlayer.image = UIImage(named:"rock")
        player = ROCK
        
        // call method to have computer make a choice and decide winner
        computerChoose()
        winner()
    }
    
    @IBAction func btnPaper(_ sender: UIButton)
    {
        // set player to paper
        ivPlayer.image = UIImage(named:"paper")
        player = PAPER
        
        // call method to have computer make a choice and decide winner
        computerChoose()
        winner()
    }
    
    @IBAction func btnScissors(_ sender: UIButton)
    {
        // set player to scissors
        ivPlayer.image = UIImage(named:"scissors")
        player = SCISSORS
        
        // call method to have computer make a choice and decide winner
        computerChoose()
        winner()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

