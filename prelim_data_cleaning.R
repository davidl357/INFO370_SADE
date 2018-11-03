library(dplyr)
library(ggplot2)


# reads in the listings.csv gathered from the Kaggle Seattle Airbnb Open Data (https://www.kaggle.com/airbnb/seattle)
listings.data <- read.csv('listings.csv', stringsAsFactors = FALSE)

# gets the columns of interest from the raw data
listings <- select(listings.data, id, name, summary, space, description, neighborhood_overview, notes, transit,  host_response_time,  street,  neighbourhood_cleansed,  latitude,  longitude,  room_type,  accommodates,  bathrooms,  bedrooms,  beds,  bed_type,  amenities,  price,  security_deposit,  cleaning_fee,  number_of_reviews,  review_scores_rating,  review_scores_cleanliness,  review_scores_checkin,  review_scores_communication,  review_scores_location,  review_scores_value,  cancellation_policy)

# gets only the listings that have a rating of 80 or above
target.listings <- filter(listings, listings$review_scores_rating >= "80")

# graph of ratings among the listings above 80 rating
rating.graph <- ggplot(data = target.listings) + 
                      geom_bar(mapping = aes(x = review_scores_rating, color = "black", fill = "blue")) +
                      ggtitle("Total Number of Reviews Above 80") +
                      labs(x = "Review Scores", y = "Count") +
                      theme(legend.position = "none")

# average for ratings 80 and above
ratings.mean <- mean(target.listings$review_scores_rating)

# median for ratings 80 and above
ratings.median <- median(target.listings$review_scores_rating)

# function to find mode
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# mode for ratings 80 and above
ratings.mode <- getmode(target.listings$review_scores_rating)

# graph of cleaniness among the listings above 80 rating
cleanliness <- ggplot(data = target.listings) +
                      geom_bar(mapping = aes(x = review_scores_cleanliness, color = "black", fill = "blue")) +
                      ggtitle("Cleanliness Rating based on Reviews for Listings Rated 80 or Above") +
                      labs(x = "Cleaniless Score (out of 10)") +
                      theme(legend.position = "none")

# graph of the correlation between listing score and number of reviews
num.reviews <- ggplot(data = target.listings) +
                      geom_point(mapping = aes(y = review_scores_rating, x = number_of_reviews, color = review_scores_rating)) +
                      ggtitle("Number of Reviews to Review Rating for Ratings 80 and Up") +
                      labs(y = "Listing Rating", x  = "Number of Reviews")

plot(rating.graph)

plot(cleanliness)

plot(num.reviews)

reviews.data <- read.csv('reviews.csv', stringsAsFactors = FALSE)

reviews <- select(reviews.data, id, reviewer_id, comments)
