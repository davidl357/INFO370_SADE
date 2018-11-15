library(dplyr)
library(ggplot2)

target.listings <- read.csv('80ratinglistings.csv', stringsAsFactors = FALSE)

# graph of ratings among the listings above 80 rating
rating.graph <- ggplot(data = target.listings) + 
  geom_bar(mapping = aes(x = review_scores_rating, color = "black", fill = "blue")) +
  ggtitle("Total Number of Reviews Above 80") +
  labs(x = "Review Scores", y = "Count") +
  theme(legend.position = "none")

plot(rating.graph)

# graph of cleaniness among the listings above 80 rating
cleanliness <- ggplot(data = target.listings) +
  geom_bar(mapping = aes(x = review_scores_cleanliness, color = "black", fill = "blue")) +
  ggtitle("Cleanliness Rating based on Reviews for Listings Rated 80 or Above") +
  labs(x = "Cleaniless Score (out of 10)") +
  theme(legend.position = "none")

plot(cleanliness)

# graph of the correlation between listing score and number of reviews
num.reviews <- ggplot(data = target.listings) +
  geom_point(mapping = aes(y = review_scores_rating, x = number_of_reviews, color = review_scores_rating)) +
  ggtitle("Number of Reviews to Review Rating for Ratings 80 and Up") +
  labs(y = "Listing Rating", x  = "Number of Reviews")

plot(num.reviews)

# linear regression rating vs. price
# linear regression rating vs. location

