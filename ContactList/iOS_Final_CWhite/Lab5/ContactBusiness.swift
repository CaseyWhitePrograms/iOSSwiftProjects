// Project:		Final Project
// Class:		Programming 1 for iOS
// Date:        5/3/18
// Author:      Casey White
// Description: ContactBusiness subClass


import Foundation

class ContactBusiness: Contact
{
    var Company: String
    
    init(name:String, eMail:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, company:String) throws
    {
        
        self.Company = company
        
       try super.init(name: name, eMail: eMail, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
    }
    
override var description: String
    {
        return "\(super.description), \(Company)"
    }
    
    
}
