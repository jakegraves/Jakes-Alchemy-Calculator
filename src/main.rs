extern crate iron;

use iron::prelude::*;
use iron::mime::Mime;
use iron::status;

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
    Iron::new(ingredients).http("localhost:3000").unwrap();
}
