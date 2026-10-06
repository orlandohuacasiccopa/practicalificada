import UIKit

class CalculatorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var operationTextField: UITextField!
    
    let operations = ["Addition (+)", "Subtraction (-)", "Multiplication (×)"]
    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar selector de operaciones
        pickerView.delegate = self
        pickerView.dataSource = self
        operationTextField.inputView = pickerView
        operationTextField.text = operations[0]
        
        // Ocultar teclado al tocar fuera
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return operations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return operations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        operationTextField.text = operations[row]
    }

    // MARK: - Botón Calculate
    @IBAction func calculateTapped(_ sender: UIButton) {
        guard let text1 = firstNumberTextField.text, let num1 = Double(text1),
              let text2 = secondNumberTextField.text, let num2 = Double(text2),
              let selectedOperation = operationTextField.text else {
            
            let alert = UIAlertController(title: "Error", message: "Por favor ingresa números válidos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        var result: Double = 0.0
        switch selectedOperation {
        case "Addition (+)":
            result = num1 + num2
        case "Subtraction (-)":
            result = num1 - num2
        case "Multiplication (×)":
            result = num1 * num2
        default:
            break
        }

        // Pasar los datos a la pestaña 3 (ResultsController)
        if let tabBarVCs = tabBarController?.viewControllers,
           let resultsVC = tabBarVCs[2] as? ResultsController {
            resultsVC.operationName = selectedOperation
            resultsVC.firstNumber = num1
            resultsVC.secondNumber = num2
            resultsVC.totalResult = result
            
            // Cambiar automáticamente a la pestaña Results
            tabBarController?.selectedIndex = 2
        }
    }
}
