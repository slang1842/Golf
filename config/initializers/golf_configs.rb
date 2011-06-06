# Be sure to restart your server when you modify this file.


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Golf::Application.config.session_store :active_record_store

FORM_SEX = { "female" => "f", "male" => "m" }
RIGHT_HANDED = { "Righthander" => true, "Lefthander" => false }
MEASUREMENT = { "Meters" => "meters", "Foots" => "foots" }
TEMPERATURE = { "Celsium" => "celsium", "Fahrenheit" => "fahrenheit"}
START_PLACE_COLORS = { "Red" => 1, "Green" => 2, "Black" => 3, "Yellow" => 4, "None" => 0 }
GREEN_QUALITY = { "Bad" => 1, "Medium" => 2, "Uber" =>3}
FIELD_QUALITY = { "Bad" => 1, "Medium" => 2, "Uber" =>3}
WEATHER = { "Normal" => 1, "Wind" => 2, "Rain" => 3, "Wind and Rain" => 4}
GAME_FORMAT = { "Training" => "t", "DM" => "d", "Tournament" => "tn"}
GAME_TYPE = { "1-9" => 1, "10-18" => 2, "1-18" => 3}
STATISTICS_MISDIRECTION = {"Hook" => 1, "Drow" => 2, "Straigth" => 3, "Fade" => 4, "Slice" => 5 }
STATISTICS_HIT_WAS = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_MOTION_WAS = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_FOLLOWING_ACTION = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_DIFFICULTY = { "Easy" => 1, "Medium" => 2, "Hard" => 3}

MAIN_STATISTIC_BAD_SIMBOL = "N/V"
MAIN_STATISTIC_BAD_PROC = 45 # these are % to show red bar and hint
#
# !!! WARNING !!!
# ========================================================
# statistics must be specified as this for statistics to
# work correctly .!!!!!
# ========================================================
PLANNED_LAND_PLACES = {"Green" => 1,"Fairway" => 3, "Next fairway" => 4,"Raf" => 6, "For green" => 7, "Fairway sand" => 8, "Green sand" => 9, "Hole" => 11, "Semi raf" => 5 }
STATISTICS_PLACE_FROM = {"Green" => 1, "Teebox" => 2, "Fairway" => 3, "Next fairway" => 4, "Semi raf" => 5, "Raf" => 6, "For green" => 7, "Fairway sand" => 8, "Green sand" => 9, "Wood" => 10, "From water" => 11 }
PLANNED_LAND_PLACES_FOR_PRINT = { 1 => "Green",3 => "Fairway",  4 => "Next fairway", 6  => "Raf",   7 => "For green",  8  => "Fairway sand",  9  => "Green sand",   11 => "Hole",   5 => "Semi raf"}
STATISTICS_STANCE = {"Normal" => 1, "Right leg lower" => 2, "Left leg lower" => 3, "Ball lower" => 4, "Ball higher" => 5}
STATISTICS_DIRECTION = {"Straigth" => 1, "Fade" => 2, "Drow" => 3, "Slice" => 4, "Hook" => 5 }
STATISTICS_TEMPERATURE = {"Hot" => 1,"Normal" => 2,"Cold" => 3}
STATISTICS_TRAJECTORY = { "Normal" => 1, "High" => 2, "Low" => 3 }
STATISTICS_WIND = {"From behind" => 1, "From front" => 2, "From right" => 3, "From left" => 4}



