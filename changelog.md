# CHANGELOG

## v1.6.0

* Migration to new module template
* ACF2018 support
* Only return true when new deploy is detected to stop execution chain

## v1.5.0

* Updated to use consistent Ortus Module Structure
* More checks on defaults for configuration
* Updated to use `getFileInfo` instead of java core

## v1.4.0

* Relocation fix due to chrome caching.
* New setting relocateOnDeploy that can relocate the user once the application stop has fired

## v1.3.0

* Travis updates
* Recipe updated with git commits if enabled.
* creation of tag automatically if not existent.

## v1.2.0

* Travis Updates
* Stop interceptor chain to avoid stop application exceptions on not found interceptors

## v1.1.0

* Updated instructions
* Updated location of deploy and sample deploy tag
* Added a CommandBox recipe for tagging the deploy tag: `box recipe deploy.boxr`
* Added tests and travis integration

## v1.0.0

* Create first module version