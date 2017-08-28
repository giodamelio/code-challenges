use nom::{be_u32};

named!(magic_bytes, tag!("DIRC"));

#[derive(Debug)]
pub struct GitIndex {
    version: u32,
}

named!(pub git_index<&[u8], GitIndex>, do_parse!(
    magic_bytes       >>
        version: be_u32   >>

        (GitIndex { version: version })
));
