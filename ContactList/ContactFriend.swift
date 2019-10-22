// Project:		Final Project
// Class:		Programming 1 for iOS
// Date:        5/3/18
// Author:      Casey White
// Description: ContactFriends subClass

import Foundation

class ContactFriend: Contact
{
    var yearMet: String
    
    init(name:String, eMail:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, yearMet:String) throws
    {
        
        self.yearMet = yearMet
        
        try super.init(name: name, eMail: eMail, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
    }
    
    override var description: String
    {
        return "\(super.description), \(yearMet)"
    }
    
    
}
