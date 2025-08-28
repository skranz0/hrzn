use clap::Parser;
use log::{error, warn, info, debug, trace};

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    verge_file: String,
}

fn main() {
    let args = Args::parse();

    println!("Hello, world!");
    println!("I will work with the file {} :)", args.verge_file)
}
