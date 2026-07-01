plugins {
    id("com.android.application")
    kotlin("android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.translation_app"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.translation_app"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
        }
        release {
            isMinifyEnabled = true
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // implementation("androidx.core:core-ktx:1.13.1")
    // implementation("androidx.activity:activity:1.9.1")
    // implementation("androidx.appcompat:appcompat:1.7.0")
    // implementation("com.google.android.material:material:1.12.0")
}