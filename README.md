[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# Chuck Norris Facts

## Table of Contents

* [About this Project](#about-the-project)
  * [Features](#features)
  * [Screenshots](#screenshots)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [How to run](#how-to-run)
* [Technical](#Technical)
  * [Written in](#written-in)
  * [Principles](#principles)
  * [Architecture](#architecture)
  * [Modularization](#modularization)
  * [Main design patterns](#main-design-patterns)
  * [Folder Structure](#folder-structure)
  * [Unit tests](#unit-tests)
  * [UI tests](#ui-tests)
  * [Dependencies](#dependencies)
  * [CI/CD](#ci/cd)
* [License](#license)
* [Contact](#contact)

## About The Project

The main goal of this project is to demonstrate my knowledge with a few of the technologies and concepts I have been working with for the past few years. Although its straightforward use, the choices made in this app intend to cover projects that might grow exponentially and have as key factors: layer segregation, build time, maintainability, testatibility, among another real world features. Besides all that, you can search for, read and share some funny facts about Chuck Norris provided by https://api.chucknorris.io.

### Features

The features are the following:

* Searching and listing Chuck Norris Facts;
* Sharing a Fact.

The development progress is detailed in the [Projects tab](https://github.com/fredericoamsb/chuck-norris-facts/projects/1).

### Screenshots

Coming soon

## Getting Started

### Prerequisites

* [MacOS](https://www.apple.com/macos);
* [Xcode](https://developer.apple.com/xcode) 12.4, there is no warranty it runs on other versions.

### How to run

* You should clone the repository: `$ git clone https://github.com/fredericoamsb/chuck-norris-facts.git`;
* Enter the project folder `$ cd chuck-norris-facts`;
* Open the project on Xcode: `$ open -a Xcode ChuckNorrisFacts.xcworkspace`;
* Press the ▶️  button or the shortcut "⌘ R" then it will run 🏃🏻 .

## Technical

### Written in

This app is written fully in Swift and applies Decodable, Equatable, Higher order functions, Extensions, Generics, among many others of its features.

### Principles

This project follows the [S.O.L.I.D. Principles](https://medium.com/flawless-app-stories/s-o-l-i-d-principle-with-swift-b42f597ba7e2).

### Architecture

This project architecture follows the concepts of [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) written by Uncle Bob. Each layer has its own set of models, classes, and protocols, being the last one used for communication among the layers (Dependency Inversion Principle).

### Modularization

This project is organized in modules primarily following the segregation of layers presented by Clean Architecture. Also, each layer has its own segregation:

* App: application original module;
* DI: module for dependency injection;
* Domain: module containing the bussiness rules of the project, applied by models and use case interactors. It does not depend from any other module and provide protocols to be used or implemented by the other modules. For instance, Repository for the Data layer and Interactor for the Presentation layer;
* Presentation: This layer is segregated mainly by features. In this project there is just the Facts feature, but you may consider larger concepts. For instance all flows related to transfers in a banking app would have a module. In the same way all flows related to registration in another module. For sharing code between these features, you could have the Common module. However since these features don't know each other, they can't navigated to one another. For that you have the AppNavigation module, which knows any present feature and can navigative from/to them using protocols implemented by coordinators.
  * Facts: a feature to search and share facts about Chuck Norris.
* Data: This layer is segregated by how they relate to the app's data. In the case of this project, it has only the Networking module for performing network requests (but it could have a Storage module for local data, then we could have a AppData module for managing both data sources). However it must be clarified that this is perfomed applying inversion of control. Networking provides Repository protocols which are implemented by the Domain Interaction classes.
  * Networking: module to receive/request data from/to web services.

### Main design patterns

* Model-View-ViewModel
* Coordinator
* Observer
* Delegation
* DI Container

### Folder Structure

Besides being divided by modules, each module has its files grouped by its reponsibility.

### Unit tests

This project uses `XCTest`, assisted by `RxTest` and `RxBlocking` for Rx classes.

### UI tests

This project uses `XCTest`, assisted by `XCUIApplication`.

### Dependencies

This project uses dependencies managed by [Cocoapods](https://cocoapods.org). Each dependency is available only for its necessary modules.

* [SwiftLint](https://github.com/realm/SwiftLint): A tool to enforce Swift code style and conventions.
* [Swiftgen](https://github.com/SwiftGen/SwiftGen): A tool to automatically generate Swift code for resources of the project (like images and localized strings), to make them type-safe.
* [Swinject](https://github.com/Swinject/Swinject): Framework for dependency injection that uses DI Container pattern.
* [SwinjectAutoregistration](https://github.com/Swinject/SwinjectAutoregistration): Automate the dependencies registrations in a generic way and reduce their boilerplate.
* [RxSwift](https://github.com/ReactiveX/RxSwift): High level abstraction, reactive, functional and declarative programming.
* [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/main/RxCocoa): Provides Cocoa-specific capabilities;
* [RxTest](https://github.com/ReactiveX/RxSwift/tree/main/RxTest) and [RxBlocking](https://github.com/ReactiveX/RxSwift/tree/main/RxBlocking): For testing in the Rx way.
* [Moya/RxSwift](https://github.com/Moya/Moya): Network layer abstraction using Alamofire that provides integration with RxSwift.
* [AlamofireNetworkActivityLogger](https://github.com/konkab/AlamofireNetworkActivityLogger): For logging network activity.

### CI/CD
We use [Fastlane](https://github.com/fastlane/fastlane) to provide CLI commands to easily build and test the app using [GitHub Actions](https://github.com/fredericoamsb/chuck-norris-facts/actions).
You should install Fastlane and it's plugins using `$ bundle install` to use the commands described in the [documentation](https://github.com/fredericoamsb/chuck-norris-facts/tree/master/fastlane).

## License

Distributed under the MIT License. See [LICENSE][license-url] for more information.

## Contact

Frederico Augusto - [LinkedIn][linkedin-url]

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/fredericoamsb/chuck-norris-facts/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/fredericoamsb