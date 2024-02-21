slint::include_modules!();


fn main() -> Result<(), slint::PlatformError> {
    let ui = AppWindow::new()?;

    ui.on_exit(
        move || {
            println!("User exit.");
            std::process::exit(0);
        }
    );

    ui.run()
}