use std::env;
use std::process;
use std::path::Path;
use std::fs::File;

fn exit_with_error<S: Into<String>>(message: S) -> ! {
    println!("{}", message.into());
    process::exit(1);
}

fn main() {
    let index_path_string = match env::args().nth(1) {
        Some(path) => path.to_string(),
        None => exit_with_error("You must pass the path to a Git index-file"),
    };
    let index_path = Path::new(&index_path_string);

    // Open index file
    let file = match File::open(&index_path) {
        Err(why) => exit_with_error(format!("Error opening index file: {}", why)),
        Ok(file) => file,
    };

    println!("{:?}", file);
}
