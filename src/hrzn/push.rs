pub mod push {
    use std::fs;
    use log::{error, warn, info, debug, trace};
    use colog;
    use std::path::Path;

    colog::init();

    pub fn push (file: &Path) -> std::io::Result<()> {
        let external = Path::new("/external-storage/");
        // check if file is a directory
        if file.is_file() {
            error!("{} is a directory, please hand over a file.", file.display());
        }

        info!("Copying {} to external storage", file.display());
        fs::copy(file, external)?;

        info!("Creating and comparing checksums");
        let origin_md5 = md5::compute(file);
        let external_md5 = md5::compute(external);
        Ok(())
    }
}