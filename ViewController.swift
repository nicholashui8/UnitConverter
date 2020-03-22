//
//  ViewController.swift
//  Unit Converter
//
//  Created by Nicholas Hui on 3/20/20.
//  Copyright © 2020 Nicholas Hui. All rights reserved.
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    //options for units
    private let dataSource:[String] = ["Kilometer", "Meter", "Centimeter", "Milimeter", "Micrometer"]
    let conversion:[Double] = [1000, 1, 0.01, 0.001, 0.000001]
   
    var firstSelect: String = ""
    var secondSelect: String = ""
    var rowNum1: Int = 0
    var rowNum2: Int = 0

    
    //outlet for selecting units and input
    @IBOutlet weak var firstUnitPickerView: UIPickerView!
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var resultField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstUnitPickerView.dataSource = self
        firstUnitPickerView.delegate = self
        inputField.delegate = self
    }

    //executes when the user presses "convert"
    @IBAction func convertButton(_ sender: Any) {
        print("convert has been clicked")
        //the first unit selected
        print("First Select: \(firstSelect)")
        //the second unit selected
        print("Second Select: \(secondSelect)")
        print("Row Num 1: \(rowNum1)")
        print("Row Num 2: \(rowNum2)")


        //the number in the input field
        print(inputField.text)
        
        if let input = Double(inputField.text!){
            let convertedNum = convert(input, firstSelect, secondSelect, rowNum1, rowNum2, conversion)
            resultField.text = String(convertedNum)
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //if user touches outside of keyboard, get rid of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputField.resignFirstResponder()
    }

    
    //returns number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    //returns number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    //assigns firstSelect and secondSelect to whatever the user scrolls to. Component = 0 means user is selecting on first column. Component = 1 means user is selecting on second column
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Component\(component)")
        if(component == 0){
            firstSelect = dataSource[row]
            rowNum1 = row
        
        }
        if(component == 1){
            secondSelect = dataSource[row]
            rowNum2 = row

        }
    }
    
    //looks through dataSource and returns value at row. This places each word into a row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func convert( _ input: Double, _ firstSelect: String, _ secondSelect: String, _ rowNum1: Int, _ rowNum2: Int, _ conversion: [Double])->Double{
        let rate: Double = conversion[rowNum1] / conversion[rowNum2]
        print(rate)
        let convertedNum = input * rate
        return convertedNum
    }
}
