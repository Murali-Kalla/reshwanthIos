//
//  ViewController.swift
//  Kalla_Calculator
//
//  Created by Kalla,Muralidhar Reddy on 2/17/22.
//

import UIKit

class ViewController: UIViewController {

        var num1 = ""
        var num2 = ""
        var result = ""
        var operation = ""
        var currNum = ""
        var opChange = false
        var inChainmode = false
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
    
    func clearAll(){
        num1 = ""
        num2 = ""
        opChange = false
        operation = ""
        currNum = ""
        outputLabel.text = ""
        inChainmode = false
    }
    func input(_ number: String){
        if outputLabel.text == "0"{
            outputLabel.text = ""
        }
        else{
            if !opChange{
                outputLabel.text! += number
                num1 += number
            }
            else{
                if !inChainmode{
                    outputLabel.text! += number
                    num2 += number
                }
                else{
                    outputLabel.text = ""
                    outputLabel.text! += number
                    num2 += number
                }
            }
        }
    }
        
        @IBAction func AC(_ sender: UIButton) {
            
            clearAll()
        }
        
        
        
        func performOp(_ operation:String)->String {
            if num1 != "" && num2 != ""{
                if operation == "+"{
                    num1 = String(Double(num1)! + Double(num2)!)
                    currNum = num2
                    num2 = ""
                    return String(num1)
                }
                if operation == "-"{
                    num1 = String(Double(num1)! - Double(num2)!)
                    currNum = num2
                    num2 = ""
                    
                    return String(num1)
                }
                if operation == "*"{
                    num1 = String(Double(num1)! * Double(num2)!)
                    currNum = num2
                    num2 = ""
                    return String(num1)
                }
                if operation == "/"{
                    num1 = String(Double(num1)! / Double(num2)!)
                    currNum = num2
                    num2 = ""
                    return String(num1)
                }
                if operation == "%" {
                    let s1 = Double(num1)!
                    let s2 = Double(num2)!
                    var r = s1.remainder(dividingBy: s2)
                    num1 = String(r)
                    currNum = num2
                    num2 = ""
                    return String(num1)
                }
            }
            return ""
        }
        func resultFormatter(_ result:String)->String {
            let value = Double(result)!
            var resultStr = String(round(value * 100000) / 100000.0)
            
            if resultStr.contains(".0"){
                resultStr.removeSubrange(resultStr.index(resultStr.endIndex, offsetBy: -2)..<resultStr.endIndex)
            }
            
            return resultStr
    }
        
        @IBAction func C(_ sender: UIButton) {
            num2 = ""
            outputLabel.text = ""
        }
        @IBAction func plusOrMinus(_ sender: UIButton) {
            let pm = outputLabel.text!
            var RunningTotal = (pm as NSString).doubleValue
            if(RunningTotal > 0){
                RunningTotal = RunningTotal * -1;
                let std = String(format: "%.0f", RunningTotal)
                outputLabel.text = std;
    //            workings = std;
            }
            else{
                RunningTotal = RunningTotal * -1;
                let std = String(format: "%.0f", RunningTotal)
                outputLabel.text = std;
    //            workings = std;
            }
        }
        @IBAction func divide(_ sender: UIButton) {
            let temp = performOp(operation)
            operation = "/"
            outputLabel.text = (temp != "") ? resultFormatter(temp) : ""
              if temp != "" {
                  //            inChainmode = true
                  if num2 != ""{
                      inChainmode = true
                      
                      if opChange {
                          result = String(Double(temp)! / Double(num2)!)
                          print(result)
                          if result == "inf"{
                            outputLabel.text! = "Error"
                          }else{
                            outputLabel.text! = resultFormatter(result)
                          }
                      }
                  }
              }
              opChange = true
            
        }
        
