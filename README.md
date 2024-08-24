## API Reference

This guide provides a reference on how to use the `dio` package in Flutter, along with other essential packages to streamline your API communication and state management.

### Packages Used in the API

- **dio**: The primary package used to make API requests.
- **Retrofit**: Retrofit with Dio in Flutter simplifies HTTP API calls by converting RESTful endpoints into a type-safe interface.
- **retrofit_generator**: Used to automatically generate code for Retrofit integration.
- **json_annotation**: Provides annotations that help in JSON serialization and deserialization.
- **json_serializable**: Facilitates the creation of model classes by generating code for JSON serialization.
- **get_it**: A dependency injection library that acts as a service locator, making it easier to manage and access dependencies across the app.
- **build_runner**: A tool to generate code using Dart’s code generation libraries like `json_serializable` and `retrofit_generator`.
- **bloc**: A state management library that helps in implementing the BLoC pattern to manage the state of your application.

 ## Frist GET HTTP Requests

#### Models in the Project

The `users_models.dart` file defines the `UsersModels` class, which is used to represent user data retrieved from an API. This model class includes properties like `id`, `name`, `email`, `gender`, and `status`. 

#### JSON Serialization

- The `@JsonSerializable()` annotation is used for automatic JSON serialization and deserialization.
- The `fromJson` factory method converts a JSON map into an instance of `object`.
- The `toJson` method converts an instance of `object` back into a JSON map.

This setup ensures that the data received from the API can be easily mapped to a Dart object and vice versa, making it easier to manage and utilize the data within the app.


### Code Generation with build_runner

After creating and annotating your model class with `@JsonSerializable()`, you need to generate the required code for JSON serialization and deserialization. This is done using the `build_runner` package.

#### How to Run:

Use the following command to generate the necessary code:

```bash
dart run build_runner build

  ```
## Using Retrofit with Dio in Flutter

In this project, we're using the `Retrofit` package alongside `Dio` to handle HTTP requests in a type-safe and structured way. The combination of these packages allows us to define our API services as interfaces, which Retrofit then uses to generate the necessary networking code.

### Setting Up Web Services with Retrofit and Dio

1. **Import the Required Packages:**

   At the beginning of the `web_services.dart` file, we import the necessary packages:

   ```dart
   import 'package:dio/dio.dart';
   import 'package:json_annotation/json_annotation.dart';
   import 'package:retrofit/retrofit.dart';
   
   ```

 #### Using the @RestApi annotation, we define the base URL for our API:

  ```dart
   @RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
   ```
    
## Creating Functions in Services

When creating functions to interact with an API in your services, the first step is to determine the type of data that the API will return. The response could either be an array (list) like `[]` or an object like `{}`.

- **If the Data is an Array:**  
  If the API returns an array, the function should return a `Future` that contains a `List` of your model objects. For example:

  ```dart
  Future<List<UsersModels>> getUserServices() ;
  ``` 
- **If the Data is an Object:**  
  If the API returns a single object, the function should return a Future that contains just one instance of your model object. For example:
  ```dart
  Future<UsersModels> getUserServices();
  ``` 