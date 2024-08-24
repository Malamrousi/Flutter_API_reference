## API Reference

This guide provides a reference on how to use the `dio` package in Flutter, along with other essential packages to streamline your API communication and state management.

### Packages Used in the Course

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
