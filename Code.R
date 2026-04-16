
# Load libraries
library(tidyverse)
library(tidytext)
library(wordcloud)
library(textdata)

# Create dataset
data <- data.frame(
  text = c(
    "I love this product",
    "This is the worst experience ever",
    "Amazing service and friendly staff",
    "I hate this app",
    "Not bad, could be better",
    "Absolutely fantastic!"
  )
)

# Convert text into words
words <- data %>%
  unnest_tokens(word, text)

# Remove common stopwords (cleaner output)
words <- words %>%
  filter(!word %in% stop_words$word)

# Get sentiment data
sentiments <- get_sentiments("bing")

# Join words with sentiment
sentiment_data <- words %>%
  inner_join(sentiments, by = "word")

# Count positive vs negative
result <- sentiment_data %>%
  count(sentiment)

print(result)

# Plot graph
ggplot(result, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Sentiment Analysis Result")

# Create word frequency
word_freq <- words %>%
  count(word, sort = TRUE)

# Better wordcloud (correct way)
wordcloud(
  words = word_freq$word,
  freq = word_freq$n,
  max.words = 50,
  colors = rainbow(10)
)

