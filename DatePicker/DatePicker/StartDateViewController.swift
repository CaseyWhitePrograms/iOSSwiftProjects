// Project:     Lab8
// Class Name:  StartDateViewController
// Date:        10/25/18
// Author:      Casey White
// Description: StartDateViewController

import UIKit

class StartDateViewController: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBAction func startDateChanged(_ sender: UIDatePicker)
    {
        (presentingViewController as! ViewController).setStartDate(someStartDate: sender.date)
    }
    
    // get the startDate from the first scene
    override func viewDidAppear(_ animated: Bool)
    {
        // get the start date from the viewController and set it to the DatePicker
        startDatePicker.date = (presentingViewController as! ViewController).startDate
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