        @IBAction func multiplication(_ sender: UIButton) {
            let temp = performOp(operation)
            print("temp is \(temp)")
            operation = "*"
            currNum=""
            outputLabel.text = (temp != "") ? resultFormatter(temp) : ""
             
            opChange = true
        }
        @IBAction func minus(_ sender: UIButton) {
            if(num1 == ""){
                num1 = "0"
            }
            let temp = performOp(operation)
            print("temp is \(temp)")
            operation = "-"
            currNum=""
            outputLabel.text = (temp != "") ? resultFormatter(temp) : ""
            opChange = true
            
        }
        @IBAction func plus(_ sender: UIButton) {
            let temp = performOp(operation)
            print("temp is \(temp)")
            operation = "+"
            currNum=""
            outputLabel.text = (temp != "") ? resultFormatter(temp) : ""
            opChange = true
        }
        
        @IBAction func equals(_ sender: UIButton) {
            var res = ""
            switch operation {
            case "+":
                
            if currNum != "" {
                    res = String(Double(num1)! + Double(currNum)!)
                    outputLabel.text = resultFormatter(res)
                     num2 = currNum
                }else{
                    res = String(Double(num1)! + Double(num2)!)
                    outputLabel.text = resultFormatter(res)
                }
                num1 = res
                
                break
            case "*":
                if currNum != "" {
                    res = String(Double(num1)! * Double(currNum)!)
                    outputLabel.text = resultFormatter(res)
                }else{
                    res = String(Double(num1)! * Double(num2)!)
                    outputLabel.text = resultFormatter(res)
                }
                num1 = res
                
                break
            case "-":
                if currNum != "" {
                    res = String(Double(num1)! - Double(currNum)!)
                    outputLabel.text = resultFormatter(res)
                    
                }else{
                    res = String(Double(num1)! - Double(num2)!)
                    outputLabel.text = resultFormatter(res)
                   
                }
                num1 = res
                break
            case "/":
                if outputLabel.text == "Error"{
                    clearAll()
                }else{
                    if currNum != "" {
                        res = String(Double(num1)! / Double(currNum)!)
                        if res == "inf"{
                            outputLabel.text! = "Error"
                            return
                        }else{
                            outputLabel.text = resultFormatter(res)
                        }
                    }else{
                        res = String(Double(num1)! / Double(num2)!)
                        if res == "inf"{
                            outputLabel.text! = "Error"
                            return
                        }else{
                            outputLabel.text = resultFormatter(res)
                        }
                    }
                    num1 = res
                }
                break
            case "%":
                if currNum != "" {
                    outputLabel.text = resultFormatter(res)
                    let s1 = Double(num1)!
                    let s2 = Double(currNum)!
                    var r = s1.remainder(dividingBy: s2)
                    res = String(r)
                     num2 = currNum
                }else{
                    let s1 = Double(num1)!
                    let s2 = Double(num2)!
                    var r = s1.remainder(dividingBy: s2)
                    res = String(r)
                    outputLabel.text = resultFormatter(res)
                }
                num1 = res
                
                break
                
            default:
                print("IOS")
            }
        
        }
        
        @IBAction func remainder(_ sender: UIButton) {
            let temp = performOp(operation)
            print("temp is \(temp)")
            operation = "%"
            currNum=""
            outputLabel.text = (temp != "") ? resultFormatter(temp) : ""
             
            opChange = true
        }
        @IBAction func dot(_ sender: UIButton) {
            input(".")
        }
        
        @IBAction func seven(_ sender: UIButton) {
            input("7")
        }
        @IBAction func eight(_ sender: UIButton) {
            input("8")
        }
        
        @IBAction func nine(_ sender: UIButton) {
            input("9")
        }
        @IBAction func four(_ sender: UIButton) {
            input("4")
        }
        
        @IBAction func five(_ sender: UIButton) {
            input("5")
        }
        @IBAction func six(_ sender: UIButton) {
            input("6")
        }
        
        @IBAction func one(_ sender: UIButton) {
            input("1")
        }
        @IBAction func two(_ sender: UIButton) {
            input("2")
        }
        @IBAction func three(_ sender: UIButton) {
            input("3")
        }
        @IBAction func zero(_ sender: UIButton) {
            input("0")
        }
    
    
}
