// Project:		Final Project
// Class:		Programming 1 for iOS
// Date:        5/3/18
// Author:      Casey White
// Description:  ContactFamily subClass

import Foundation

class ContactFamily: Contact
{
    var Relationship: String
    
    init(name:String, eMail:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType, relationship:String) throws
    {
        
        self.Relationship = relationship
        
       try super.init(name: name, eMail: eMail, phone: phone, street: street, city: city, state: state, zip: zip, type: type)
    }
    
    override var description: String
    {
        return "\(super.description), \(Relationship)"
    }
    
    
}
