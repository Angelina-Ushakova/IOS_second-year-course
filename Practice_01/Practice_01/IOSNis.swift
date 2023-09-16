final class Student {
    var grades: [Double] = []
    var fullName: String

    init(grades: [Double] = [], fullName: String) {
        self.grades = grades
        self.fullName = fullName
    }

    func getGrade() -> Double {
        var sum = 0.0

        for grade in grades {
            sum += grade
        }
        
        return sum / Double(grades.count)
    }
}

final class IOSNis {
    static var students: [Student] = []
    
    static func normalizeGrades() -> [String: Double] {
        var normalizedGrades: [String: Double] = [:]
        
        // Вычисляем средние оценки для всех студентов
        var averageGrades: [Double] = []
        for student in students {
            let avgGrade = student.getGrade()
            averageGrades.append(avgGrade)
            normalizedGrades[student.fullName] = avgGrade
        }
        
        guard let maxGrade = averageGrades.max() else {return [:]}
        
        // Нормализация средних оценок
        let normalizationFactor = maxGrade == 10.0 ? 1.0 : (10.0 / maxGrade)
        
        for (name, avgGrade) in normalizedGrades {
            normalizedGrades[name] = avgGrade * normalizationFactor
        }
        
        return normalizedGrades
    }
}
