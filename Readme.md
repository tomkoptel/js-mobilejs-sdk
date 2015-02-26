Motivation
----------

We would like to keep all javascript wrappers around `Visualize.js` as one single project.

That way we can share common logic for both platforms.

Install Guide
-------------

Project designed as node.js module. So you need install it at first follow [THIS LINK](http://nodejs.org/).

The last step is to execute `npm install`. This will download build script dependencies.

Tasks
-----

-	**grunt watch** - daemon which looks into changes of coffee files and compiles them back in `build` dir
-	**grunt build:move** - copies result script to the mobile project
-	**grunt build:dev** - combines `coffee` and `build:move`

NOTES: grunt build:dev
----------------------

This task can be executed in 2 ways.

-	**grunt build:move:[ios|android]:/path/to/project/**
-	**grunt build:move**

```
 // Assigning arguments manually
 grunt build:move:android:../js-android-app/app/src/main/assets/
```

Second option requires specific file setup named as `.properties.json`.

```json
{
  "env": {
    "platform": "android", // Either android or ios
    "project": {
      // This is either relative or absolute path to destination folder
      // where task will copy result script
      "dst": "../js-android-app/app/src/main/assets/"
    }
  }
}
```
