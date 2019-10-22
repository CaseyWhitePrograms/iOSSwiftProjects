// Project:     Lab8
// Class Name:  EndDateViewController
// Date:        10/25/18
// Author:      Casey White
// Description: EndDateViewController

import UIKit

class EndDateViewController: UIViewController {
    
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func endDateChanged(_ sender: UIDatePicker)
    {
        // call the setDate method in the viewController
        (presentingViewController as! ViewController).setEndDate(someEndDate: sender.date)
    }
    
    // get the EndDate from the first scene
    override func viewDidAppear(_ animated: Bool)
    {
        // get the end date from the viewController and set it to the DatePicker
        endDatePicker.date = (presentingViewController as! ViewController).endDate
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
