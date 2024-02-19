

fn main() {
    // let mut conf = cpp_build::Config::new();
    // conf.include("include/qt")
    //     .opt_level(2)
    //     .build("src/main.rs");

    // println!("cargo:rustc-link-lib=Qt5Gui");
    // println!("cargo:rustc-link-lib=Qt5Core");
    // println!("cargo:rustc-link-lib=Qt5Quick");
    // println!("cargo:rustc-link-lib=Qt5Qml");
    
    slint_build::compile("ui/appwindow.slint").unwrap();
}