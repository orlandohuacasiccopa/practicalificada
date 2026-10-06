import UIKit

class ResultsController: UIViewController {

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    var operationName: String = "Addition (+)"
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var totalResult: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    func updateUI() {
        operationLabel?.text = operationName
        firstNumberLabel?.text = String(format: "%g", firstNumber)
        secondNumberLabel?.text = String(format: "%g", secondNumber)
        resultLabel?.text = String(format: "%g", totalResult)
    }

    // Botón Share
    @IBAction func shareTapped(_ sender: UIButton) {
        let textToShare = "Resultado de \(operationName): \(totalResult)"
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    // Botón New Calculation
    @IBAction func newCalculationTapped(_ sender: UIButton) {
        // Regresa a la pestaña de la calculadora (Pestaña 2 / Índice 1)
        tabBarController?.selectedIndex = 1
    }
}
