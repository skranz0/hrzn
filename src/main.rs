mod hrzn;

use clap::{Arg, Command, ArgAction};
use log::{error, warn, info, debug, trace};


fn main() {
    let matches = Command::new("hrzn")
        .version("0.1r")
        .author("Stefan Kranz")
        .subcommand(Command::new("push")
            .about("Push a file to an external storage")
            .arg(
                Arg::new("file")
                    .value_name("FILE")
                    .help("The file to push")
                    .required(true)
                    .action(ArgAction::Set)
            ))
        .subcommand(Command::new("pull")
            .about("Pull a file from external storage")
            .arg(
                Arg::new("VERGE")
                    .value_name("verge-file")
                    .help("The verge file to pull")
                    .required(true)
                    .action(ArgAction::Set)
            ))
        .subcommand(Command::new("move")
            .about("Change the origin path in a verge file")
            .arg(
                Arg::new("verge-file")
                    .value_name("VERGE")
                    .help("Verge file to change.")
                    .required(true)
                    .action(ArgAction::Set)
            )
            .arg(
                Arg::new("new-path")
                    .value_name("PATH")
                    .long("new-path")
                    .short('n')
                    .help("New origin path")
                    .required(true)
                    .action(ArgAction::Set)
            ))
        .get_matches();

    match matches.subcommand() {
        Some(("push", sub_matches)) => {
            if let Some(file) = sub_matches.get_one::<String>("file") {
                push(file);
            }
        }
        Some(("pull", sub_matches)) => {
            if let Some(file) = sub_matches.get_one::<String>("verge-file") {
                pull(file);
            }
        }
        Some(("move", sub_matches)) => {
            if let (Some(file), Some(path)) = (
                sub_matches.get_one::<String>("verge-file"),
                sub_matches.get_one::<String>("new-path"),
            ) {
                move_origin(file, path);
            }
        }
        _ => error!("Command not recognized"),
    }
}

fn push(file: &str) {
    println!("Pushing file {}", file);
}

fn pull(verge_file: &str) {
    println!("Pulling verge file {}", verge_file);
}

fn move_origin(verge_file: &str, new_path: &str) {
    println!("Moving origin file {} to {}", verge_file, new_path);
}
