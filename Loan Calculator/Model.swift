
import Foundation



class ReturnModel{
    
    var monthPercent = 0.0
    var all = 0.0
    var amount = 0.0
    var payment = 0.0
    var monthsAmount = 1
    var sumCalculated = 0.0
    var months = 0
    var years = 0
    var monthlyPayment = 0

    
    func monthPercentCalculation(_ yearPercent:Double) -> Double {
        return Double(yearPercent)/12/100
    }
    
    func allCalculation(monthPercent:Double, monthsAmount:Int) -> Double{
        return pow((1 + (monthPercent)),(Double(monthsAmount)))
    }
    
    func amountCalculation(monthlyPayment:Int, monthPercent:Double, all:Double) -> Double{
        return Double(monthlyPayment) / (monthPercent * all / (all - 1))
    }
    

    
    func paymentCalculation(amount:Double, monthlyPayment:Int, monthsAmount:Int) -> Double{
        return (-Double(amount) + Double(monthlyPayment) * Double (monthsAmount))/(Double(Double(monthlyPayment) * Double (monthsAmount))) * 100
    }
    
    func moonthlyPaymentCalculation(mortgageAmount:Int,monthPercent:Double,all:Double) -> Int{
        return Int(Double(mortgageAmount) * monthPercent * all / (all - 1))
    }
    
    
    func firstReturn(yearPercent:Double, monthlyPayment:Int, monthsAmount:Int) -> (Double, Double){
        
        monthPercent = monthPercentCalculation(yearPercent)
        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        amount = amountCalculation(monthlyPayment:monthlyPayment, monthPercent:monthPercent, all:all)
        payment = paymentCalculation(amount:amount, monthlyPayment:monthlyPayment, monthsAmount:monthsAmount)

        return (amount, payment)
    }

    
    
    
    func thirdReturn(mortgageAmount:Int, monthlyPayment:Int, yearPercent:Double) -> (Int, Int, Int, Double){
        monthPercent = monthPercentCalculation(yearPercent)
        monthsAmount = 1
        amount = 0.0
        sumCalculated = Double(mortgageAmount)

        while sumCalculated > amount
        {
            amount = amount + Double(monthlyPayment) * Double((100 - monthPercent))/100
            monthsAmount += 1
        }

        months = monthsAmount % 12
        years = monthsAmount / 12
        
        payment = paymentCalculation(amount:amount, monthlyPayment:monthlyPayment, monthsAmount:monthsAmount)
        
        return (monthsAmount, months, years, payment)
    }
    
    
    func fourthReturn(mortgageAmount:Int, monthsAmount:Int, yearPercent:Double) -> (Int, Double){
        monthPercent = monthPercentCalculation(yearPercent)

        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)

        monthlyPayment = moonthlyPaymentCalculation(mortgageAmount:mortgageAmount,monthPercent:monthPercent,all:all)
        payment = paymentCalculation(amount:amount, monthlyPayment:monthlyPayment, monthsAmount:monthsAmount)
        return (monthlyPayment, payment)
    }
    
    
    
}








