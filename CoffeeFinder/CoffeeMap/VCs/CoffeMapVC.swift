//
//  CoffeeMapVC.swift
//
import UIKit
import MapKit
import CoreLocation

class CoffeeMapVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate
{
    var mapView: MKMapView! // Карта для показа местоположения и кофеен
    var tableView: UITableView! // Таблица для отображения списка кофеен
    let locationManager = CLLocationManager() // Менеджер геолокации
    var coffeeShops: [MKMapItem] = [] // Массив для найденных кофеен
    var currentRouteOverlays: [MKOverlay] = [] // Массив для маршрутов
    var destinationCoffeeShop: MKMapItem? // Хранит текущую цель маршрута
    
    let annotationImageSize: CGSize = CGSize(width: 20, height: 20)
    let clusterImageSize: CGSize = CGSize(width: 30, height: 30)
    let labelFontSize: CGFloat = 12
    let labelTextColorHex: String = "#735C43" // Цвет ручки чашечки и её блюдечка
    let borderError = 2.0
    let percentOfScreenForMap = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemBackground
        setupMap()
        setupTableView()
        requestLocationAuthorization()
    }
    
    // MARK: - Настройка карты
    private func setupMap() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.pinTop(to: view)
        mapView.pinHorizontal(to: view)
        mapView.setHeight(UIScreen.main.bounds.height * percentOfScreenForMap)
        mapView.showsUserLocation = true
    }
    
    // MARK: - Настройка таблицы
    private func setupTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pinTop(to: mapView.bottomAnchor)
        tableView.pinHorizontal(to: view)
        tableView.pinBottom(to: view)
    }
    
    // MARK: - Запрос разрешения на использование геолокации
    private func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Настройка точности определения местоположения
        locationManager.requestAlwaysAuthorization() // Запрос разрешения на постоянное использование геолокации
        locationManager.startUpdatingLocation() // Начало обновления информации о местоположении
    }
    
    // MARK: - Поиск кофеен
    private func searchCoffeeShops(in region: MKCoordinateRegion) {
        // Формируем запрос
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "coffee"
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Error")
                return
            }
            self.coffeeShops = response.mapItems // Сохранение результатов поиска
            self.tableView.reloadData() // Обновление таблицы
            
            // Добавление аннотаций
            for item in response.mapItems {
                let annotation = CoffeeShopAnnotation(title: item.name ?? "", coordinate: item.placemark.coordinate, info: "")
                self.mapView.addAnnotation(annotation)
            }
        }
        //        mapView.showsUserLocation = false
    }
    
    // MARK: - Маршрут до выбранной кофейни
    private func routeToCoffeeShop(destination: MKMapItem) {
        // Очистка карты
        mapView.removeOverlays(currentRouteOverlays)
        currentRouteOverlays.removeAll()
        
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destination.placemark.coordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        // Выполнение запроса на построение маршрута
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Error")
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            self.currentRouteOverlays.append(route.polyline)
            
            // Убираем автоматическую центровку на маршруте для избежания скачков
            // let rect = route.polyline.boundingMapRect
            // self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let userLocation = location.coordinate
            let regionRadius: CLLocationDistance = 1000
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
            searchCoffeeShops(in: region)
            // Перестроение маршрута, если выбрана кофейня
            if let destination = destinationCoffeeShop {
                routeToCoffeeShop(destination: destination)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let coffeeShop = coffeeShops[indexPath.row]
        cell.textLabel?.text = coffeeShop.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoffeeShop = coffeeShops[indexPath.row]
        destinationCoffeeShop = selectedCoffeeShop // Сохраняем выбранную кофейню как цель
        routeToCoffeeShop(destination: selectedCoffeeShop)
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else if let cluster = annotation as? MKClusterAnnotation {
            let identifier = "cluster"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.canShowCallout = false
            } else {
                view?.annotation = annotation
            }
            
            // Используем изображение чашки для кластера
            if let customImage = UIImage(named: "cup2") {
                let backgroundColor = UIColor.clear
                let resizedAndRoundedImage = resizeImage(image: customImage, targetSize: clusterImageSize, backgroundColor: backgroundColor)
                view?.image = resizedAndRoundedImage
            }
            
            // Удаление старой метки перед добавлением новой
            view?.subviews.forEach {
                if $0 is UILabel {
                    $0.removeFromSuperview()
                }
            }
            
            // Добавляем UILabel для отображения количества аннотаций в кластере
            let label = UILabel()
            label.frame.size = clusterImageSize
            label.center = CGPoint(x: view!.bounds.size.width / 2 - borderError, y: view!.bounds.size.height / 2 + borderError)
            label.textAlignment = .center
            label.textColor = UIColor(hex: labelTextColorHex)
            label.font = UIFont.boldSystemFont(ofSize: labelFontSize)
            label.text = "\(cluster.memberAnnotations.count)"
            view?.addSubview(label)
            
            return view
        } else {
            // Обработка индивидуальных аннотаций с кастомным изображением чашки
            let identifier = "CoffeeShopAnnotation"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                if let customImage = UIImage(named: "cup2") {
                    let backgroundColor = UIColor.clear
                    let resizedAndRoundedImage = resizeImage(image: customImage, targetSize: annotationImageSize, backgroundColor: backgroundColor)
                    view?.image = resizedAndRoundedImage
                }
                view?.canShowCallout = true
            } else {
                view?.annotation = annotation
            }
            view?.clusteringIdentifier = "coffeeShop"
            return view
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize, backgroundColor: UIColor) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        // Без скругления лучше смотрится
        // context.addEllipse(in: rect)
        // context.clip()
        
        context.setFillColor(backgroundColor.cgColor)
        context.fill(rect)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

