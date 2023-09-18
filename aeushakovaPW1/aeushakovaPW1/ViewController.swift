import UIKit

class ViewController: UIViewController {

    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // randomizeViewsAppearance()
        // Не хочу менять цвет и радиус углов вьюшек сразу после загрузки вью контроллера
    }
    
    func randomizeViewsAppearance() {
        var set = Set<UIColor>()

        // Генерация уникальных цветов
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }

        // Используем разные кривые анимации для разных элементов
        let animationOptions: [UIView.AnimationOptions] = [.curveEaseIn, .curveEaseOut, .curveLinear, .curveEaseInOut]

        // Анимация
        UIView.animate(
            withDuration: 3.49,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                for (index, view) in self.views.enumerated() {
                    let randomOption = animationOptions[index % animationOptions.count]
                    UIView.animate(
                        withDuration: 3.49,
                        delay: 0,
                        options: [randomOption],
                        animations: {
                            view.backgroundColor = set.popFirst()
                            view.layer.cornerRadius = .random(in: 0...25)
                        }
                    )
                }
            },
            completion: { [weak self] _ in
                self?.button.isEnabled = true
            }
        )

    }


    @IBAction func buttonWasPressed(_ sender: Any) {
        button.isEnabled = false // Деактивировать кнопку перед началом анимации
        randomizeViewsAppearance()
    }
    
    
}
