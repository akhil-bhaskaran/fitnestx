plugins {
    id("com.android.application")
    // Apply the plugin here without specifying a version
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fitness"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.fitness"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
  // Import the Firebase BoM (Bill of Materials)
  implementation(platform("com.google.firebase:firebase-bom:33.12.0"))

  // Firebase dependencies (Don't specify versions when using the BoM)
  implementation("com.google.firebase:firebase-auth") // Firebase Authentication
  // Add other Firebase dependencies as needed (Firestore, Realtime Database, etc.)
}
