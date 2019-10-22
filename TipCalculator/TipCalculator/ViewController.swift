
// Description:TipCalculator

import UIKit



class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfTip: UITextField!
    @IBOutlet weak var tfTotal: UITextField!
    @IBOutlet weak var lblSplit: UILabel!
    @IBOutlet weak var stpSplit: UIStepper!
    @IBOutlet weak var sldTip: UISlider!
    
    func calculateTip()
    {
        //declare amount and total local variables
        var total:Double = 0
        var tip:Double = 0
        let tipPercent:Double = Double(Int(sldTip.value.rounded()))
        
        //get the amount
        if let amount:Double = Double(tfAmount.text!)
        {
            // calculate the tip
            tip = amount * tipPercent / 100.0
            
            //calculate the total
            total = (amount + tip) / stpSplit.value
        }
        
        //display the total and tip in the textfiels
        tfTotal.text = String(format:"$%.2f", total)
        tfTip.text = String(format: "$%.2f (%1.f%%)", tip, sldTip.value)
    }
    
    @IBAction func sldTip(_ sender: UISlider)
    {
        calculateTip()
    }
    
    //value changed action
    @IBAction func stpSplit(_ sender: UIStepper)
    {
        //update the split label
        lblSplit.text = String(format: "%1.f", stpSplit.value)
        calculateTip()
    }
    
    @IBAction func tfAmountChanged(_ sender: UITextField)
    {
        calculateTip()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //get the standard default object
        let defaults = UserDefaults.standard
        
        //if ther is a Float tip preference for the key "lab5", addign it to the tip slider
        //if no preference set return 0, set default of 10
        let defaultTip = defaults.float(forKey: "lab5")
        if defaultTip == 0
        {
            //no preference, set slider and label to 10%
            sldTip.value = 10.0
            tfTip.text = String(format: "%.2f (%1.f%%)", 0.0,sldTip.value)
            print("no default")
        }
        else
        {
            //set slider and label to preference
            sldTip.value = defaultTip
            tfTip.text = String(format: "%.2f (%1.f%%)", 0.0, sldTip.value)
            print("default \(defaultTip)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

