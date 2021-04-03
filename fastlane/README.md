fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios tests
```
fastlane ios tests
```
Push a new homolog build to TestFlight
### ios homolog
```
fastlane ios homolog
```
Push a new homolog build to TestFlight
### ios homologVersionUp
```
fastlane ios homologVersionUp
```
Push and version up a new homolog build to TestFlight
### ios homologWithCustomVersion
```
fastlane ios homologWithCustomVersion
```
Push a new homolog build to TestFlight with custom version
### ios production
```
fastlane ios production
```
Push a new production build to TestFlight
### ios productionVersionUp
```
fastlane ios productionVersionUp
```
Push and version up a new production build to TestFlight
### ios productionWithCustomVersion
```
fastlane ios productionWithCustomVersion
```
Push a new production build to TestFlight with custom version

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
