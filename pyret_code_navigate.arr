provide *
provide-types *
include shared-gdrive("cs111-2018.arr", "1XxbD-eg5BAYuufv6mLmEllyg28IR7HeX")  
# For tables

# This is a helper function you may need in other helper functions.
# We recommend you use it, although it is not necessary to run
# the main function, if you choose to not use it.

fun is-even(n :: Number) -> Boolean:
  doc: "Checks if a number is even"
  num-modulo(n, 2) == 0
end

# Giselle's updated information for show-ad
AGE = 20
LIVES-IN = "oatman"
JOB = "shoemaker"
PHONE = "sometimes"
HORSE = true

# DO NOT CHANGE ANYTHING ABOVE THIS LINE

#PART 1

name1 = "<floria,bandit>"
name2 = "<livia,curse>"

fun check-brackets(name :: String) -> Boolean:
  doc: "this function was created to check if the start of the input had < and if the end had the similar >"
  a = string-length(name)
  (string-char-at(name,0) == "<") and (string-char-at(name,a - 1) == ">") 
where:
  check-brackets(name1) is true
  check-brackets(name1) is true
  check-brackets(name2) is true
end

fun check-comma(name :: String) -> Boolean:
  doc: "this helper function checks that the comma is in the middle of the string."
  if not(is-even(string-length(name))):
    string-index-of(name, ",") == (num-floor(string-length(name) / 2))
  else:
    false
end
where: check-comma(name1) is true
  check-comma(name2) is true
end

fun contain-a(name :: String) -> Boolean:
  doc: "this helper function checks if a lowercase a is contained within the input String."
  string-contains(name, "a")  
where: 
  contain-a(name1) is true
  contain-a(name2) is true
end

fun superstitious(name :: String) -> Boolean:
  doc: "this helper function checks if curse is in the input."
  not(string-contains(name, "curse"))
where: 
  superstitious(name1) is true
  superstitious(name2) is false
end
  
fun nickname-check(name :: String) -> Boolean :
  doc: "I use my 4 helper functions to help me test criteeria for success"
  check-brackets(name) and check-comma(name) and contain-a(name) and superstitious(name)
end

  
# PART 2

# Given helper functions for show-ad from hw2 

fun within-5(num :: Number) -> Boolean:
  doc: "determine whether AGE and a number are within 5 of each other, inclusive"
  if ((5 - num-abs(AGE - num)) >= 0):
    true
  else if num < 0: 
  #2B: make an if statement to handle if num is negative 
    true
  else:
    false
  end
  
where:
  within-5(2) is false
  within-5(26) is false
  within-5(23) is true
  within-5(25) is true
  within-5(15) is true
end

fun works-with(job-base :: String) -> Boolean:
  doc: "determines whether JOB contains a string"
  string-contains(JOB, job-base)
where:
  works-with("shoe") is true
  works-with("maker") is true
  works-with("farm") is false
  works-with("") is true
end

fun is-town(place :: String) -> Boolean:
  doc: "determine whether given place is the name of a town"
  (place == "abilene") or (place == "durango") or 
  (place == "oatman") or (place == "dallas")
where:
  is-town("abilene") is true
  is-town("new york") is false
  is-town("") is false
end

fun place-type-matches(place-type :: String) -> Boolean:
  doc: "determine whether the place type of LIVES-IN matches the input"
  if (place-type == "town"): is-town(LIVES-IN)
  else: true
  end
where:
  place-type-matches("city") is true
  place-type-matches("town") is true
end

# Implement your new show-ad helpers here!

fun horses-match(horse :: Boolean) -> Boolean:
  doc: "This helper function reflects whether the horses match."
  horse == HORSE 
end

fun check-phone-usage(phone :: String) -> Boolean:
  doc: "This helper function helps us to output a Boolean that reflects whether the ad's phone usage allowance matches the user's description."
  if phone == "never":
    (PHONE == "never") or (PHONE == "sometimes") or (PHONE == "frequent")
  else if phone == "sometimes":
    (PHONE == "sometimes") or (PHONE == "frequent")
  else if phone == "frequent":
    PHONE == "frequent"
  else:
    false
end
end

fun show-ad(ad-info :: Table) -> Boolean: 
  doc: "In this function I'm using Pyret's table documentation to access the specific columns through the helper functions previously written."
  within-5(ad-info.row-n(0)["target-age"]) and works-with(ad-info.row-n(0)["job-area"]) and place-type-matches(ad-info.row-n(0)["place-type"]) and check-phone-usage(ad-info.row-n(0)["mobile-usage"]) and horses-match(ad-info.row-n(0)["rides-horses"])
end


# 2A written answer for whether to use a function in horse matching
#| Personally, I think horses-match should be its own function, as it is advantagenous in reducing the amount of code if used multiple times within a larger function. If changes are made to the function, it will be reflected in other functions where it is called, making it more efficient. In terms of disadvantages, it is often easy to confuse helper functions when using them in a larger function.|#

# 2B written answer to handle horse matching
#| No, because whether someone rides horses is a Boolean statement, which by definition cannot have a "blank" answer/option because it has to be true or false. There are downsides to taking this approach, which is to further complicate the function unnecessarily.|#

# PART 3

#|Write your paragraph answer to the reading here!
   
   Ethical data collection today takes advantage of the principles the internet was built on -- open dialogue, exploration, and experimentation. Instead of making internet users the client to advertisements, they become the product. Our information is unknowingly mined at an alarming rate, and the full ramifications of this age in 'big data' has still not been deeply considered. As Dr. Zuboff in the NYT article argues, the shift in targeted advertising "happened so quickly and so secretly", leaving the public ill-equipped to fight back. Without sufficient time or information, modern data collection is predicated on manipulation and lack of symmetric information. In my opinion, factors such as sensitivity of the data should be subject to further scrutiny -- for example, gender, race, and income should be confidential and the selling of data should be done so publicly to see the record of transactions. Additionally, data over a certain time period (eg. max 1 month) should not be kept on individuals unless users opt-in.|#
        
# How many hours did you spend on this homework?
# 6-10 hours
