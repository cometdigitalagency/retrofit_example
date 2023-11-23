# retrofit_example

This is an example for retrofit implementation in Flutter

## Installation

- ### Install packages

  ```bash
      flutter pub get
  ```

- ### Generate command

  1. Generate dependencies file, model, third party.

  ```bash
      dart run build_runner build
  ```

  if there are some conflict files you can solve by this command:

  ```bash
      dart run build_runner build --delete-conflicting-outputs
  ```

## Packages for retrofit implementation in this project

- ### retrofit

  How to handle the api call? So Let's go to retrofit then you will see [more info](https://pub.dev/packages/retrofit).

- ### json_serializable

  Automatically generate code for converting to and from JSON by annotating Dart classes [more info](https://pub.dev/packages/json_serializable)

- ### build_runner
  A build system for Dart code generation and modular compilation [more info](https://pub.dev/packages/build_runner)
