plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// --- INSERIDO EM 2026-02-10 - INÍCIO ---
// Loading the keystore properties from the key.properties file
import java.util.Properties
import java.io.FileInputStream
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
} else {
    println("Build.gradle - Warning: key.properties file not found. Release builds will not be signed.")
}
// --- INSERIDO EM 2026-02-10 - FINAL ---

android {
    namespace = "br.com.saosebastiaoparoquia.ssb"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    // --- INSERIDO EM 2026-02-10 - INÍCIO ---
    // Signing app
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    // --- INSERIDO EM 2026-02-10 - FINAL ---

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "br.com.saosebastiaoparoquia.ssb"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // minSdk = flutter.minSdkVersion // (ORIGINAL DESCOMENTADO)
        minSdk = 24 // INSERIDO EM 2026-02-10
        // targetSdk = flutter.targetSdkVersion // (ORIGINAL DESCOMENTADO)
        targetSdk = 35 // INSERIDO EM 2026-02-10
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // signingConfig = signingConfigs.getByName("debug") // ORIGINAL (UNCOMMENTED) - DEBUG MODE
            signingConfig = signingConfigs.getByName("release") // INSERIDO EM 2026-02-10 - RELEASE MODE
        }
    }
}

flutter {
    source = "../.."
}
