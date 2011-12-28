# Be sure to restart your server when you modify this file.


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Golf::Application.config.session_store :active_record_store

FORM_SEX = { "female" => "f", "male" => "m" }
RIGHT_HANDED = { "Righthander" => true, "Lefthander" => false }
MEASUREMENT = { "Meters" => "m", "Feet" => "ft", "Yards" => "yd" }
TEMPERATURE = { "Celsium" => "celsium", "Fahrenheit" => "fahrenheit"}
START_PLACE_COLORS = { "Red" => 1, "Green" => 2, "Black" => 3, "Yellow" => 4, "None" => 0 }
START_PLACE_COLORS_USER = { "Red" => 1, "Green" => 2, "Black" => 3, "Yellow" => 4}
GREEN_QUALITY = { "Bad" => 1, "Medium" => 2, "Uber" =>3}
FIELD_QUALITY = { "Bad" => 1, "Medium" => 2, "Uber" =>3}
WEATHER = { "Normal" => 1, "Wind" => 2, "Rain" => 3, "Wind and Rain" => 4}
GAME_FORMAT = { "Training" => "t", "DM" => "d", "Tournament" => "tn"}
GAME_TYPE = { "1-9" => 1, "10-18" => 2, "1-18" => 3}
STATISTICS_MISDIRECTION = {"More to left" => 1, "To left" => 2, "Straight" => 3, "To right" => 4, "More to right" => 5 }
STATISTICS_HIT_WAS = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_MOTION_WAS = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_FOLLOWING_ACTION = { "Under" => 1, "Miss" => 2, "Normal" => 3, "Top" => 4 }
STATISTICS_DIFFICULTY = { "Easy" => 1, "Medium" => 2, "Hard" => 3}

MAIN_STATISTIC_BAD_SIMBOL = "N/V"
MAIN_STATISTIC_BAD_PROC = 45 # these are % to show red bar and hint

SLIPUMS = {"Straight" => 1, "To right" => 2, "To left" => 3, "More to right" => 4, "More to left" => 5}
KRITUMS = {"Straight" => 1, "Upward" => 2, "Downward" => 3, "Very upward" => 4, "Very downward" => 5}
STRENGTH = {"Light" => 1, "Normal" => 2, "Strong" => 3, "Very strong" => 4}
MISTAKE = {"None" => 1, "Too close" => 2, "Too far" => 3, "Very close" => 4, "Very far" => 5}


STICK_DEGREES = {"10x" => 1, "15x" => 2, "20x" => 3, "25x" => 4}
STICK_SHAFT = {"Wood" => 1, "Metal" => 2, "Plastic" => 3}
STICK_SHAFT_STRENGTH = {"Strong" => 1, "Very Strong" => 2, "Medium" => 3}

STICK_DEGREES_rev = {1 => "10x", 2 => "15x", 3 => "20x", 4 => "25x"}
STICK_SHAFT_rev = {1 => "Wood", 2 => "Metal", 3 => "Plastic"}
STICK_SHAFT_STRENGTH_rev = { 1 => "Strong", 2 => "Very Strong", 3 => "Medium"}

BALL_MANUFACTURER = {"ADIDAS" => 1, "Balls Masters" => 2, "Other" => 3}
BALL_TYPE = {"apaļa" => 1, "zaļa" => 2, "oranža" => 3}

# !!! WARNING !!!
# ========================================================
# statistics must be specified as this for statistics to
# work correctly .!!!!!
# ========================================================
#PLANNED_LAND_PLACES = {"Green" => 1,"Fairway" => 3, "Next fairway" => 4,"Raf" => 6, "For green" => 7, "Fairway sand" => 8, "Green sand" => 9, "Hole" => 11, "Semi raf" => 5 }
PLANNED_LAND_PLACES = {"Green" => 1,"Fairway" => 3, "Next fairway" => 4,"Raf" => 6, "For green" => 7, "Fairway sand" => 8, "Green sand" => 9, "Hole" => 11, "Semi raf" => 5 }
STATISTICS_PLACE_FROM = {"Green" => 1, "Teebox" => 2, "Fairway" => 3, "Next fairway" => 4, "Semi raf" => 5, "Raf" => 6, "For green" => 7, "Fairway sand" => 8, "Green sand" => 9, "Wood" => 10, "From water" => 11 }
PLANNED_LAND_PLACES_FOR_PRINT = { 1 => "Green",3 => "Fairway",  4 => "Next fairway", 6  => "Raf",   7 => "For green",  8  => "Fairway sand",  9  => "Green sand",   11 => "Hole",   5 => "Semi raf"}
STATISTICS_STANCE = {"Normal" => 1, "Right leg lower" => 2, "Left leg lower" => 3, "Ball lower" => 4, "Ball higher" => 5}
STATISTICS_DIRECTION = {"Straight" => 1, "Fade" => 2, "Drow" => 3, "Slice" => 4, "Hook" => 5 }
STATISTICS_TEMPERATURE = {"Hot" => 1,"Normal" => 2,"Cold" => 3}
STATISTICS_TRAJECTORY = { "Normal" => 1, "High" => 2, "Low" => 3 }
STATISTICS_WIND = {"From behind" => 1, "From front" => 2, "No wind" => 3, "From right" => 4, "From left" => 5}
PLANNED_LAND_PLACES_SHORT = {"Green" => 1, "Fairway" => 3, "Hole" => 11}
DIRECTION_SHORT = {"Straight" => 1, "To right" => 2, "More to right" => 4, "To left" => 3, "More to left" => 5}
LUCK_FACTOR = {"No luck" => 1, "Very bad" => 2, "Bad luck" => 3, "Lucky" => 4, "Very lucky" => 5}
