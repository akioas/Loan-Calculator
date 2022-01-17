
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    

    @IBOutlet weak var switch1: UISwitch!
    

    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    
    @IBOutlet weak var response: UILabel!
    @IBOutlet weak var response2: UILabel!
    @IBOutlet weak var method: UILabel!
    
    
    
    
    var mortgageAmount = 0 // сумма кредита
    var monthsAmount = 0 // количество месяцев
    var monthPercent = 0.0 // процентная ставка
    var yearPercent = 0.0
    var monthlyPayment = 0 //оплата за месяц
    
    
    
    @IBAction func sent1(_ sender: UITextField) {
        
        removeNonDigits(sender)
        if let value = text1.text {
            mortgageAmount = Int(value) ?? 0
        }
    }
    
    @IBAction func sent2(_ sender: UITextField) {
        removeNonDigits(sender)
            if let value = text2.text {
                yearPercent = Double(value) ?? 0
            }
        
    }
    
    @IBAction func sent3(_ sender: UITextField) {
        removeNonDigits(sender)
            if let value = text3.text {
                let yearsGet = Int(value) ?? 0
                monthsAmount = yearsGet * 12
            }
        
    }
    
    @IBAction func sent4(_ sender: UITextField) {
        removeNonDigits(sender)
            if let value = text4.text {
                let monthsGet = Int(value) ?? 0
                monthsAmount = monthsAmount + monthsGet
            }
        
    }
    
    
    @IBAction func sent5(_ sender: UITextField) {
        removeNonDigits(sender)
            if let value = text5.text {
//                nLabel.text = value
                monthlyPayment = Int(value) ?? 0
                
            }
        
    }
    
    
    @IBAction func firstSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
//            switch2.setOn(false, animated: true)
            switch3.setOn(false, animated: true)
            switch4.setOn(false, animated: true)
            method.text = "Расчет суммы кредита по % годовых, сроку кредита и ежемесячному платежу"
            
            //print(sum)
            if (yearPercent == 0) || (monthlyPayment == 0) || (monthsAmount == 0){

                text1.text = "Ошибка"
            }
            else {
                var payment = 0.0
                var sum_r = 0.0
                (sum_r, payment) = ReturnModel().firstReturn(yearPercent: yearPercent, monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
                text1.text = String(format: "%.2f", sum_r)
                response.text = String(format: "%.2f", payment) + "%"
                response2.text = String(format: "%.2f", (Double(monthlyPayment) * Double (monthsAmount)))
            }
        }
        
        
    }

    @IBAction func thirdSwitch(_ sender: UISwitch) {
        if sender.isOn == true {

            switch1.setOn(false, animated: true)
            switch4.setOn(false, animated: true)
            if (monthlyPayment == 0) || (mortgageAmount == 0) || (yearPercent == 0){
                text4.text = "Ошибка"
                text3.text = "Ошибка"
            }
            else
            {
                var years = 0
                var months = 0
                var payment = 0.0
                method.text = "Расчет срока выплат по сумме кредита, % годовых и ежемесячному платежу"
                (monthsAmount, months, years, payment) = ReturnModel().thirdReturn(mortgageAmount: mortgageAmount, monthlyPayment: monthlyPayment,yearPercent:yearPercent)
                text3.text = String(years)
                text4.text = String(months)
                response.text = String(format: "%.2f", payment) + "%"
                response2.text = String(format: "%.2f", (Double(monthlyPayment) * Double (monthsAmount)))
                
            }
        }
    }
    @IBAction func fourthSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
//            switch2.setOn(false, animated: true)
            switch3.setOn(false, animated: true)
            switch1.setOn(false, animated: true)
            
            if (yearPercent == 0) || (mortgageAmount == 0) || (monthsAmount == 0){
                text5.text = "Ошибка"
            }
            else {
                var monthlyPayment = 0
                var payment = 0.0
                
                (monthsAmount, payment) = ReturnModel().fourthReturn(mortgageAmount: mortgageAmount, monthsAmount: monthsAmount, yearPercent: yearPercent)
                text5.text = String(format: "%.2f", monthlyPayment)
                method.text = "Расчет Ежемесячного платежа по сумме кредита, % годовых и сроку кредита"
                
                response.text = String(format: "%.2f", payment) + "%"
                response2.text = String(format: "%.2f", (Double(monthlyPayment) * Double (monthsAmount)))
                
            }
            
            
            
        }
    }
}


