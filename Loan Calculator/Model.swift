
import Foundation
import CoreData
import UIKit

var user:[Feature]? = []
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


//clear


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
        return Double(yearPercent)/12/100//+
    }
    
    func allCalculation(monthPercent:Double, monthsAmount:Int) -> Double{
        return pow((1 + (monthPercent)),(Double(monthsAmount)))//+
    }
    
    func amountCalculation(monthlyPayment:Double, monthPercent:Double, all:Double) -> Double{
        return Double(monthlyPayment) / (monthPercent * all / (all - 1))
    }
    

    
    func paymentCalculation(monthlyPayment:Double, mortgageAmount:Double, monthsAmount:Int) -> Double{
        let payment = (monthlyPayment) * Double(monthsAmount)
        return (100 - (mortgageAmount / (payment) * 100))
    }
    
    func moonthlyPaymentCalculation(mortgageAmount:Double,monthPercent:Double,all:Double) -> Double{
        return (Double(mortgageAmount) * monthPercent * all / (all - 1))
    }
    
    
    func firstReturn(yearPercent:Double, monthlyPayment:Double, monthsAmount:Int) -> (Double, Double){
        
        monthPercent = monthPercentCalculation(yearPercent)
        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        amount = amountCalculation(monthlyPayment:monthlyPayment, monthPercent:monthPercent, all:all)
        payment = paymentCalculation(monthlyPayment: Double(monthlyPayment), mortgageAmount: amount, monthsAmount: monthsAmount)

        return (amount, payment)
    }
    
    func secondReturn(mortgageAmount:Double, monthlyPayment:Double, monthsAmount:Int) -> (Double, Double, Bool){

        let paymentMoney = Double(monthsAmount) * monthlyPayment
        var monthPercentTol = 0.01/100
        monthPercent = monthPercentTol
        let maxPercent = 10000.0/100
        
      

        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        var monthlyPaymentCalculated = moonthlyPaymentCalculation(mortgageAmount:Double(mortgageAmount),monthPercent:monthPercent,all:all)
        var ratio = monthlyPaymentCalculated / (monthlyPayment)

        print(ratio)


        var itNum = 0
        while (ratio < 0.999) || (ratio > 1.001){
                all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
                monthlyPaymentCalculated = moonthlyPaymentCalculation(mortgageAmount:Double(mortgageAmount),monthPercent:monthPercent,all:all)
                ratio = monthlyPaymentCalculated / (monthlyPayment)

                monthPercent += monthPercentTol

                if (ratio > 1.05){
                  
                    monthPercentTol = monthPercentTol / 2

                    monthPercent = monthPercentTol
                    itNum += 1

                        
                    
                    if itNum > 50{
                        break
                    }
                 }
            
            
                 
                
        }
        var success = false
        if itNum < 29{
            success = true
        } 
        let yearPercent = monthPercent*12*100

        return (yearPercent, paymentMoney, success)
    }


    
    
    
    func thirdReturn(mortgageAmount:Double, monthlyPayment:Double, yearPercent:Double) -> (Int, Int, Int, Double, Double){
        monthPercent = Double(monthPercentCalculation(yearPercent))
        monthsAmount = 1
        amount = Double(monthlyPayment)
        sumCalculated = Double(mortgageAmount)

        while sumCalculated > amount
        {
            sumCalculated = sumCalculated * (1 + monthPercent) - Double(monthlyPayment)
            monthsAmount += 1
        }
        let lastPayment = sumCalculated
        let paymentMoney = Double(monthlyPayment) * Double (monthsAmount - 1) + lastPayment

        months = monthsAmount % 12
        years = monthsAmount / 12
        
        payment = (100 - (Double(mortgageAmount)/Double(paymentMoney) * 100))
        
        return (monthsAmount, months, years, payment, paymentMoney)
    }
    
    
    func fourthReturn(mortgageAmount:Double, monthsAmount:Int, yearPercent:Double) -> (Double, Double){
        monthPercent = monthPercentCalculation(yearPercent)

        all = allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)

        monthlyPayment = moonthlyPaymentCalculation(mortgageAmount:mortgageAmount,monthPercent:monthPercent,all:all)
        payment = paymentCalculation(monthlyPayment:(monthlyPayment), mortgageAmount: Double(mortgageAmount), monthsAmount:monthsAmount)
        return (monthlyPayment, payment)
    }
    
    func saveData(mortgageAmount:Double, monthlyPayment:Double, yearPercent:Double, monthsAmount:Int){
   
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userToAdd = Feature(context: context)
        userToAdd.yearPercent = yearPercent
//        print(mortgageAmount)
//        print(Double(mortgageAmount))
        userToAdd.mortgageAmount = Double(mortgageAmount)
        userToAdd.monthlyPayment = Double(monthlyPayment)
        userToAdd.monthsAmount = Int16(monthsAmount)
        
        
        AppDelegate().saveContext()

    }
    
    func deleteData(){
        for userToDelete in user!{
            context.delete(userToDelete)
        }
        AppDelegate().saveContext()
    }
    
    
    func loadData( user:inout [Feature]?)->([Feature]?){
        do {
            user = try context.fetch(Feature.fetchRequest())
        }
        catch{
            
        }
        print(user ?? [])
        return(user)
        
        

    }
    
}





