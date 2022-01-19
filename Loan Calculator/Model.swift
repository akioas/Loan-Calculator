
import Foundation
import CoreData
import UIKit



class ReturnModel{
    
    var monthPercent = 0.0
    var all = 0.0
    var amount = 0.0
    var payment = 0.0
    var monthsAmount = 1
    var sumCalculated = 0.0
    var months = 0
    var years = 0
    var monthlyPayment = 0.0

    
    func monthPercentCalculation(_ yearPercent:Double) -> Double {
        return Double(yearPercent)/12/100
    }
    
    func allCalculation(monthPercent:Double, monthsAmount:Int) -> Double{
        return pow((1 + (monthPercent)),(Double(monthsAmount)))
    }
    
    func amountCalculation(monthlyPayment:Int, monthPercent:Double, all:Double) -> Double{
        return Double(monthlyPayment) / (monthPercent * all / (all - 1))
    }
    

    
    func paymentCalculation(amount:Double, monthlyPayment:Double, monthsAmount:Int) -> Double{
        return (-Double(amount) + Double(monthlyPayment) * Double (monthsAmount))/(Double(Double(monthlyPayment) * Double (monthsAmount))) * 100
    }
    
    func moonthlyPaymentCalculation(mortgageAmount:Int,monthPercent:Double,all:Double) -> Double{
        return (Double(mortgageAmount) * monthPercent * all / (all - 1))
    }
    
    
    func firstReturn(yearPercent:Double, monthlyPayment:Int, monthsAmount:Int) -> (Double, Double){
        
        monthPercent = monthPercentCalculation(yearPercent)
        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        amount = amountCalculation(monthlyPayment:monthlyPayment, monthPercent:monthPercent, all:all)
        payment = paymentCalculation(amount:amount, monthlyPayment:Double(monthlyPayment), monthsAmount:monthsAmount)

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
        
        payment = paymentCalculation(amount:amount, monthlyPayment:Double(monthlyPayment), monthsAmount:monthsAmount)
        
        return (monthsAmount, months, years, payment)
    }
    
    
    func fourthReturn(mortgageAmount:Int, monthsAmount:Int, yearPercent:Double) -> (Double, Double){
        monthPercent = monthPercentCalculation(yearPercent)

        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)

        monthlyPayment = moonthlyPaymentCalculation(mortgageAmount:mortgageAmount,monthPercent:monthPercent,all:all)
        payment = paymentCalculation(amount:amount, monthlyPayment:monthlyPayment, monthsAmount:monthsAmount)
        return (monthlyPayment, payment)
    }
    
    func saveData(mortgageAmount:Int, monthlyPayment:Int, yearPercent:Double, monthsAmount:Int){
        
           
                
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let user = Feature(context: context)
        user.yearPercent = yearPercent
        user.mortgageAmount = Double(mortgageAmount)
        user.monthlyPayment = Double(monthlyPayment)
        user.monthsAmount = Int16(monthsAmount)
        
        AppDelegate().saveContext()

    }
    
    
    
    
    func loadData()->(yearPercent:Double, mortgageAmount:Double, monthlyPayment:Double,  monthsAmount:Int){
        
            
                
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        var user:[Feature] = []
        
        do {
            user = try context.fetch(Feature.fetchRequest())
        }
        catch{
            
        }
        return(user.last!.yearPercent,
               user.last!.mortgageAmount,
               user.last!.monthlyPayment,
               Int(user.last!.monthsAmount))
        
        

    }
    
}





