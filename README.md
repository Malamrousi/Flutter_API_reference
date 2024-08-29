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
## Create repo to get data from Services

 #### Dealing with data of type Array
 ### Repository Implementation

The `MyRepo` class serves as an intermediary between the data source (API) and the application. It utilizes the `WebServices` class to fetch data from the API.

- **Class Definition:**
  - `MyRepo` takes an instance of `WebServices` through its constructor.
  
- **Data Fetching:**
  - The `getAllUsersModelsRepo` method is an asynchronous function that retrieves a list of users.
  - It calls the `getAllUsersServices` method from `WebServices` to fetch the data.
  - The API response is mapped to a list of `UsersModels` objects using `UsersModels.fromJson`.

  ```dart
  class MyRepo {
  WebServices webServices;
  MyRepo({
    required this.webServices,
  });

  Future<List<UsersModels>> getAllUsersModelsRepo() async {
    var response = await webServices.getAllUsersSrevices();

    return response.map((e)=>UsersModels.fromJson(e.toJson())).toList();
  }
  }
  ``` 

This approach ensures that the data fetched from the API is converted into well-defined model objects, making it easier to manage and use within the application.

### Code Explanation

This line of code performs a specific operation to transform a list of JSON objects into a list of `UsersModels` objects in Dart. Let’s break it down step by step:

```dart
return response.map((e) => UsersModels.fromJson(e.toJson())).toList();
 ```
### Code Breakdown
- **`response.map((e) => ... )`:**
  - `response` is assumed to be a collection (likely a list) that contains items of a certain type, possibly objects that were deserialized from JSON.
  - `map` is a function that iterates over each element in `response` and applies the function inside it (in this case, the function is `(e) => UsersModels.fromJson(e.toJson())`).
  - For each element `e` in `response`, the code inside `map` will be executed.

- **`e.toJson()`:**
  - `e` represents an element in the `response` list.
  - `toJson()` is a method that converts the `e` object into a JSON format, typically returning a `Map<String, dynamic>`. This step is necessary if `e` is not already in JSON format but is an instance of a class with a `toJson()` method that converts it to JSON.

- **`UsersModels.fromJson(...)`:**
  - `UsersModels.fromJson` is a factory constructor that takes a JSON map as input and creates an instance of `UsersModels`.
  - The JSON object produced by `e.toJson()` is passed into this constructor to create a `UsersModels` object.

- **`.toList()`:**
  - `map` returns an `Iterable`, which is a kind of collection that can be iterated over, but is not a list.
  - `.toList()` converts the `Iterable` produced by `map` into a `List`, which is a more common and usable collection type in Dart.

### Handling Data Returned as an Object

In this scenario, the data returned from the API is a single object rather than an array. Here's how the code was structured to handle this:

1. **Service Layer (`web_services.dart`)**:
   - A method `getAllUsersServices` was defined to fetch a single `UsersModels` object from the API.
   - The `@GET('users')` annotation specifies the endpoint, and the method returns a `Future<UsersModels>`, indicating that it will eventually return a `UsersModels` object.

   ```dart
   @GET('users')
   Future<UsersModels> getAllUsersServices();
    ``` 
    Repository Layer (my_repo.dart):

### Repository Layer (`my_repo.dart`):

- In the `MyRepo` class, the `getAllUsersModelsRepo` method was defined to interact with the service layer.
- This method calls `getAllUsersServices` from the `WebServices` class and awaits the response.
- The response, which is a `UsersModels` object, is then returned as-is.

```dart
Future<UsersModels> getAllUsersModelsRepo() async {
  var response = await webServices.getAllUsersServices();
    return UsersModels.fromJson(response.toJson());
}
```

### Using `@Path` with Retrofit

When working with RESTful APIs, it's common to need to pass dynamic segments in the URL path to retrieve specific resources. Retrofit provides the `@Path` annotation to handle these scenarios.

#### Example: Fetching a User by ID

