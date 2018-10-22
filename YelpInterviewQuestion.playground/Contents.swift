/**
 This is an interview question asked by Yelp via HackerRank.
 */

/**
 A time range between 0 and 24 hours.
 */
struct TimeRange {
    let start : Double
    let end   : Double
}

/**
 A restaurant with its opening hours.
 For instance:
 - [0-24]
 - [7-13, 16-22]
 */
struct Restaurant {
    let openingTimes : [TimeRange]
}

/**
 Given a restaurant with its opening hours and a query, returns the ratio of
 hours the restaurant was open over the duration of the query range.
 - Example: A restaurant is open 9-17, and the user's query is 7-11: we will
 return 0.5, because the restaurant was open for 50% of the query range.
 */
func openRatio(restaurant: Restaurant, query: TimeRange) -> Double {
    var timeOpened = 0.0
    let total = query.end - query.start
    for time in restaurant.openingTimes {
        if time.start <= query.start && time.end >= query.end {
            timeOpened += query.end - query.start
        } else if time.end >= query.start && time.start <= query.start {
            timeOpened += time.end - query.start
        } else if time.end >= query.end && time.start <= query.end {
            timeOpened += query.end - time.start
        } else if time.end <= query.end && time.start >= query.end {
            timeOpened += time.end - time.start
        }
    }
    return timeOpened / total
}

// Test cases

// Case 1
let query1 = TimeRange(start: 4, end: 10)
let oh1 = TimeRange(start: 0, end: 24)
let restaurant1 = Restaurant(openingTimes: [oh1])
assert(openRatio(restaurant: restaurant1, query: query1) == 1)

// Case 2
let query2 = TimeRange(start: 7, end: 11)
let oh2 = TimeRange(start: 9, end: 17)
let restaurant2 = Restaurant(openingTimes: [oh2])
assert(openRatio(restaurant: restaurant2, query: query2) == 0.5)

// Case 3
let query3 = TimeRange(start: 0, end: 24)
let oh3 = TimeRange(start: 0, end: 2)
let oh4 = TimeRange(start: 20, end: 24)
// Check for multiple opening hours
let restaurant3 = Restaurant(openingTimes: [oh3, oh4])
assert(openRatio(restaurant: restaurant3, query: query3) == 0.25)

// Case 4
let query4 = TimeRange(start: 9, end: 12)
let oh5 = TimeRange(start: 7, end: 10)
let oh6 = TimeRange(start: 11, end: 15)
// Check for multiple opening hours
let restaurant4 = Restaurant(openingTimes: [oh5, oh6])
assert(openRatio(restaurant: restaurant4, query: query4) == 2/3)
