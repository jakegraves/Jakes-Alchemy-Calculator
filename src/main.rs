extern crate iron;
extern crate mount;
extern crate logger;
extern crate staticfile;

use std::fs::File;
use std::io::Read;

use iron::prelude::*;
use iron::mime::Mime;
use iron::status;
use mount::Mount;
use logger::Logger;
use staticfile::Static;

fn main() {
    fn ingredients(_: &mut Request) -> IronResult<Response> {
        let mut json_response = String::new();
        let mut f = File::open("data/ingredients.json").unwrap();
        f.read_to_string(&mut json_response).unwrap();
        let content_type = "application/json".parse::<Mime>().unwrap();
        Ok(Response::with((content_type, status::Ok, json_response)))
    }
    let mut mount = Mount::new();
    mount.mount("/", Static::new("web/"));
    mount.mount("/api/", ingredients);
    let mut chain = Chain::new(mount);
    chain.link(Logger::new(None));
    Iron::new(chain).http("localhost:3000").unwrap();
}
