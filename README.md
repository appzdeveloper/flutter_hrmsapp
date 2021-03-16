# HRMS

Human Resource Management System

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
git clone http://192.168.1.73:6768/Arpit/human-resource-management-system-mobile-app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

``` 
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

To Create Launcher icon
```
flutter pub pub run flutter_launcher_icons:main
```

**Read more about project structure and used libraries [here](http://192.168.1.73:6768/Arpit/human-resource-management-system-mobile-app/wikis/home)**

