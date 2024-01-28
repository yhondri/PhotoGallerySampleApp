# PhotoGallery

<p align="row">
<img src= "https://github.com/yhondri/PhotoGallerySampleApp/blob/main/sample_app_screenshots/PhotoGallery.png?raw=true" width="200" height="350" >
</p>

## About The Project

PhotoGalley is an iOS app written in Swift and using the MVVM architecture. 

- MVVM stands for “Model View ViewModel”, and it’s a software architecture that facilitates the separation of the development of the graphical user interface from the development of the business logic or back-end logic (the model) such that the view is not dependent upon any specific model platform.

- The project is separated in 3 parts:
- SwiftUI: Contains the UI of the SwiftUI sample. 
- UIKit: Contains the UI of the UIKit sample. 
- Shared: Contains the shared components of both UI. 

## Shared
- Contains components of the domain layer like uses cases, entities etc... 
- Infrastructure It is a wrapper around network framework, because this is an example about the flow the MVVM architecture, the Default implementation of the infrastructure services load the data from local json files. 

### Built With
PhotoGallery use the next frameworks:
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the UI of the SwiftUI sample app. 
- [UIKit](https://developer.apple.com/documentation/uikit) for the UI of the UIKit sample app. 
- [XCTest](https://developer.apple.com/documentation/xctest) to write unit tests and UITests.

## Getting Started

Just download the project and open the PhotoGallery.xcodeproj.

## Prerequisites
- [Xcode](https://developer.apple.com/xcode/) version 15.1.
- Network conexion. 

## Usage
- Run the xcodeproj with a Simulator or Real device. 
- Choose the sample you want to check. 
- Select "Show SwiftUI Sample" if you want to test the SwiftUI sample.
- Select "Show UIKit Sample" if you want to test the UIKit sample. 
- After you select the sample you'll see a photoGallery. 
It contains a "Load More" buttons to load more photos (you can load 2 more pages right now).
