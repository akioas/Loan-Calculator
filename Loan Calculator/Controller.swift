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
var success = true






func historyText(user:inout [Feature]?, index:inout Int) -> (String, String, String, String){
    let history = loadData(user:&user)
    print(history!)
   
    if !(history!.isEmpty){
        if index >= history!.count{
            index = history!.count - 1
        }
        if index == -3{
            index = history!.count - 1
        }
        if index < 0{
            index = 0
        }
  
        return ("% годовых: " + String(history![index].yearPercent),
        "Сумма кредита: " + String(history![index].mortgageAmount),
        "Ежемесячный платеж: " + String(history![index].monthlyPayment),
        "Количество месяцев: " + String(history![index].monthsAmount))
    } else {
        return ("% годовых",
        "Сумма кредита",
        "Ежемесячный платеж",
        "Количество месяцев")
    }
}
class Responses{
    var calcMethod = ""
    var calculated = ""
    var response = ""
    var secondResponse = ""
    var monthsAnswer = ""


    func firstMethod(yearPercent: Double, monthlyPayment: Double, monthsAmount: Int) -> (String, String, String, String){
        (sum_r, paymentPercent, paymentMoney, success) = ReturnModel().firstReturn(yearPercent: yearPercent, monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
        calculated = String(format: "%.2f", sum_r)
        response = String(format: "%.2f", paymentPercent) + "%"
        secondResponse = String(format: "%.2f", (paymentMoney))
        
        if success {
            calcMethod = methodText(1)
        } else {
            calcMethod = "Невозможно рассчитать"
        }
        saveData(mortgageAmount:(sum_r), monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
        return (calculated, response, secondResponse, calcMethod)
    }

    func secondMethod(mortgageAmount: Double, monthlyPayment: Double, monthsAmount: Int) -> (String, String, String, String){
        (yearPercent, paymentPercent, paymentMoney, success) = ReturnModel().secondReturn(mortgageAmount: Double(mortgageAmount), monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
        calculated = String(format: "%.2f", yearPercent)
        response = String(format: "%.2f", paymentPercent) + "%"
        secondResponse = String(format: "%.2f", (paymentMoney))
        
        if success {
            calcMethod = methodText(2)
        } else {
            calcMethod = "Невозможно рассчитать"
        }
        saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
        return (calculated, response, secondResponse, calcMethod)
    }


    func thirdMethod(mortgageAmount: Double, monthlyPayment: Double,yearPercent:Double) -> (String, String, String, String, String){
        (monthsAmount, months, years, paymentPercent, paymentMoney, success) = ReturnModel().thirdReturn(mortgageAmount: mortgageAmount, monthlyPayment: monthlyPayment,yearPercent:yearPercent)
        calculated = String(years)
        monthsAnswer = String(months)
        response = String(format: "%.2f", paymentPercent) + "%"
        secondResponse = String(format: "%.2f", (paymentMoney))

        if success {
            calcMethod = methodText(3)
        } else {
            calcMethod = "Невозможно рассчитать"
        }
        saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
        return (calculated, monthsAnswer, response, secondResponse, calcMethod)
        
    }



    func fourthMethod(mortgageAmount: Double, monthsAmount: Int, yearPercent: Double) -> (String, String, String, String){
        
        (monthlyPayment, paymentPercent, paymentMoney, success) = ReturnModel().fourthReturn(mortgageAmount: mortgageAmount, monthsAmount: monthsAmount, yearPercent: yearPercent)
        calculated = String(format: "%.2f", monthlyPayment)
        response = String(format: "%.2f", paymentPercent) + "%"
        secondResponse = String(format: "%.2f", (paymentMoney))
        
        if success {
            calcMethod = methodText(4)
        } else {
            calcMethod = "Невозможно рассчитать"
        }
        saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
        return (calculated, response, secondResponse, calcMethod)
    }

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
}
