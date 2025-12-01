provide *
provide-types *

# DO NOT CHANGE ANYTHING ABOVE THIS LINE

AGE = 20
LIVES-IN = "oatman"
JOB = "shoemaker"

#PART 1A
fun within-5(num :: Number) -> Boolean:
  (num > 15) or (num < 25)
where: within-5(18) is true
end 

fun works-with(job-base :: String) -> Boolean:
  string-contains("shoemaker", job-base)
where:
  works-with("shoemaker") is true
  works-with("shumacher")is false
end

#|add a comment (1-2 sentences) explaining why works-with is a useful function to create. What is the purpose of it? 

As a string-contains function, 'works-with' is useful to match inputs with the job descriptiion. That way, instead of continuously writing individual "==" boolean tests, inputs can be loaded into the function, and the function can be looped to search against a bunch of inputs, making it more efficient.|#


fun is-town(place :: String) -> Boolean:
  string-contains("abilene, durango, oatman, dallas", place)
where:
  is-town("abilene") is true
  is-town("san antonio") is false
  is-town("los angeles") is false
  is-town("durango") is true
end


fun place-type-matches(place-type :: String) -> Boolean:
  if place-type == "town":
    is-town(LIVES-IN)   
  else:
    false
  end
  where: 
    is-town(LIVES-IN) is true
    is-town("oatman") is true
end

#PART 1B
fun show-ad(target-age :: Number, job-area :: String, place-type :: String) -> Boolean:
  doc: "This tests run, and I thought I targeted the right inputs, but after changing the number  and capitalization for the strings, I can't seem to find what the buggy programs might be."
  if within-5(target-age)
    and works-with(job-area)  
    and place-type-matches(place-type):
    true
    else:
    false  
end
end

#PART 1C
fun show-ad2(ad-text :: String) -> Boolean:
  ((string-contains(ad-text, "young")) and (AGE <= 35)) or 
  ((string-contains(ad-text, "retire")) and (AGE >= 65)) or 
  ((place-type-matches("town")) and (string-contains(ad-text, "nightclub")))
end
 
#PART 1D

#Write your answers to the Part 1D questions here 

#|Real ads are more sophisticated and complex, often incorporating cookies and SEO strategies to deliver targeted advertising. This becomes extremely effective when users are not actively searching, but are browsing on social media or spending time on sites like Youtube. The current limitations of our code/operations is that we have to write out all the searchable criteria before we can pass in a possible case sensitive input (String or Number). This is highly ineffective, especially when we can't change the range of ages or easily add job areas. To do a better job, edge cases should be incorporated so the function catches errors. In terms of sophistication, there should be more extensive non-case sensitive information types to identify specific target audiences.|#

# Write your four test cases here

check:
  show-ad(1.1, "design", "new york")
  show-ad(-100, "sales/marketing", "boston")
  show-ad2("this posting are for interns from the ages of 21 to 28! if your city doesn't have much of a nightlife scene, check out the new job openings at 'Louie's' downtown!") 
  show-ad2("If you're recently retired and are looking to pick up new skills, look no further because this skillsFuture class is here for you.")
end

# PART 2

fun length-type(text :: String) -> Number:
  doc: "Checks text length ranges against short, medium, and long to determine length type"
  shorter-than-short = 0
  short-length = 10
  medium-length = 40
  long-length = 70
  if (string-length(text) < short-length):
    shorter-than-short 
  else if ((string-length(text) >= short-length) or (string-length(text) < medium-length)):
    short-length
  else if ((string-length(text) >= medium-length) or (string-length(text) < long-length)):
    medium-length
  else if (string-length(text) > long-length): long-length
  end
end

fun ad-charge(text) -> Number:
  doc: "Takes length type from previous function and computes the numeric outcome."
  if length-type(text) > 0:
    (string-length(text) * (length-type(text) / 2)) + (string-length(text) * 5)  
  else: 0
  end
where:
  ad-charge("Go Bruno!") is 0
  ad-charge("Apply to Brown") is 140
  ad-charge("Computer Science") is 160
end

# PART 3 

#|Individuals and families could download and subscribe to services such as ExpressVPN or Nord VPN that encrypts their web traffic and masks their IP addresses. While this wouldn't prevent the more insidious data collection on social media platforms such as Facebook (as elaborated in the NYT article), it would better obscure a user's digital footprints and have long-term implications on a users' data integrity and privacy.|#

