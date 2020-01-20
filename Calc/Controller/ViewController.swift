//
//  ViewController.swift
//  Calc
//
//  Created by Vadim Shalugin on 23/09/2019.
//  Copyright © 2019 Vadim Shalugin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true//Private делаеет переменную доступной только в рамках текущего класса и позволяет избежать ее изменения из другого класса. Типа повышает безопасность и дает защиту от случайных влезаний в не те переменные при совместной работе или альцгеймере.
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {fatalError("Cannot convert displayLabel to Double.")}
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    private var calculator = CalculatorLogic()

    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {

        //What should happen when a non-number button is pressed
        
       isFinishedTypingNumber = true
       
       calculator.setNumber(displayValue)
       
       if let calcMethod = sender.currentTitle {

           if let result = calculator.calculate(symbol: calcMethod) {
               displayValue = result
           }
       }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
            
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber == true {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                if numValue == "." {//Альтернативный способ проверки, если точка уже была поставлена.
                    let isInt = floor(displayValue) == displayValue //Floor округляет Double к нижней границе. Дальше проверяется если округленное значение равно текущему значению. Если равно, значит число целое и точка не поставлена. Если не равно, значит число не целое и точка поставлена. Переменная isInt при этом типа Bool.
                    if !isInt {//Если число не целое, т.е. isInt != true, прекращает выполнение функции.
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
}