[GoRest API - Get User by ID](https://gorest.co.in/public/v2/users/6940663)


In this example, we want to fetch a user by their unique ID from the API. Here's how it is done:

1. **Defining the API Call in `WebServices`:**
   - We define a method `getUserById` that makes a GET request to the `/users/{id}` endpoint.
   - The `{id}` part of the path is dynamic, meaning it will be replaced with the actual user ID when the method is called.
   - The `@Path()` annotation is used to bind the method parameter `id` to the `{id}` path segment.

   ```dart
   @GET('users/{id}')
   Future<UsersModels> getUserById(@Path() int id);
   ```
  ### Call API In Repo

   ```dart

  Future<UsersModels> getUserByIRepo(int userId) async {
    var response = await webServices.getUserById(userId);

    return UsersModels.fromJson(response.toJson());
  }
   ```
   ### Handling Path Variables with Incorrect Parameter Names in Retrofit

When working with Retrofit and defining a `@Path` variable, it's essential to ensure that the parameter name used in the method matches the placeholder in the URL path. However, if the parameter name in the method is not ideal or incorrectly named, you can still bind it to the correct placeholder in the URL.

#### Example:

```dart
@GET('users/{id}')
Future<UsersModels> getUserById(@Path('id') int iddddddd);
```
In this example:
The placeholder `{id}` in the URL path is correctly defined.
The method parameter is named iddddddd, which is not ideal, but by explicitly binding it to the `{id}` path segment using @Path('id'), Retrofit knows that `iddddddd` should be used to replace `{id}` in the URL.

## POST HTTP Request

A POST HTTP request is used to send data to a server to create or update a resource. Unlike GET requests, which retrieve data, POST requests submit data to be processed. The data sent in a POST request is typically included in the request body rather than the URL, making it suitable for submitting complex data, such as form submissions or uploading files. POST requests are often used in scenarios where actions like creating a new user, submitting a form, or updating records are needed.

### Key Characteristics:
- **Data Submission**: Data is sent in the request body, not in the URL.
- **Server-Side Processing**: The server processes the data and returns a response, which could be a confirmation, the newly created resource, or an error message.
- **Non-Idempotent**: Unlike GET requests, POST requests can change the state of the server, meaning multiple identical requests may have different effects.

### Example Usage:
- Creating a new user in a database.
- Submitting a form with user details.
- Uploading a file to a server.

### POST Request with `@Body` and `@Header`

When sending a POST request to create or update a resource on the server, you often need to include both the main data and additional metadata. In Retrofit, this is done using the `@Body` and `@Header` annotations.

#### Example:

```dart
@POST('users')
Future<UsersModels> postUser(@Body() UsersModels newUsers, @Header('Authorization') String token);
```
### Explanation:

- **`@POST('users')`:**
  - This annotation indicates that the function will send a POST request to the `users` endpoint. POST requests are typically used to create a new resource on the server.

- **`@Body() UsersModels newUsers`:**
  - The `@Body` annotation is used to send the main data of the request. In this case, `newUsers` is an object of type `UsersModels` that contains all the information about the new user you want to create.
  - **Usage**: The data inside `@Body` is serialized into JSON (or another format) and sent as the request body. This is where you include details like the user's name, email, gender, and status.

- **`@Header('Authorization') String token`:**
  - The `@Header` annotation is used to add additional information to the HTTP request, often for authentication or other control purposes. Here, the `Authorization` header is used to send a token that verifies the identity of the requestor.
  - **Usage**: The token is typically required by the server to authenticate the request, ensuring that the operation is performed by an authorized user.
  
### Explanation of the `createUser` Function

The `createUser` function is an asynchronous function that is responsible for creating a new user by sending the user's data to a server via an HTTP POST request. Here’s what happens step by step:

1. **Function Definition:**
   ```dart
   Future<UsersModels> createUser(UsersModels newUseer) async {
     return await webServices.postUser(newUseer, 'Bearer b33876c9f86939d0d1bb4fda3f5973092cce99e9cddd3a4f03320a7cd04e3144');
   ``` 

- **The function calls `postUser` method from the `webServices` object.**
  - The `postUser` method sends a POST request to the server, passing the `newUseer` data along with an authorization token in the header.
  - The authorization token is prefixed with `'Bearer'`, indicating that it is a Bearer token used for authentication.

- **Returning the Result:**
  - The function uses `await` to wait for the POST request to complete before returning the result.
  - The result returned is a `UsersModels` object, representing the newly created user after the operation is successfully completed on the server.

  
## API Error Handling


In mobile app development, handling errors gracefully is crucial to provide a smooth and user-friendly experience. When working with Flutter, Dio, a powerful HTTP client library, offers robust mechanisms for handling errors during network requests. In this article, we will explore how to effectively handle errors in Flutter using Dio, ensuring that your app remains reliable and user-friendly.

The API error handling approach described here is based on insights from [this article on Medium by Mohammad Joumani](https://medium.com/@mohammadjoumani/error-handling-in-flutter-a1dfe81a2e0).


### Dio Configuration and Instance Creation

```dart
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "en";
const String TOKEN = "token";
const String BASE_URL = "https://api.example.com";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: TOKEN,
      DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
    };

    dio.options = BaseOptions(
        baseUrl: BASE_URL,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}

```
## Global Error Handling with Interceptors
Use Dio interceptors to handle errors globally, providing consistent error handling throughout your app.

#### DataSource Enum
This is an enumeration that defines various data sources, each associated with a specific type of failure. It to be used for mapping error types to failure responses.

```dart
enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}
```
#### ResponseCode class
This class defines static integer constants representing various HTTP status codes, both standard HTTP status codes and custom ones for local status codes.

```dart
class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int API_LOGIC_ERROR = 422; 

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}


```

#### ResponseMessage class

This class defines static string constants representing response messages for different HTTP status codes. These messages to be internationalized (using localization).

```dart
class ResponseMessage {
  static const String NO_CONTENT =
      ApiErrors.noContent; // success with no data (no content)
  static const String BAD_REQUEST =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      ApiErrors.notFoundError; // failure, crash in server side

  // local status code
  static String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static String CANCEL = ApiErrors.defaultError;
  static String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static String SEND_TIMEOUT = ApiErrors.timeoutError;
  static String CACHE_ERROR = ApiErrors.cacheError;
  static String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static String DEFAULT = ApiErrors.defaultError;
}
```

#### DataSourceExtension
This extension adds a method called getFailure to the DataSource enum. This method returns a Failure object based on the value of the enum.

```dart
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    var mContext = navigatorKey!.currentState!.context;
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS.tr(mContext));
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT.tr(mContext));
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr(mContext));
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr(mContext));
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED.tr(mContext));
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr(mContext));
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR.tr(mContext));
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT.tr(mContext));
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr(mContext));
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT.tr(mContext));
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr(mContext));
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr(mContext));
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.tr(mContext));
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr(mContext));
    }
  }
}
```


### ErrorHandler
This class implements the `Exception` interface, indicating its purpose for handling exceptions. It contains a `late` field named `failure` of type `Failure`, which is not initialized immediately. The `ErrorHandler` class includes a constructor named `handle`, which takes a dynamic `error` parameter. This constructor handles various exceptions by invoking the `_handleError` function based on the error type. If the error is of type `DioException`, the function determines the failure; otherwise, it defaults to a value provided by the `DataSource` class.

```dart
class ErrorHandler implements Exception {
  late ErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      apiErrorModel = _handleError(error);
    } else {
      // default error
      apiErrorModel = DataSource.DEFAULT.getFailure();
    }
  }
}
```
####  Handling Errors in Specific Requests
While global error handling is essential, you can also handle errors on a per-request basis. Use try-catch blocks around Dio requests to capture errors and respond accordingly.

```dart
Future<Either<Failure, ResponseDto>> getResponse(RequestDto requestDto) async {
    if (await _networkInfo.isConnected) {
      try {
        ...
        .
        .
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  ```
  #### Displaying User-Friendly Error Messages
  ```dart
///English Message
"success": "success",
"bad_request_error": "bad request. try again later",
"no_content": "success with not content",
"forbidden_error": "forbidden request. try again later",
"unauthorized_error": "user unauthorized, try again later",
"not_found_error": "url not found, try again later",
"conflict_error": "conflict found, try again later",
"internal_server_error": "some thing went wrong, try again later",
"unknown_error": "some thing went wrong, try again later",
"timeout_error": "time out, try again late",
"default_error": "some thing went wrong, try again later",
"cache_error": "cache error, try again later",
"no_internet_error": "Please check your internet connection"

//Arabic Message
"success": "تم بنجاح",
"bad_request_error": "طلب غير صالح. حاول مرة أخرى لاحقًا",
"no_content": "success with not content",
"forbidden_error": "طلب محظور. حاول مرة أخرى لاحقًا",
"unauthorized_error": "user unauthorized, try again later",
"not_found_error": "url غير موجود , حاول مرة أخرى لاحقًا",
"conflict_error": "تم العثور على تعارض , حاول مرة أخرى لاحقًا",
"internal_server_error": "حدث خطأ ما , حاول مرة أخرى لاحقًا",
"unknown_error": "حدث خطأ ما , حاول مرة أخرى لاحقًا",
"timeout_error": "انتهت المهلة , حاول مرة أخرى متأخرًا",
"default_error": "حدث خطأ ما , حاول مرة أخرى لاحقًا",
"cache_error": "خطأ في ذاكرة التخزين المؤقت , حاول مرة أخرى لاحقًا",
"no_internet_error": "يُرجى التحقق من اتصالك بالإنترنت"
 ```
