//
//  ViewController.swift
//  AutoLayoutPractice
//
//  Created by Kristopher Kane on 7/15/15.
//  Copyright (c) 2015 Kris Kane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculationLabel = UILabel()
    //   First Row
    var clearButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var lineClearButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var moduloButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var divideButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton

    //   Second Row
    var sevenButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var eightButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var nineButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var multiplyButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton

    //   Third Row
    var fourButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var fiveButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var sixButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var minusButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton

    //   Fourth Row
    var oneButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var twoButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var threeButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var plusButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    //   Fifth Row
    var zeroButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var placeholder = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var decimalButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var equalButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    //  Use this to set the spacing between button if so desired
    let spacingConstant : CGFloat = 0.0
    
    // Calculator functionality variables
    var calculationValues : [Double] = [] // Stores calculated value
    var operationArray : [(Double,Double)->Double] = [] // Stores user input of operators
    var numbersEnteredArray : [String] = [] // Stores user input of numbers
    
    // Store operators in dictionary
    let operators: [String:(Double,Double)->Double] = [
        "+": (+),
        "-": (-),
        "/": (/),
        "x": (*)
    ]
    
    // DRY function for operations in case statement nested inside doPressButton()
    func doSomeOperation(buttonTitle: String) {
        if calculationValues.count != 0 {
            calculationLabel.text = "\(calculationValues[0]) \(buttonTitle)"
            numbersEnteredArray = []
            operationArray.append(operators[buttonTitle]!)
        } else {
            calculationValues.append((displayNumber as NSString).doubleValue)
            if (calculationValues[0] % 1) == 0 {
                let displayInteger = Int(calculationValues[0])
                calculationLabel.text = "\(displayInteger) \(buttonTitle)"
                numbersEnteredArray = []
                operationArray.append(operators[buttonTitle]!)
            } else {
                calculationLabel.text = "\(calculationValues[0]) \(buttonTitle)"
                numbersEnteredArray = []
                operationArray.append(operators[buttonTitle]!)
            }
        }
    }

    // Create a string from the array of Numbers the user entered before an operator
    func createNumberToDisplay() -> String {
        var numberString = String()
        numberString = "".join(numbersEnteredArray)
        
        return numberString
    }
    
    // Empty temporary variables between calculations or on "C" press
    func reset() {
        numbersEnteredArray = []
        if calculationValues.count == 0 {
        calculationLabel.text = "0"
        } else {
            calculationLabel.text = "\(calculationValues[0])"
        }
    }
    
    // Empty all variables, prepare for all new calculation
    func clearAll() {
        operationArray = []
        displayNumber = ""
        calculationValues = []
        numbersEnteredArray = []
        calculationLabel.text = "0"
    }
    
    // Actually perform the calculation by using the stored operator
    func performCalculations() -> Double {
        println(calculationValues)
        println(calculationValues.count)
        if calculationValues.count == 2 {
            let solution = operationArray[0](calculationValues[0], calculationValues[1])
            println("After: \(calculationValues)")
                return solution
        } else {
            calculationLabel.text = "ERROR"
            
        }
        return 0.0
    }
   
    var displayNumber : String = ""
    
    func doPressButton(sender: UIButton!) {
        let buttonTitle = sender.titleLabel?.text
        if let buttonTitle = buttonTitle {
            switch buttonTitle {
                case "1","2","3","4","5","6","7","8","9","0":
                    numbersEnteredArray.append(buttonTitle)
                    displayNumber = createNumberToDisplay()
                    calculationLabel.text = "\(displayNumber)"
                case "AC":
                    clearAll()
                case "C":
                    reset()
                    calculationLabel.text = "0"
                case "%":
                    if calculationValues.count != 0 {
                        operationArray.append(%)
                        reset()
                    } else {
                        calculationValues.append((displayNumber as NSString).doubleValue)
                        operationArray.append(%)
                        reset()
                }
                case "/":
                    doSomeOperation(buttonTitle)
                case "x":
                    doSomeOperation(buttonTitle)
                case "-":
                    doSomeOperation(buttonTitle)
                case "+":
                    doSomeOperation(buttonTitle)
                case "=":
                    calculationValues.append((displayNumber as NSString).doubleValue)
                    let solution = performCalculations()
                    clearAll()
                    calculationValues.append(solution)
                    if (calculationValues[0] % 1) == 0 {
                        let displayInteger = Int(calculationValues[0])
                        calculationLabel.text = "\(displayInteger)"
                        println("end of equal case statement \(calculationValues)")

                    } else {
                        calculationLabel.text = "\(calculationValues[0])"
                        println("end of equal case statement \(calculationValues)")
                    }
                case ".":
                    let numberString = "".join(numbersEnteredArray)
                        if numberString.rangeOfString(".") != nil{
                            println("exists")
                        }else {
                            numbersEnteredArray.append(".")
                            displayNumber = createNumberToDisplay()
                            calculationLabel.text = "\(displayNumber)"
                        }
            default:
                println("not a number")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalculator()
    }
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }

    func setupCalculator() {
        
        //  UIView Background Color = black, in lieu of using borders
        view.backgroundColor = .blackColor()
        
        //  Calculation Label
        calculationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        calculationLabel.backgroundColor = .blackColor()
        calculationLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 70)
        calculationLabel.numberOfLines = 0
        calculationLabel.adjustsFontSizeToFitWidth = true
        calculationLabel.textColor = .whiteColor()
        calculationLabel.adjustsFontSizeToFitWidth = true
        calculationLabel.textAlignment = .Right
        view.addSubview(calculationLabel)
        
        //  First Row
        clearButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        clearButton.setTitle("AC", forState: UIControlState.Normal)
        view.addSubview(clearButton)
        
        lineClearButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        lineClearButton.setTitle("C", forState: UIControlState.Normal)
        view.addSubview(lineClearButton)
        
        moduloButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        moduloButton.setTitle("%", forState: UIControlState.Normal)
        view.addSubview(moduloButton)
        
        divideButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        divideButton.setTitle("/", forState: UIControlState.Normal)
        view.addSubview(divideButton)
        
        //   Second Row
        sevenButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        sevenButton.setTitle("7", forState: UIControlState.Normal)
        view.addSubview(sevenButton)
        
        eightButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        eightButton.setTitle("8", forState: UIControlState.Normal)
        view.addSubview(eightButton)
        
        nineButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        nineButton.setTitle("9", forState: UIControlState.Normal)
        view.addSubview(nineButton)
        
        multiplyButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        multiplyButton.setTitle("x", forState: UIControlState.Normal)
        view.addSubview(multiplyButton)
        
        //   Third Row
        fourButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        fourButton.setTitle("4", forState: UIControlState.Normal)
        view.addSubview(fourButton)
        
        fiveButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        fiveButton.setTitle("5", forState: UIControlState.Normal)
        view.addSubview(fiveButton)
        
        sixButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        sixButton.setTitle("6", forState: UIControlState.Normal)
        view.addSubview(sixButton)
        
        minusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        minusButton.setTitle("-", forState: UIControlState.Normal)
        view.addSubview(minusButton)
        
        //   Fourth Row
        oneButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        oneButton.setTitle("1", forState: UIControlState.Normal)
        view.addSubview(oneButton)
        
        twoButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        twoButton.setTitle("2", forState: UIControlState.Normal)
        view.addSubview(twoButton)
        
        threeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        threeButton.setTitle("3", forState: UIControlState.Normal)
        view.addSubview(threeButton)
        
        plusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        plusButton.setTitle("+", forState: UIControlState.Normal)
        view.addSubview(plusButton)
        
        //   Fifth Row
        zeroButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        zeroButton.setTitle("0", forState: UIControlState.Normal)
        view.addSubview(zeroButton)
        
        placeholder.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(placeholder)
        
        decimalButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        decimalButton.setTitle(".", forState: UIControlState.Normal)
        view.addSubview(decimalButton)
        
        equalButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        equalButton.setTitle("=", forState: UIControlState.Normal)
        view.addSubview(equalButton)
        
        
        // List of grey buttons to be set as grey in subsequent function
        let greyButtonArray : [UIButton] = [
            clearButton,
            lineClearButton,
            moduloButton,
            oneButton,
            twoButton,
            threeButton,
            fourButton,
            fiveButton,
            sixButton,
            sevenButton,
            eightButton,
            nineButton,
            zeroButton,
            decimalButton
        ]
        
        // List of orange buttons to be set as grey in subsequent function
        let orangeButtonArray : [UIButton] = [
            divideButton,
            multiplyButton,
            minusButton,
            plusButton,
            equalButton
        ]
        
        // calculationLabel Constraints
        let calculationLabelTopConstraint = NSLayoutConstraint(
            item: calculationLabel,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0
        )
        
        let calculationLabelLeftConstraint = NSLayoutConstraint(
            item: calculationLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0
        )
        
        let calculationLabelRightConstraint = NSLayoutConstraint(
            item: calculationLabel,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0
        )
        
        let calculationLabelWidthConstraint = NSLayoutConstraint(
            item: calculationLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let calculationLabelHeightConstraint = NSLayoutConstraint(
            item: calculationLabel,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Height,
            multiplier: 2.0,
            constant: 0
        )
        
        view.addConstraints([calculationLabelTopConstraint, calculationLabelLeftConstraint, calculationLabelRightConstraint, calculationLabelHeightConstraint])
        
        // clearButton Constraints
        let clearHeightConstraint = NSLayoutConstraint(
            item: clearButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let clearWidthConstraint = NSLayoutConstraint(
            item: clearButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: lineClearButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let clearTopConstraint = NSLayoutConstraint(
            item: clearButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: calculationLabel,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let clearLeftConstraint = NSLayoutConstraint(
            item: clearButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints([clearHeightConstraint, clearLeftConstraint, clearTopConstraint, clearWidthConstraint])
        
        // lineClearButton Constraints
        let lineClearHeightConstraint = NSLayoutConstraint(
            item: lineClearButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let lineClearWidthConstraint = NSLayoutConstraint(
            item: lineClearButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: moduloButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let lineClearTopConstraint = NSLayoutConstraint(
            item: lineClearButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let lineClearLeftConstraint = NSLayoutConstraint(
            item: lineClearButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        
        view.addConstraints([lineClearHeightConstraint, lineClearLeftConstraint, lineClearTopConstraint, lineClearWidthConstraint])
        
        // moduloButton Constraints
        let moduloHeightConstraint = NSLayoutConstraint(
            item: moduloButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nineButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let moduloWidthConstraint = NSLayoutConstraint(
            item: moduloButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: divideButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let moduloTopConstraint = NSLayoutConstraint(
            item: moduloButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let moduloLeftConstraint = NSLayoutConstraint(
            item: moduloButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: lineClearButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([moduloHeightConstraint, moduloLeftConstraint, moduloTopConstraint, moduloWidthConstraint])
        
        // divideButton Constraints
        let divideHeightConstraint = NSLayoutConstraint(
            item: divideButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let divideWidthConstraint = NSLayoutConstraint(
            item: divideButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: moduloButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let divideTopConstraint = NSLayoutConstraint(
            item: divideButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let divideLeftConstraint = NSLayoutConstraint(
            item: divideButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: moduloButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let divideRightConstraint = NSLayoutConstraint(
            item: divideButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([divideHeightConstraint, divideWidthConstraint, divideTopConstraint, divideLeftConstraint, divideRightConstraint])
        
        // sevenButton Constraints
        let sevenTopConstraint = NSLayoutConstraint(
            item: sevenButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let sevenLeftConstraint = NSLayoutConstraint(
            item: sevenButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let sevenHeightConstraint = NSLayoutConstraint(
            item: sevenButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let sevenWidthConstraint = NSLayoutConstraint(
            item: sevenButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([sevenHeightConstraint, sevenLeftConstraint, sevenTopConstraint, sevenWidthConstraint])
        
        // eightButton Constraints
        let eightTopConstraint = NSLayoutConstraint(
            item: eightButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let eightLeftConstraint = NSLayoutConstraint(
            item: eightButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let eightHeightConstraint = NSLayoutConstraint(
            item: eightButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: clearButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let eightWidthConstraint = NSLayoutConstraint(
            item: eightButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([eightHeightConstraint, eightLeftConstraint, eightTopConstraint, eightWidthConstraint])
        
        // nineButton Constraints
        let nineTopConstraint = NSLayoutConstraint(
            item: nineButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let nineLeftConstraint = NSLayoutConstraint(
            item: nineButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let nineHeightConstraint = NSLayoutConstraint(
            item: nineButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: sixButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let nineWidthConstraint = NSLayoutConstraint(
            item: nineButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints([nineHeightConstraint, nineLeftConstraint, nineTopConstraint, nineWidthConstraint])
        
        // multiplyButton Constraints
        let multiplyHeightConstraint = NSLayoutConstraint(
            item: multiplyButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: divideButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let multiplyWidthConstraint = NSLayoutConstraint(
            item: multiplyButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nineButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let multiplyTopConstraint = NSLayoutConstraint(
            item: multiplyButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let multiplyLeftConstraint = NSLayoutConstraint(
            item: multiplyButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: nineButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let multiplyRightConstraint = NSLayoutConstraint(
            item: multiplyButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([multiplyHeightConstraint, multiplyLeftConstraint, multiplyTopConstraint, multiplyWidthConstraint, multiplyRightConstraint])
        
        // fourButton Constraints
        let fourTopConstraint = NSLayoutConstraint(
            item: fourButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let fourLeftConstraint = NSLayoutConstraint(
            item: fourButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let fourHeightConstraint = NSLayoutConstraint(
            item: fourButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: sevenButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let fourWidthConstraint = NSLayoutConstraint(
            item: fourButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: fiveButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([fourHeightConstraint, fourLeftConstraint, fourTopConstraint, fourWidthConstraint])
        
        // fiveButton Constraints
        let fiveTopConstraint = NSLayoutConstraint(
            item: fiveButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let fiveLeftConstraint = NSLayoutConstraint(
            item: fiveButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let fiveHeightConstraint = NSLayoutConstraint(
            item: fiveButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: eightButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let fiveWidthConstraint = NSLayoutConstraint(
            item: fiveButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: sixButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([fiveHeightConstraint, fiveLeftConstraint, fiveTopConstraint, fiveWidthConstraint])
        
        // sixButton Constraints
        let sixTopConstraint = NSLayoutConstraint(
            item: sixButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let sixLeftConstraint = NSLayoutConstraint(
            item: sixButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: fiveButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let sixHeightConstraint = NSLayoutConstraint(
            item: sixButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nineButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let sixWidthConstraint = NSLayoutConstraint(
            item: nineButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: minusButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([sixHeightConstraint, sixLeftConstraint, sixTopConstraint, sixWidthConstraint])
        
        // minusButton Constraints
        let minusTopConstraint = NSLayoutConstraint(
            item: minusButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let minusLeftConstraint = NSLayoutConstraint(
            item: minusButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: sixButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let minusHeightConstraint = NSLayoutConstraint(
            item: minusButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: multiplyButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let minusWidthConstraint = NSLayoutConstraint(
            item: minusButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: sixButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let minusRightConstraint = NSLayoutConstraint(
            item: minusButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([minusHeightConstraint, minusLeftConstraint, minusRightConstraint, minusTopConstraint, minusWidthConstraint])
        
        // oneButton Constraints
        let oneTopConstraint = NSLayoutConstraint(
            item: oneButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let oneLeftConstraint = NSLayoutConstraint(
            item: oneButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let oneHeightConstraint = NSLayoutConstraint(
            item: oneButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: fourButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let oneWidthConstraint = NSLayoutConstraint(
            item: oneButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: twoButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([oneHeightConstraint, oneLeftConstraint, oneTopConstraint, oneWidthConstraint])
        
        // twoButton Constraints
        let twoTopConstraint = NSLayoutConstraint(
            item: twoButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let twoLeftConstraint = NSLayoutConstraint(
            item: twoButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let twoHeightConstraint = NSLayoutConstraint(
            item: twoButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: fiveButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let twoWidthConstraint = NSLayoutConstraint(
            item: twoButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: threeButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([twoHeightConstraint, twoLeftConstraint, twoTopConstraint, twoWidthConstraint])
        
        // threeButton Constraints
        let threeTopConstraint = NSLayoutConstraint(
            item: threeButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let threeLeftConstraint = NSLayoutConstraint(
            item: threeButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: twoButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let threeHeightConstraint = NSLayoutConstraint(
            item: threeButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: sixButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let threeWidthConstraint = NSLayoutConstraint(
            item: threeButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: plusButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([threeHeightConstraint, threeLeftConstraint, threeTopConstraint, threeWidthConstraint])
        
        // plusButton Constraints
        let plusTopConstraint = NSLayoutConstraint(
            item: plusButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let plusLeftConstraint = NSLayoutConstraint(
            item: plusButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: threeButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let plusHeightConstraint = NSLayoutConstraint(
            item: plusButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: minusButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let plusWidthConstraint = NSLayoutConstraint(
            item: plusButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: threeButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let plusRightConstraint = NSLayoutConstraint(
            item: plusButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([plusHeightConstraint, plusLeftConstraint, plusRightConstraint, plusTopConstraint, plusWidthConstraint])
        
        // zeroButton Constraints
        let zeroTopConstraint = NSLayoutConstraint(
            item: zeroButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let zeroLeftConstraint = NSLayoutConstraint(
            item: zeroButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let zeroHeightConstraint = NSLayoutConstraint(
            item: zeroButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: oneButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let zeroWidthConstraint = NSLayoutConstraint(
            item: zeroButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: decimalButton,
            attribute: .Width,
            multiplier: 2.0,
            constant: 0
        )
        
        let zeroBottomConstraint = NSLayoutConstraint(
            item: zeroButton,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints([zeroHeightConstraint, zeroLeftConstraint, zeroTopConstraint, zeroWidthConstraint, zeroBottomConstraint])
        
        // placeholder Constraints --> fixes Constraint error caused by zero having a double width
        let placeholderTopConstraint = NSLayoutConstraint(
            item: placeholder,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: zeroButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let placeholderLeftConstraint = NSLayoutConstraint(
            item: placeholder,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: zeroButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let placeholderHeightConstraint = NSLayoutConstraint(
            item: placeholder,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: twoButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let placeholderBottomConstraint = NSLayoutConstraint(
            item: placeholder,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints([placeholderHeightConstraint, placeholderLeftConstraint, placeholderTopConstraint, placeholderBottomConstraint])
        
        // decimalButton Constraints
        let decimalTopConstraint = NSLayoutConstraint(
            item: decimalButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: zeroButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let decimalLeftConstraint = NSLayoutConstraint(
            item: decimalButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: zeroButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let decimalHeightConstraint = NSLayoutConstraint(
            item: decimalButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: threeButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let decimalWidthConstraint = NSLayoutConstraint(
            item: decimalButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: equalButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let decimalBottomConstraint = NSLayoutConstraint(
            item: decimalButton,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints([decimalBottomConstraint, decimalHeightConstraint, decimalLeftConstraint, decimalTopConstraint, decimalWidthConstraint])
        
        // equalButton Constraints
        let equalTopConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: zeroButton,
            attribute: .Top,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let equalLeftConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: decimalButton,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let equalHeightConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: plusButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0
        )
        
        let equalWidthConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: decimalButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0
        )
        
        let equalRightConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        let equalBottomConstraint = NSLayoutConstraint(
            item: equalButton,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: spacingConstant
        )
        
        view.addConstraints([equalBottomConstraint, equalHeightConstraint, equalLeftConstraint, equalRightConstraint, equalWidthConstraint, equalTopConstraint])
        
        func doMakeGreyButtons() {
            for button in greyButtonArray {
                button.backgroundColor = UIColor(hexString: "#D9DADC")
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
        
        func doMakeOrangeButtons() {
            for button in orangeButtonArray {
                button.backgroundColor = UIColor(hexString: "#F68F12")
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
        
        // Call methods to create borders and color buttons correctly
        setupBordersFontsAndButtonActions()
        doMakeGreyButtons()
        doMakeOrangeButtons()
    }
    

// ---> Rename this function
    func setupBordersFontsAndButtonActions() {
        for v in view.subviews {
            if (v is UIButton) {
                let button = v as! UIButton
                button.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
                button.layer.borderColor = UIColor.blackColor().CGColor
                button.layer.borderWidth = 0.5
                button.addTarget(self, action: "doPressButton:", forControlEvents: UIControlEvents.TouchUpInside)

            }
        }
    }
}