import Foundation
import UIKit

var allowedCharacters = CharacterSet(charactersIn:"")
var characterSet = CharacterSet(charactersIn:"")


func textDigits(string:String) -> Bool{
    allowedCharacters = CharacterSet(charactersIn:"0123456789")
    characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
}
func textDigitsDot(string:String) -> Bool{
    allowedCharacters = CharacterSet(charactersIn:".0123456789")
    characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
}


var mortgageAmount = 0.0 // сумма кредита
var monthsAmount = 0 // количество месяцев
var monthPercent = 0.0 // процентная ставка
var yearPercent = 0.0
var monthlyPayment = 0.0 //оплата за месяц
var sum_r = 0.0

var paymentPercent = 0.0
var paymentMoney = 0.0
var months = 0
var years = 0



func methodText(_ num:Int) -> String{
    switch num {
    case 1:
        return "Расчет суммы кредита по % годовых, сроку кредита и ежемесячному платежу"
    case 2:
        return "Расчет суммы кредита по % годовых, сроку кредита и ежемесячному платежу"
    case 3:
        return "Расчет срока выплат по сумме кредита, % годовых и ежемесячному платежу"
    case 4:
        return "Расчет Ежемесячного платежа по сумме кредита, % годовых и сроку кредита"
    default:
        return "Неизвестный метод расчёта"
    }
}
