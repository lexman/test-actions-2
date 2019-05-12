workflow "Test" {
  on = "watch"
  resolves = [
    "Crop to IDF"
  ]
}

action "Download" {
  uses = "byrnedo/docker-alpine-curl@master"
  runs = "curl https://download.openstreetmap.fr/extracts/europe/france-latest.osm.pbf --output france-latest.osm.pbf"
}

action "Crop to IDF" {
  needs = [
    "Download"
  ]
  uses = "pfisterer/openstreetmap-osmosis-docker@master"
  args = "--read-pbf france-latest.osm.pbf --bounding-box top=49.26 left=1.425 bottom=48.1 right=3.58 --write-pbf planet-idf.osm.pbf"
}
