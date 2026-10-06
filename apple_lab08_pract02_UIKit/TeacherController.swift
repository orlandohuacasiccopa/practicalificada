import UIKit

struct Teacher {
    let name: String
    let department: String
    let initials: String
    let color: UIColor
    let textColor: UIColor
}

class TeacherController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    let teachers: [Teacher] = [
        Teacher(name: "John Doe", department: "Mathematics", initials: "JD",
                color: UIColor(red: 0.90, green: 0.94, blue: 1.00, alpha: 1.0), textColor: UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)),
        Teacher(name: "Anna Smith", department: "Physics", initials: "AS",
                color: UIColor(red: 1.00, green: 0.95, blue: 0.88, alpha: 1.0), textColor: UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.0)),
        Teacher(name: "Robert Johnson", department: "Chemistry", initials: "RJ",
                color: UIColor(red: 0.90, green: 0.98, blue: 0.92, alpha: 1.0), textColor: UIColor(red: 0.10, green: 0.80, blue: 0.30, alpha: 1.0)),
        Teacher(name: "Maria Brown", department: "Biology", initials: "MB",
                color: UIColor(red: 0.94, green: 0.92, blue: 1.00, alpha: 1.0), textColor: UIColor(red: 0.40, green: 0.30, blue: 0.90, alpha: 1.0)),
        Teacher(name: "David Wilson", department: "History", initials: "DW",
                color: UIColor(red: 1.00, green: 0.90, blue: 0.92, alpha: 1.0), textColor: UIColor(red: 1.00, green: 0.20, blue: 0.40, alpha: 1.0)),
        Teacher(name: "Emily Garcia", department: "English", initials: "EG",
                color: UIColor(red: 0.96, green: 0.91, blue: 0.99, alpha: 1.0), textColor: UIColor(red: 0.70, green: 0.20, blue: 0.90, alpha: 1.0)),
        Teacher(name: "Thomas Martinez", department: "Computer Science", initials: "TM",
                color: UIColor(red: 0.88, green: 0.98, blue: 0.98, alpha: 1.0), textColor: UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.0)),
        Teacher(name: "Laura Taylor", department: "Art", initials: "LT",
                color: UIColor(red: 1.00, green: 0.95, blue: 0.88, alpha: 1.0), textColor: UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.0))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Título de la navegación
        title = "Teachers"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Agregar la barra de búsqueda
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Generador de imagen circular con iniciales
    func makeCircleInitialsImage(initials: String, backgroundColor: UIColor, textColor: UIColor) -> UIImage {
        let size = CGSize(width: 44, height: 44)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { context in
            // Fondo circular
            let circlePath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
            backgroundColor.setFill()
            circlePath.fill()
            
            // Texto de iniciales centrado
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: textColor
            ]
            let textSize = initials.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (size.width - textSize.width) / 2,
                y: (size.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
            initials.draw(in: textRect, withAttributes: attributes)
        }
    }

    // MARK: - Métodos de TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath)
        let teacher = teachers[indexPath.row]
        
        cell.textLabel?.text = teacher.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.detailTextLabel?.text = teacher.department
        cell.detailTextLabel?.textColor = .gray
        
        // Asignar icono circular generado dinámicamente
        cell.imageView?.image = makeCircleInitialsImage(
            initials: teacher.initials,
            backgroundColor: teacher.color,
            textColor: teacher.textColor
        )
        
        return cell
    }
}
