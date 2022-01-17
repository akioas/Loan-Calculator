
import Foundation



class ReturnModel{
    
    var part = 0.0
    var all = 0.0
    var amount = 0.0
    var payment = 0.0
    
    func partCalculation(_ monthPercent:Double) -> Double {
        return Double(monthPercent)/12/100
    }
    
    func allCalculation(part:Double, monthsAmount:Int) -> Double{
        return pow((1 + (part)),(Double(monthsAmount)))
    }
    
    func amountCalculation(monthlyPayment:Int, part:Double, all:Double) -> Double{
        return Double(monthlyPayment) / (part * all / (all - 1))
    }
    
    func paymentCalculation(amount:Double, monthlyPayment:Int, monthsAmount:Int) -> Double{
        return (-Double(amount) + Double(monthlyPayment) * Double (monthsAmount))/(Double(Double(monthlyPayment) * Double (monthsAmount))) * 100
    }
    
    
    
    func firstReturn(monthPercent:Double, monthlyPayment:Int, monthsAmount:Int) -> (Double, Double){
        
        part = partCalculation(monthPercent)
        all = allCalculation(part:part, monthsAmount:monthsAmount)
        amount = amountCalculation(monthlyPayment:monthlyPayment, part:part, all:all)
        payment = paymentCalculation(amount:amount, monthlyPayment:monthlyPayment, monthsAmount:monthsAmount)

        return (amount, payment)
    }

}



