plugins {
    id("com.android.application") apply false
    id("com.android.library") apply false
    kotlin("android") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: keep custom build directories
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
