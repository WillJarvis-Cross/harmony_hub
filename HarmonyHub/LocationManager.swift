import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var lastKnownLocation: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status

        switch status {
        case .notDetermined:
            // Location authorization status is not yet determined
            locationManager.requestWhenInUseAuthorization() // Request authorization
        case .authorizedWhenInUse, .authorizedAlways:
            // Location access is authorized, you can start updating the location
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Location access is denied or restricted
            // Handle the scenario where location services are not available
            print("DSDS")
        @unknown default:
            break
        }
    }

    // MARK: - Additional Convenience Methods

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func requestLocationOnce() {
        locationManager.requestLocation()
    }

    func checkLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    func checkLocationAuthorizationStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
}
