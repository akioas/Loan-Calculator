import Foundation
import UIKit


func removeNonDigits(_ sender: UITextField){
    if let last = sender.text?.last {
        let zero: Character = "0"
        let num: Int = Int(UnicodeScalar(String(last))!.value - UnicodeScalar(String(zero))!.value)
        if (num < 0 || num > 9) {
            sender.text?.removeLast()
            
        }
        
    }
}
