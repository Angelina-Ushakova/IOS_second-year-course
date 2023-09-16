import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Инициализация студентов
        IOSNis.students = [
            Student(grades: [3.51, 10, 9], fullName: "Ушакова Ангелина"),
            Student(grades: [7, 8, 7.5], fullName: "Алибек Адхамов")
        ]

        // Получение и вывод нормализованных оценок
        let normalizedGrades = IOSNis.normalizeGrades()
        print(normalizedGrades)
    }
}
