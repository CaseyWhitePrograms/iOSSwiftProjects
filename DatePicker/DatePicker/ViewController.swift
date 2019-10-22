// Project:     Lab8
// Class Name:  ViewController
// Date:        10/25/18
// Author:      Casey White
// Description:
// An application that calculates the number of days between two user supplied dates.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var lblDaysBetween: UILabel!
    
    // variables to save the dates from the start and end date scenes
    var startDate:Date = Date()
    var endDate:Date = Date()
    
    // calculates the number of days between the two dates
    func daysBetween(d1:Date, d2:Date) -> Int
    {
        //calculate the difference in seconds. To find dats divide by numver of seconds in a dsat (86400)
        //NSTimeInterval is just a Double
        let difference:TimeInterval = d1.timeIntervalSince(d2) / 86400
        
        // for now return 0
        return Int(difference.rounded())
    }
    
    func setStartDate(someStartDate:Date)
    {
        // save the start date
        startDate = someStartDate
        
        // create an object to format the date
        let dateFormat: DateFormatter = DateFormatter()
        
        // set the format example "MMMM d, yyyy hh:mm:ssa"
        dateFormat.dateFormat = "E MM/dd/yyyy"
        
        // another way to format. Styles include full, long, medium and short
        //        dateFormat.dateStyle = DateFormatter.Style.short
        //        dateFormat.timeStyle = DateFormatter.Style.short
        
        // display the date in the button
        btnStartDate.setTitle(dateFormat.string(from: startDate), for: UIControlState.normal)
        
        // display the days between dates
        lblDaysBetween.text = "Days Between: \(daysBetween(d1:endDate, d2:startDate))"
    }
    
    func setEndDate(someEndDate:Date)
    {
        // save the end date
        endDate = someEndDate
        
        // create an object to format the date
        let dateFormat: DateFormatter = DateFormatter()
        
        // set the format example "MMMM d, yyyy hh:mm:ssa"
        dateFormat.dateFormat = "E MM/dd/yyyy"
        
        // another way to format. Styles include full, long, medium and short
        //        dateFormat.dateStyle = DateFormatter.Style.short
        //        dateFormat.timeStyle = DateFormatter.Style.short
        
        // display the date in the button
        btnEndDate.setTitle(dateFormat.string(from: endDate), for: UIControlState.normal)
        
        // display the days between dates
        lblDaysBetween.text = "Days Between: \(daysBetween(d1:endDate, d2:startDate))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // exit method
    @IBAction func myUnwindAction(sender: UIStoryboardSegue)
    {
        
    }

}

