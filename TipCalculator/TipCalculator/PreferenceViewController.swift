// Description: TipCalculator
// preferenceViewController saves users tip preferences using segue and default
import UIKit

class PreferenceViewController: UIViewController {
    
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var sldTip: UISlider!
    
    //function to update slider label for tip
    @IBAction func sldTip(_ sender: UISlider)
    {
        lblTip.text = String(format: "Tip: %1.f%%",
        sldTip.value)
    }
    
    @IBAction func btnSavePreference(_ sender: UIButton)
    {
        //save the tip preference with key lab5
        //get the standard default object
        let defaults = UserDefaults.standard
        
        //set the value for the key "lab5
        //use set beause there is an overloaded version wth float as first argument
        print("tip: \(sldTip.value)")
        defaults.set(sldTip.value, forKey: "lab5")
        
        //push the tip back to the first scene's slider
        (presentingViewController as! ViewController).sldTip.value =
        sldTip.value.rounded()

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
