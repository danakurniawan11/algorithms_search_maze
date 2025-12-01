provide *
provide-types *
include image
include reactors
include gdrive-sheets
include data-source
include shared-gdrive("cs111-2018.arr", "1XxbD-eg5BAYuufv6mLmEllyg28IR7HeX")  
#For tables

AGE = 20

#For part 2
MALARIA-DATA = load-table: age :: Number, dist-from-lake :: Number, pregnancy :: Boolean, 
  contracted-malaria :: Boolean
  source: load-spreadsheet("1x6gcbVteTu3Ic4m4ItZpDJZIJ4rnu4EDlK4Y7zW45KQ")
      .sheet-by-name("m-d", true)
  sanitize age using strict-num-sanitizer
  sanitize dist-from-lake using strict-num-sanitizer
  sanitize pregnancy using bool-sanitizer
  sanitize contracted-malaria using bool-sanitizer
end

# DO NOT CHANGE ANYTHING ABOVE THIS LINE
ad-revenue = table: ad-id :: Number, revenue :: Number
  row: 9, 200
  row: 10, 300
end

ad-info1 = table: ad-id :: Number, target-age :: Number, place-type :: String, job-area :: String, mobile-usage :: String, rides-horses :: Boolean, ad-text :: String
  # Fill in this table!
  row: 0, 18, "", "durango", "sometimes", true, "ad text" 
  row: 1, 20, "", "abilene", "frequently", true, "ad text" 
  row: 2, 21, "", "durango", "never", true, "ad text" 
  row: 3, 19, "", "oatman", "never", true, "ad text" 
  row: 4, 52, "", "durango", "never", true, "ad text" 
  row: 5, 70, "", "durango", "never", true, "ad text" 
  row: 6, 32, "", "oatman", "never", true, "ad text"
  row: 7, 50, "", "durango", "never", true, "ad text" 
  row: 8, 19, "", "abilene", "never", true, "ad text" 
  row: 9, 30, "", "abilene", "never", true, "ad text" 
  row: 10, 40, "", "durango", "sometimes", true, "ad text"
end

# PART 1A
fun within-5(age :: Number, checkAge :: Number) -> Boolean: 
  if ((5 - num-abs(checkAge - age)) >= 0):
    true
  else if age < 0: 
    #2B: make an if statement to handle if num is negative 
    true
  else:
    false
  end
end

fun age-based-ads(age :: Number, ad-info :: Table) -> Table:
  fun age-checker(r :: Row) -> Boolean:
    within-5(r["target-age"], age)
  end
  filter-by(ad-info, age-checker)
end

# PART 1B

fun check-category(r :: Row) -> String:
  age = r["target-age"]
  if (age == 30):
    "30"
  else if ((age >= 31) and (age <= 40)):
    "31-40"
  else if ((age >= 41) and (age <= 50)):
    "41-50"
  else if ((age >= 51) and (age <= 60)):
    "51-60"
  else if (age > 60):
    "older than 60"
  else:
    "not within age ranges"
  end
end

fun show-age-distrib(input :: Table) -> Image:
  doc: "I am using the frequency bar chart method to show the age distribution amongst the different age brackets."
  freq-bar-chart((build-column(input, "age-bracket", check-category)), "age-bracket") 
end

fun show-mobile-proportions(input :: Table) -> Image:
  doc: "I am trying to generate a pie chart that 1) takes age category as an input 2) sorts the age category into never/sometimes/frequently 3) displays their proportion."
  new-table = count(input, "mobile-usage")
  pie-chart(new-table, "value", "count")
end

# Part 1B written answer about an ID vs. revenue scatterplot
# A scatterplot is useful for mapping trends in a given time frame, for example how the different ad revenues compare to each other from month to month. 

fun ad-report(ID :: Number, input :: Table, ID-revenue :: Table) -> String:
  #Reference ad id number -> get text-ad + revenue
  fun right-ID(r :: Row) -> Boolean:
    r["ad-id"] == ID
  end
  updated-table = filter-by(input, right-ID)
  smaller-table = filter-by(ID-revenue, right-ID)
  access-ad-text = updated-table.row-n(0)["ad-text"]
  get-revenue = smaller-table.row-n(0)["revenue"]
  access-ad-text + " generated " + num-to-string(get-revenue)
end

# PART 2

fun similar-people(data-table:: Table, distance-input :: Number, age :: Number, pregnancy-state :: Boolean) -> Table:
  doc: "produces a similar table if distance from lake is within 20, age is within 5, and pregnancy status matches boolean."

  #checking distance
  fun distance-within(r :: Row) -> Boolean:
    (20 - num-abs((r["dist-from-lake"]) - distance-input)) >= 0
  end

  #checking age
  fun age-checker(r :: Row) -> Boolean:
    within-5(r["age"], age)
  end

  #checking pregnancy status
  fun pregnancy-status(r :: Row) -> Boolean:
    r["pregnancy"] == pregnancy-state
  end

  similar-table = filter-by(data-table, distance-within) 
  check-within-5 = filter-by(similar-table, age-checker)
  pregnancy = filter-by(check-within-5, pregnancy-status)
  pregnancy
end


#give-net

fun give-net(similar-table :: Table):
  doc: "If the # of people who got malaria is at least as large as the people who did not, returns true. Otherwise, false."
  malaria-table = count(similar-table, "contracted-malaria")
  fun more-than-1(r :: Row) -> Boolean:
    r["value"] == true
  end
  
  if malaria-table.length() == 0: 
    true
  else:
    if malaria-table.length() == 1:
      malaria-table.row-n(0)["value"] 
    else:
      malaria-true = filter-by(malaria-table, more-than-1).row-n(0)["count"]
      malaria-true >= (malaria-table.length() / 2)
    end
  end
end



