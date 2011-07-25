

function GetStats(Place, Stance, Direction, Temperature, Weather, Trajectory, Wind) {

  var place_v
  var stance_v
  var direction_v
  var temperature_v
  var wheater_v
  var trajectory_v
  var wind_v


  if (place == "Teebox") {
    place_v = "place_teebox"
  }
  else if (place == "Fairway") {
    place_v = "place_fairway"
  }
  else if (place == "Next Fairway") {
    place_v = "place_next_fairway"
  }
  else if (place == "Femi Raf") {
    place_v = "place_femmi_raf"
  }
  else if (place == "Raf") {
    place_v = "place_raf"
  }
  else if (place == "For Green") {
    place_v = "place_for_green"
  }
 else if (place == "Fairway Sand") {
    place_v = "place_fairway_sand"
  }
 else if (place == "Green Sand") {
    place_v = "place_freen_sand"
  }
 else if (place == "Wood") {
    place_v = "place_wood"
  }
 else if (place == "From Water") {
    place_v = "place_from_water"
  }
  else { 
    place = false
  }











}
