extern crate iron;
extern crate mount;
extern crate staticfile;

use iron::prelude::*;
use iron::mime::Mime;
use iron::status;
use mount::Mount;
use staticfile::Static;

static JSON_RESPONSE: &'static str = "{
    \"ingredients\": [
        {
            \"name\": \"Creep Cluster\",
            \"value\": 1,
            \"weight\": 0.2,
            \"effects\": [
                \"Restore Magicka\",
                \"Damage Stamina Regen\",
                \"Fortify Carry Weight\",
                \"Weakness to Magic\"
            ]
        }
    ]
}";

fn main() {
    fn ingredients(_: &mut Request) -> IronResult<Response> {
        let content_type = "application/json".parse::<Mime>().unwrap();
        Ok(Response::with((content_type, status::Ok, JSON_RESPONSE)))
    }
    let mut mount = Mount::new();
    mount.mount("/", Static::new("web/"));
    mount.mount("/api/", ingredients);
    Iron::new(mount).http("localhost:3000").unwrap();
}
