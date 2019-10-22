// Project:		Final Project
// Class:		Programming 1 for iOS
// Date:        05/03/18
// Author:      Casey White
// Description:  
//Contact Parent class


import Foundation

class Contact : NSObject
{
    // properties
    var name:String
    var eMail:String
    var phone:String
    var address:Address
    
    //Contact type field
    var type:ContactType
  
    // type property
    public static var count:Int = 0
    
    //return the private count
    static func getCount()->Int
    {
        return count
    }
    
    //decrement the private count
    static func decrementCount()
    {
        count -= 1
    }
   
    init(name:String, eMail:String, phone:String, street:String, city:String, state:String, zip:String, type:ContactType) throws
    {
        self.name = name
        self.eMail = eMail
        self.phone = phone
        try self.address = Address(street: street, city: city, state: state, zip: zip)
        self.type = type
        
        // increment the type property
        Contact.count += 1
    }
    
    // description property returns string used in list
    override var description:String
    {
        return "\(name), \(eMail), \(phone), \(address), \(type)"
    }
    // nested class
    // class to represent a Address
    // add NSObject so we can override the description property
    class Address : NSObject
    {
        // properties
        var street:String
        var city:String
        var state:String
        var zip:String
        
        // initializers
        init(street:String, city:String, state:String, zip:String) throws
        {
            self.street = street
            self.city = city
            self.state = state
            self.zip = zip
        
            //truncate street to 10 characters
            if street.characters.count > 10
            {
                //find the 10th index
                let index1 = street.index(street.startIndex, offsetBy:10)
                
                //use the 10th index to substring the first 10 characters
                self.street = street.substring(to: index1)
            }
            else
            {
                self.street = street
            }
            
            //capitalize the first character
            self.city = city.capitalized
            
            //check for state exactly 2 characters and uppercase
            self.state = state.uppercased()
            if state.characters.count != 2
            {
                throw ContactError.invalidState
            }
            
            //chck for zip exactly 5 digits
            if let range = zip.range(of: "^\\d{5}$",
                options: .regularExpression)
            {
                self.zip = zip.substring(with: range)
            }
            else
            {
                throw ContactError.invalidZip
            }
        }
        
        // description property returns string used in list
        override var description : String
        {
            return "\(street), \(city), \(state), \(zip)"
        }
    }
    
    // enum for ContactType
    enum ContactType:String
    {
        case BUSINESS = "BUSINESS"
        case FAMILY = "FAMILY"
        case FRIEND = "FRIEND"
    }
}







