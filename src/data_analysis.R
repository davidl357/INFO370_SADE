library(dplyr)
library(ggplot2)
library(corrplot)

target.listings <- read.csv('../data/target_clean_listings.csv', stringsAsFactors = FALSE)
all.listings <- read.csv('../data/clean_listings.csv', stringsAsFactors = FALSE)
listings <- read.csv('../data/listings.csv', stringsAsFactors = FALSE)


# function to calculate the mode of data
mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# graphs of ratings among all listings
all.listings <- ggplot(data = listings) +
  geom_bar(mapping = aes(x = review_scores_rating)) +
  ggtitle("Distribution of Reviews Among All Listings") +
  labs(x = "Review Scores", y = "Frequency")

plot(all.listings)

mean.target.listings <- mean(target.listings$review_scores_rating)
mode.target.listings <- mode(target.listings$review_scores_rating)

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
  labs(x = "Cleanliness Score (out of 10)") +
  theme(legend.position = "none")

plot(cleanliness)

# graph of the correlation between listing score and number of reviews
num.reviews <- ggplot(data = target.listings) +
  geom_point(mapping = aes(y = review_scores_rating, x = number_of_reviews, color = review_scores_rating)) +
  ggtitle("Number of Reviews to Review Rating for Ratings 80 and Up") +
  labs(y = "Listing Rating", x  = "Number of Reviews")

plot(num.reviews)

par(mfrow=c(1,2))

# density plot of number of reviews score
d <- density(na.omit(target.listings$number_of_reviews))
plot(d, main = "Density Plot of Number of Reviews", xlab = "Number of Reviews")
polygon(d, col="red", border="black")

# density plot of price
e <- density(na.omit(target.listings$price))
plot(e, main = "Density Plot of Price", xlab = "Price")
polygon(e, col="red", border="black")

# linear regression rating vs. price
priceLM <- lm(review_scores_rating ~ number_of_reviews, data=all.listings)
plot(x=all.listings$number_of_reviews, y=all.listings$review_scores_rating, xlab="Price", ylab="Review Score", main="")
abline(priceLM, col="red")
# linear regression rating vs. location
reviewCountLM

#correlation plot using variables from forward selection
corrplot(cor(select(target.listings, Shampoo, FireExtinguisher, Petsliveonthisproperty, SafetyCard, TV,
                    FreeParkingonPremises, accommodates, price, CarbonMonoxideDetector, bathrooms,
                    AirConditioning, HotTub, LaptopFriendlyWorkspace, Internet, WirelessInternet, 
                    SuitableforEvents, IndoorFireplace, number_of_reviews, PetsAllowed, 
                    Washer.Dryer), use = "complete.obs"), na.label = "o")

