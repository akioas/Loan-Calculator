
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    
    
    
    
    @IBOutlet weak var response: UILabel!
    @IBOutlet weak var response2: UILabel!
    @IBOutlet weak var method: UILabel!
    
    
    
    
    var mortgageAmount = 0.0 // сумма кредита
    var monthsAmount = 0 // количество месяцев
    var monthPercent = 0.0 // процентная ставка
    var yearPercent = 0.0
    var monthlyPayment = 0.0 //оплата за месяц
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
        text5.delegate = self

        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if textField == text3 || textField == text4 {
           return textDigits(string: string)
        }
        if textField == text1 || textField == text2 || textField == text5 {
            
            return textDigitsDot(string:string)
        }
        return true
    }
    
    
    @IBAction func sent1(_ sender: UITextField) {
        
        //removeNonDigits(sender)
        if let value = text1.text {
            mortgageAmount = Double(value) ?? 0.0
        }
    }
    
    @IBAction func sent2(_ sender: UITextField) {
       // removeNonDigits(sender)
        if let value = text2.text {
            yearPercent = Double(value) ?? 0.0
        }
        
    }
    
    @IBAction func sent3(_ sender: UITextField) {
      //  removeNonDigits(sender)
        if let value = text3.text {
            let yearsGet = Int(value) ?? 0
            monthsAmount = yearsGet * 12
        }
        
    }
    
    @IBAction func sent4(_ sender: UITextField) {
     //   removeNonDigits(sender)
        if let value = text4.text {
            let monthsGet = Int(value) ?? 0
            monthsAmount = monthsAmount + monthsGet
        }
        
    }
    
    
    @IBAction func sent5(_ sender: UITextField) {
      //  removeNonDigits(sender)
        if let value = text5.text {
            
            monthlyPayment = Double(value) ?? 0.0
            
        }
        
    }
    
    
    @IBAction func firstButton(_ sender: UIButton) {
        
            method.text = "Расчет суммы кредита по % годовых, сроку кредита и ежемесячному платежу"
            
            if !((yearPercent == 0) || (monthlyPayment == 0) || (monthsAmount == 0)){
                var paymentPercent = 0.0
                var paymentMoney = 0.0
                var sum_r = 0.0
                (sum_r, paymentPercent, paymentMoney) = ReturnModel().firstReturn(yearPercent: yearPercent, monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
                text1.text = String(format: "%.2f", sum_r)
                response.text = String(format: "%.2f", paymentPercent) + "%"
                response2.text = String(format: "%.2f", (paymentMoney))
                Data().saveData(mortgageAmount:(sum_r), monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
                print("SAVE")
                
                
            }
        
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        
            method.text = "Расчет суммы кредита по % годовых, сроку кредита и ежемесячному платежу"
            
            if !((mortgageAmount == 0) || (monthlyPayment == 0) || (monthsAmount == 0)){
                var yearPercent = 0.0
                var paymentPercent = 0.0
                var paymentMoney = 0.0
                var responseText = true
                (yearPercent, paymentPercent, paymentMoney, responseText) = ReturnModel().secondReturn(mortgageAmount: Double(mortgageAmount), monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
                text2.text = String(format: "%.2f", yearPercent)
                response.text = String(format: "%.2f", paymentPercent) + "%"
                response2.text = String(format: "%.2f", (paymentMoney))
                if responseText == false {
                    method.text = "Невозможно рассчитать"
                }
                Data().saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
                print("SAVE")
                
                
            }
        
    }
    
    
    
    @IBAction func thirdButton(_ sender: UIButton) {
        
            if !((monthlyPayment == 0) || (mortgageAmount == 0) || (yearPercent == 0)){
                var years = 0
                var months = 0
                var paymentPercent = 0.0
                var paymentMoney = 0.0
                
                (monthsAmount, months, years, paymentPercent, paymentMoney) = ReturnModel().thirdReturn(mortgageAmount: mortgageAmount, monthlyPayment: monthlyPayment,yearPercent:yearPercent)
                method.text = "Расчет срока выплат по сумме кредита, % годовых и ежемесячному платежу"
                text3.text = String(years)
                text4.text = String(months)
                response.text = String(format: "%.2f", paymentPercent) + "%"
                response2.text = String(format: "%.2f", (paymentMoney))
                Data().saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
            }
    }
     
    @IBAction func fourthButton(_ sender: UIButton) {
        
            
            if !((yearPercent == 0) || (mortgageAmount == 0) || (monthsAmount == 0)){
                var monthlyPayment = 0.0
                var paymentPercent = 0.0
                var paymentMoney = 0.0
                
                (monthlyPayment, paymentPercent, paymentMoney) = ReturnModel().fourthReturn(mortgageAmount: mortgageAmount, monthsAmount: monthsAmount, yearPercent: yearPercent)
                text5.text = String(format: "%.2f", monthlyPayment)
                method.text = "Расчет Ежемесячного платежа по сумме кредита, % годовых и сроку кредита"
                
                response.text = String(format: "%.2f", paymentPercent) + "%"
                response2.text = String(format: "%.2f", paymentMoney)
                
                Data().saveData(mortgageAmount:mortgageAmount, monthlyPayment:monthlyPayment, yearPercent:yearPercent, monthsAmount:monthsAmount)
            }
            
            
        }
    
}




class SecViewController: UIViewController {
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var text3: UILabel!
    
    @IBOutlet weak var text4: UILabel!
    
    var index = -3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData(index: &index)
        }
    
    
    //yearPercent:Double, mortgageAmount:Double, monthlyPayment:Double,  monthsAmount:Int
    @IBAction func pressPrevious(_ sender: UIButton) {
        index -= 1
        showData(index: &index)
   }
    
    @IBAction func pressNext(_ sender: UIButton) {
        index += 1
        showData(index: &index)
   }
    
    @IBAction func closeButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
   }
    @IBAction func deleteButton(_ sender: UIButton){
        Data().deleteData()
        index = -3
        showData(index: &index)
   }
    
    
    
    func showData(index:inout Int){
        let history = Data().loadData(user:&user)
        print(index)
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
            
            print(index)
            
            text1.text = "% годовых: " + String(history![index].yearPercent)
            text2.text = "Сумма кредита: " + String(history![index].mortgageAmount)
            text3.text = "Ежемесячный платеж: " + String(history![index].monthlyPayment)
            text4.text = "Количество месяцев: " + String(history![index].monthsAmount)
        } else {
            text1.text = "% годовых: "
            text2.text = "Сумма кредита: "
            text3.text = "Ежемесячный платеж: "
            text4.text = "Количество месяцев: "
        }
    }
        
    
    
}
