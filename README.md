# LeBonCoin
Technical test for a job at LeBonCoin :)

## Project configuration

- Current Xcode version is 12.0
- Current Swift version is 5.3
- Deployment target is iOS 11.0
- Device orientation is restricted to only Portrait
- No iPadOS support, only iOS

## Environments configuration
Here there is no configuration, secondary schemes or anything because we only have the one (static) endpoint. 

## VIPER architecture (sorta)

VIPER is a backronym for View, Interactor, Presenter, Entity, and Router.

This architecture is based on Single Responsibility Principle which leads to a clean architecture.
It doesn't apply the usual V-I-P "loop", so it's not strict "by-the-book" VIPER. But who does VIPER by the book anyway :)

**View**: The responsibility of the view is to send the user actions to the presenter and shows whatever the presenter tells it.

**Interactor**: This is the backbone of an application as it contains the business logic.

**Presenter**: Its responsibility is to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it. It also asks the router/wireframe for navigation.

**Entity**: It contains basic model objects used by the Interactor.

**Router**: It has all navigation logic for describing which screens are to be shown when. It is normally written as a wireframe.

Protocols are used to communicate between the different layers of a module.
In this project we have 3 modules : Navigation, List and Detail.