// Project:		Final Project
// Class:		Programming 1 for iOS
// Date:        5/03/18
// Author:      Casey White




import Cocoa


class ViewController: NSViewController, NSTableViewDataSource,NSTableViewDelegate
{
    @IBOutlet weak var tfName: NSTextField!
    @IBOutlet weak var tfPhone: NSTextField!
    @IBOutlet weak var tfEmail: NSTextField!
    @IBOutlet weak var tfStreet: NSTextField!
    @IBOutlet weak var tfCity: NSTextField!
    @IBOutlet weak var tfState: NSTextField!
    @IBOutlet weak var tfZip: NSTextField!
    @IBOutlet weak var lblCount: NSTextField!
    @IBOutlet weak var tvContacts: NSTableView!
    @IBOutlet weak var tfDependent: NSTextField!
    @IBOutlet weak var lblDependent: NSTextField!
    @IBOutlet weak var puContactType: NSPopUpButtonCell!
    

    @IBAction func btnLoad(_ sender: Any)
    {
//    5)
//    Enhance the application by having it remove any existing contacts before loading the contacts from the file.
//    Make sure the count is correct.
        contacts.removeAll()
        //update the tableView
        tvContacts.reloadData()
        //adjust count
        Contact.count = 0
        
        //create the openPanel
        let openPanel = NSOpenPanel()
        
        //display the openPanel and get result
        openPanel.runModal()
        
        //create reference to contact object
        var contact:Contact? = nil
        
        //read the file
        do
        {
         //read the contents of the file into a string
            let textFile = try String(contentsOf: openPanel.url!, encoding: String.Encoding.utf8)
            
            //separate the string into array by \n
            let lines = textFile.components(separatedBy: "\n")
            print("Lines: \(lines.count)")
            
            //get each line and split it into its fields which are seperated by commas
            for line in lines
            {
                //fix for reading Java file. Java file has \n after last line
                if line.characters.count < 1
                {
                    break
                }
                let fields = line.components(separatedBy: ",")
                
                //get the type of contact object from field 7 and create enum ContactType
                let type:Contact.ContactType = Contact.ContactType(rawValue: fields[7].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
                
                //use switch to create the appropriate object
                switch type
                {
                case Contact.ContactType.BUSINESS:
                    try contact = ContactBusiness(name: fields[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                       eMail: fields[1],
                       phone: fields [2],
                       street: fields [3],
                       city: fields[4],
                       state: fields[5],
                       zip: fields[6],
                       type: type,
                       company: fields[8])
                    
                    //use description func and add to contacts array
                    contacts.append((contact?.description)!)
                    //add to the contact array
                    contactObjects.append(contact!)
                    
                case Contact.ContactType.FAMILY:
                    try contact = ContactFamily(name: fields[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                        eMail: fields[1],
                        phone: fields [2],
                        street: fields [3],
                        city: fields[4],
                        state: fields[5],
                        zip: fields[6],
                        type: type,
                        relationship: fields[8])
                    
                    //use description func and add to contacts array
                    contacts.append((contact?.description)!)
                    //add to the contact array
                    contactObjects.append(contact!)
                    
                case Contact.ContactType.FRIEND:
                    try contact = ContactFriend(name: fields[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                        eMail: fields[1],
                        phone: fields [2],
                        street: fields [3],
                        city: fields[4],
                        state: fields[5],
                        zip: fields[6],
                        type: type,
                        yearMet: fields[8])
                    
                    //use description func and add to contacts array
                    contacts.append((contact?.description)!)
                    //add to the contact array
                    contactObjects.append(contact!)
                
                default:
                    break
                }
            }// end for
        }
        catch
        {
            print(error)
        }
        // get the current count from the Contact class and display it in the label
        lblCount.stringValue = "Count: \(Contact.getCount())"
        
        // reload the table
        tvContacts.reloadData()
        
    }
   
    @IBAction func btnSave(_ sender: Any)
    {
        //create the savePanel
        let savePanel = NSSavePanel()
        
        //display the savePanel and get result
        savePanel.runModal()
        
        //writing
        do
        {
            //reduce array of contacts from the table to one string
            let joinedString = contacts.joined(separator: "\n")
            
            // relplace all ", " with ","
            let joinedStringNoSpaces = joinedString.replacingOccurrences(of: ", ", with: ",")
            
            //write joined string to file
            try joinedStringNoSpaces.write(to: savePanel.url!, atomically: false, encoding: String.Encoding.utf8)
        }
        catch
        {
        /* error handling here */
        print (error)
        }
    }
    @IBAction func btnDelete(_ sender: Any)
    {
        //Question 7 function
        deleteContact();
    }
    
    // array to hold Strings in tableView
    var contacts:[String] = []
    
    // array of Contact objects
    var contactObjects:[Contact] = []
    
    @IBAction func puContactType(_ sender: Any)
    
    {
        switch(puContactType.indexOfSelectedItem)
        {
        case 0:
            lblDependent.stringValue = "Company"
        case 1:
            lblDependent.stringValue = "Relationship"
        case 2:
            lblDependent.stringValue = "Year Met"
        default:
            lblDependent.stringValue = "Company"
        }
        tfDependent.stringValue = ""
    }


    @IBAction func btnExit(_ sender: NSButton)
    {
        NSApplication.shared().terminate(self)
    }
    
    @IBAction func btnAdd(_ sender: NSButton)
    {
        //Question 6 functions
        addContact();
        clearTextFields();
        sortContacts();
    }
    
    
    //     TableView
    //     change content mode on tableView to cell based
    //     set columns to 1
    //     uncheck headers
    //     set the cell identifier: select the table column, identity
    //     inspector,change identity property
    //     returns the string for the row and column
    func tableView(_ tableView: NSTableView,
                   objectValueFor tableColumn: NSTableColumn?,
                   row: Int) -> Any?
    {
        
    //   print("column: \(tableColumn!.identifier)row: \(row)")
        return contacts[row]
    }
    
    // returns the number of rows in the tableView
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return contacts.count
    }
    
//  9.)
//Modify the “tableViewSelectionDidChange” function . This delegate handles selections in the table. When an item is selected, write code to load it into the textFields. Hint: Use the same type logic as in the load, separate the string into fields delimited by commas.
//Remember to trim any white space.
    
    // called when the user selects an item in the table
    // you should always get the data from the tables data source
    func tableViewSelectionDidChange(_ notification: Notification)
    {
     
        // get the selected row
        let row = tvContacts.selectedRow
        
        
        // get the string from the array at row
        // user can select nothing in the list which returns -1
        if row >= 0 && row < contacts.count
        {
            print("Selected row \(row): \(contacts[row])")
        }
    }
//   3.) Write a function named clearTextFields() that clears all the textFields. Add a Clear button and Action that calls the clearTextFields() function. Do not clear the table.
     func clearTextFields()
     {
        tfName.stringValue = ""
        tfPhone.stringValue = ""
        tfZip.stringValue = ""
        tfCity.stringValue = ""
        tfEmail.stringValue = ""
        tfState.stringValue = ""
        tfStreet.stringValue = ""
        tfDependent.stringValue = ""
    }
    //Action for btnClear question #3
    @IBAction func btnClear(_ sender: Any)
    {
        clearTextFields();
    }
//I wasnt sure if you wanted the sort button deleted from the UI, since the action is included in the btnAdd actionPerformed. It didnt specify in the Project document, so I didnt take it off.
    @IBAction func btnSort(_ sender: Any)
    {
        sortContacts();
    }
//4.)
//    Write a function named sortContacts(). Move all the code from the btnSort action into the function. Call the sortContacts()method from the sort button action.
    func sortContacts()
    {
        //sort the array
        contactObjects.sort(by:
            {
                contact1, contact2 in
                contact1.name < contact2.name
        })
        
        //rebuild the array of strings for the table
        //remove all the old unsorted strings
        contacts.removeAll()
        for c1 in contactObjects
        {
            contacts.append(c1.description)
        }
        //update the tableView
        tvContacts.reloadData()
        
    }

//6.)
//    Modify adding a contact so that all txtFields are cleared and the contacts are sorted after adding.
//    Create a function named addContact(). Move the code from the btnAdd action to the new function.
//    Call the addContact(), clearTextFields()  and sortContacts() functions from btnAdd action.
    func addContact()
    {
        // declare a ContactType variable
        var conObj: Contact? = nil
        
        do{
            // switch statement to determine which type is selected
            // indexes start at 0
            switch(puContactType.indexOfSelectedItem)
            {
            case 0:
                //create a ContactBusiness object
                try conObj = ContactBusiness (name: tfName.stringValue, eMail: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.BUSINESS, company: tfDependent.stringValue)
            case 1:
                //create a ContactFamily object
                try conObj = ContactFamily (name: tfName.stringValue, eMail: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.FAMILY, relationship: tfDependent.stringValue)
            case 2:
                //create a ContactFriend object
                try conObj = ContactFriend (name: tfName.stringValue, eMail: tfEmail.stringValue, phone: tfPhone.stringValue, street: tfStreet.stringValue, city: tfCity.stringValue, state: tfState.stringValue, zip: tfZip.stringValue, type: Contact.ContactType.FRIEND, yearMet: tfDependent.stringValue)
            default:
                conObj = nil
            }
            
            //add conact object to array.
            contactObjects.append(conObj!)
            
            // get the current count from the Contact class and display it in the label
            lblCount.stringValue = "Count: \(Contact.getCount())"
            
            // add the contact to the array
            contacts.append((conObj?.description)!)
            
            // update the tableView
            tvContacts.reloadData()
            
            clearTextFields();
            // Final exam question 4 function
            sortContacts();
        }
        catch ContactError.invalidState
        {
            //create an Alert to display error
            let myPopup: NSAlert = NSAlert()
            //set the title
            myPopup.messageText = "Contact Creation Error"
            //set the messafe
            myPopup.informativeText = "Invalid State"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            
            myPopup.runModal()
        }
        catch ContactError.invalidZip
        {
            //create an Alert to display error
            let myPopup: NSAlert = NSAlert()
            //set the title
            myPopup.messageText = "Contact Creation Error"
            //set the message
            myPopup.informativeText = "Invalid Zip"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
        catch
        {
            let myPopup: NSAlert = NSAlert()
            myPopup.messageText = "Contact Creation Error"
            myPopup.informativeText = "Unknown Error"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
    }
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()
        
      
        // Tell the TableView what class is handling the source and delegate
        tvContacts.dataSource = self
        tvContacts.delegate = self
    }
    
    override var representedObject: Any?
    {
        didSet
        {
            // Update the view, if already loaded.
        }
    }
//    7.)
//    Create function named deleteContact().
//    Move the code from btnDelete action to deleteContact().
//    Call deleteContact() from btnDelete action.
    func deleteContact()
    {
        //get the selected row
        let selectedRow = tvContacts.selectedRow
        
        //if nothing is selected display error message, -1 if no row is selected
        if selectedRow < 0
        {
            //create an Alert to display error
            let myPopup: NSAlert = NSAlert()
            // set the title
            myPopup.messageText = "Deletion Error"
            //set the message
            myPopup.informativeText = "Nothing Selected in Table"
            myPopup.alertStyle = NSAlertStyle.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.runModal()
        }
        else
        {
            // get the selected string in the table using table selected row and the contact array
            let selectedString = self.contacts[selectedRow]
            
            // separate the selected string into individual strings using , as delimiter
            let selectedArray = selectedString.components(separatedBy: ",")
            
            // get the name which is in position 0
            let name = selectedArray[0]
            print("name: \(name)")
            
            // remove the contact from the array contactObjects
            contactObjects.remove(at: selectedRow)
            
            // remove the string from the array contact
            contacts.remove(at: selectedRow)
            
            // decrement the count
            Contact.decrementCount()
            
            // get the current count from the Contact class and display it in the label
            lblCount.stringValue = "Count: \(Contact.getCount())"
            
            // reload the table
            tvContacts.reloadData()
        }
    }
//    8.)
//    Add an Update button. In its btnUpdate action.
//    Call deleteContact()
//    Call addContact()
//    Call clearTextFields()
    @IBAction func btnUpdate(_ sender: Any)
    {
        deleteContact();
        addContact();
        clearTextFields();
    }

}

