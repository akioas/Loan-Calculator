
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
        
     
        if let value = text1.text {
            mortgageAmount = Double(value) ?? 0.0
        }
    }
    
    @IBAction func sent2(_ sender: UITextField) {
   
        if let value = text2.text {
            yearPercent = Double(value) ?? 0.0
        }
        
    }
    
    @IBAction func sent3(_ sender: UITextField) {
      
        if let value = text3.text {
            let yearsGet = Int(value) ?? 0
            monthsAmount = yearsGet * 12
        }
        
    }
    
    @IBAction func sent4(_ sender: UITextField) {
   
        if let value = text4.text {
            let monthsGet = Int(value) ?? 0
            monthsAmount = monthsAmount + monthsGet
        }
        
    }
    
    
    @IBAction func sent5(_ sender: UITextField) {
     
        if let value = text5.text {
            
            monthlyPayment = Double(value) ?? 0.0
            
        }
        
    }
    
    var calculatedText = ""
    var monthsText = ""
    var responseText = ""
    var secondResponseText = ""
    var calcMethodText = ""
    
    @IBAction func firstButton(_ sender: UIButton) {
        
            
            
            if !((yearPercent == 0) || (monthlyPayment == 0) || (monthsAmount == 0)){
                
                
                (calculatedText, responseText, secondResponseText, calcMethodText) = Responses().firstMethod(yearPercent: yearPercent, monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
                method.text = calcMethodText
                text1.text = calculatedText
                response.text = responseText
                response2.text = secondResponseText
                
              
                
                
            }
        
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        
            
            
            if !((mortgageAmount == 0) || (monthlyPayment == 0) || (monthsAmount == 0)){
               
               (calculatedText, responseText, secondResponseText, calcMethodText) = Responses().secondMethod(mortgageAmount: Double(mortgageAmount), monthlyPayment: monthlyPayment, monthsAmount: monthsAmount)
               method.text = calcMethodText
               text2.text = calculatedText
               response.text = responseText
               response2.text = secondResponseText
  
                
            }
        
    }
    
    
    
    @IBAction func thirdButton(_ sender: UIButton) {
        
            if !((monthlyPayment == 0) || (mortgageAmount == 0) || (yearPercent == 0)){
  
  (calculatedText, monthsText, responseText, secondResponseText, calcMethodText) = Responses().thirdMethod(mortgageAmount: mortgageAmount, monthlyPayment: monthlyPayment,yearPercent:yearPercent)
  method.text = calcMethodText
  text3.text = calculatedText
  text4.text = monthsText
  response.text = responseText
  response2.text = secondResponseText
            }
    }
     
    @IBAction func fourthButton(_ sender: UIButton) {
        
            
            if !((yearPercent == 0) || (mortgageAmount == 0) || (monthsAmount == 0)){
                
                
                (calculatedText, responseText, secondResponseText, calcMethodText) = Responses().fourthMethod(mortgageAmount: mortgageAmount, monthsAmount: monthsAmount, yearPercent: yearPercent)
                method.text = calcMethodText
                text5.text = calculatedText
                response.text = responseText
                response2.text = secondResponseText
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
        deleteData()
        index = -3
        showData(index: &index)
   }
    
    
    var historyPercent = ""
    var historySum = ""
    var historyMonthlyPayment = ""
    var historyMonthsAmount = ""
    func showData(index:inout Int){
        
        
        (historyPercent, historySum, historyMonthlyPayment, historyMonthsAmount) = historyText(user:&user, index:&index)
        
        text1.text = historyPercent
        text2.text = historySum
        text3.text = historyMonthlyPayment
        text4.text = historyMonthsAmount
        
        
    }
        
    
    
}
