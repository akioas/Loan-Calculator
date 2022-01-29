
import Foundation
import CoreData
import UIKit

var user:[Feature]? = []
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext





class ReturnModel{
    
    var monthPercent = 0.0
    var all = 0.0
    var amount = 0.0
    var paymentPercent = 0.0
    var monthsAmount = 1
    var sumCalculated = 0.0
    var months = 0
    var years = 0
    var monthlyPayment = 0.0
    var monthPercentTol = 0.01/100
    var paymentMoney = 0.0
    var ratio = 2.0
    
    let calculations = Calculations()
    
    
    func firstReturn(yearPercent:Double, monthlyPayment:Double, monthsAmount:Int) -> (Double, Double, Double){
        
        monthPercent = calculations.monthPercentCalculation(yearPercent)
        all = calculations.allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        amount = calculations.amountCalculation(monthlyPayment:monthlyPayment, monthPercent:monthPercent, all:all)
        paymentPercent = calculations.paymentPercentCalculation(monthlyPayment: (monthlyPayment), mortgageAmount: amount, monthsAmount: monthsAmount)
        paymentMoney = calculations.paymentMoneyCalculation(monthlyPayment: (monthlyPayment), monthsAmount: monthsAmount)
        
        return (amount, paymentPercent, paymentMoney)
    }
    
    func secondReturn(mortgageAmount:Double, monthlyPayment:Double, monthsAmount:Int) -> (Double, Double, Double, Bool){

       
        monthPercent = monthPercentTol


        all = calculations.allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
        var monthlyPaymentCalculated = calculations.moonthlyPaymentCalculation(mortgageAmount:Double(mortgageAmount),monthPercent:monthPercent,all:all)
        ratio = monthlyPaymentCalculated / (monthlyPayment)

        var itNum = 0
        while (ratio < 0.9999) || (ratio > 1.0001){
            all = calculations.allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)
            monthlyPaymentCalculated = calculations.moonthlyPaymentCalculation(mortgageAmount:Double(mortgageAmount),monthPercent:monthPercent,all:all)
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
        paymentPercent = calculations.paymentPercentCalculation(monthlyPayment: (monthlyPayment), mortgageAmount: amount, monthsAmount: monthsAmount)
        paymentMoney = calculations.paymentMoneyCalculation(monthlyPayment: (monthlyPayment), monthsAmount: monthsAmount)

        return (yearPercent, paymentMoney, paymentPercent, success)
    }


    
    
    
    func thirdReturn(mortgageAmount:Double, monthlyPayment:Double, yearPercent:Double) -> (Int, Int, Int, Double, Double){
        monthPercent = Double(calculations.monthPercentCalculation(yearPercent))
        monthsAmount = 1
        amount = Double(monthlyPayment)
        sumCalculated = Double(mortgageAmount)

        while sumCalculated > amount
        {
            sumCalculated = sumCalculated * (1 + monthPercent) - Double(monthlyPayment)
            monthsAmount += 1
        }
        
        paymentMoney = Double(monthlyPayment) * Double (monthsAmount - 1) + sumCalculated

        months = monthsAmount % 12
        years = monthsAmount / 12
        
        paymentPercent = (100 - (Double(mortgageAmount)/Double(paymentMoney) * 100))
        
        return (monthsAmount, months, years, paymentPercent, paymentMoney)
    }
    
    
    func fourthReturn(mortgageAmount:Double, monthsAmount:Int, yearPercent:Double) -> (Double, Double, Double){
        monthPercent = calculations.monthPercentCalculation(yearPercent)

        all = calculations.allCalculation(monthPercent:monthPercent, monthsAmount:monthsAmount)

        monthlyPayment = calculations.moonthlyPaymentCalculation(mortgageAmount:mortgageAmount,monthPercent:monthPercent,all:all)
        paymentPercent = calculations.paymentPercentCalculation(monthlyPayment: (monthlyPayment), mortgageAmount: amount, monthsAmount: monthsAmount)
        paymentMoney = calculations.paymentMoneyCalculation(monthlyPayment: (monthlyPayment), monthsAmount: monthsAmount)
        return (monthlyPayment, paymentPercent, paymentMoney)
    }
    
    
    
}





class Calculations {
    
    
    var payment = 0.0
    
    func monthPercentCalculation(_ yearPercent:Double) -> Double {
        return Double(yearPercent)/12/100
    }
    
    func allCalculation(monthPercent:Double, monthsAmount:Int) -> Double{
        return pow((1 + (monthPercent)),(Double(monthsAmount)))
    }
    
    func amountCalculation(monthlyPayment:Double, monthPercent:Double, all:Double) -> Double{
        return Double(monthlyPayment) / (monthPercent * all / (all - 1))
    }

    func paymentPercentCalculation(monthlyPayment:Double, mortgageAmount:Double, monthsAmount:Int) -> Double{
        payment = (monthlyPayment) * Double(monthsAmount)
        return (100 - (mortgageAmount / (payment) * 100))
    }
    
    func moonthlyPaymentCalculation(mortgageAmount:Double,monthPercent:Double,all:Double) -> Double{
        return (Double(mortgageAmount) * monthPercent * all / (all - 1))
    }
    
    func paymentMoneyCalculation(monthlyPayment:Double, monthsAmount:Int) -> Double{
        return (monthlyPayment) * Double (monthsAmount)
    }
}


class Data{
    
    let userToAdd = Feature(context: context)
    
    
    func saveData(mortgageAmount:Double, monthlyPayment:Double, yearPercent:Double, monthsAmount:Int){

        
        userToAdd.yearPercent = yearPercent

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
