#[macro_use] extern crate nom;

use std::env;
use std::process;
use std::path::Path;
use std::fs::File;
use std::io::Read;

use nom::{be_u32};

named!(magic_bytes, tag!("DIRC"));

#[derive(Debug)]
struct GitIndex {
    version: u32,
}

named!(git_index<&[u8], GitIndex>, do_parse!(
    magic_bytes       >>
    version: be_u32   >>

    (GitIndex { version: version })
));

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
