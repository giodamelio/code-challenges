#[macro_use] extern crate nom;

mod parser;

use std::env;
use std::process;
use std::path::Path;
use std::fs::File;
use std::io::Read;

use parser::git_index;

fn exit_with_error<S: Into<String>>(message: S) -> ! {
    println!("{}", message.into());
    process::exit(1);
}

fn read_file(path_string: String) -> std::io::Result<Vec<u8>> {
    let index_path = Path::new(&path_string);
    let mut file = File::open(&index_path)?;
    let mut buf = vec![];

    file.read_to_end(&mut buf)?;
    Ok(buf)
}

fn main() {
    let index_path_string = match env::args().nth(1) {
        Some(path) => path.to_string(),
        None => exit_with_error("Invalid input path"),
    };

    let file = match read_file(index_path_string) {
        Ok(file) => file,
        Err(_) => exit_with_error("Could not read index file"),
    };

    println!("{:?}", git_index(&file[..]));
}
