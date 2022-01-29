import Foundation
import UIKit



func textDigits(string:String) -> Bool{
    let allowedCharacters = CharacterSet(charactersIn:"0123456789")
    let characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
}
func textDigitsDot(string:String) -> Bool{
    let allowedCharacters = CharacterSet(charactersIn:".0123456789")
    let characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
}
