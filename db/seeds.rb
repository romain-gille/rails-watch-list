# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Bookmark.delete_all
Movie.delete_all
List.delete_all


# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)




require 'nokogiri' # gem to handle html
require 'open-uri' # gem to open websites

def fetch_movies_urls(x)
  # define the link where to fetch info from
  imdb_top_movies_url = 'https://www.imdb.com/chart/top'
  html_file = URI.open(imdb_top_movies_url, 'Accept-Language' => 'en-US').read
  # open that link and read the html
  html_doc = Nokogiri::HTML(html_file)
  css_selector = '.lister-list td.titleColumn a'

  # search for the href of the first five movies
  result = []
  html_doc.search(css_selector).first(x).each do |element|
    # p element.text.strip
    href = element.attribute('href').value
    url = "http://www.imdb.com#{href}"
    result << url
  end

  # return an array with the first 5 urls
  return result
end

# MAIN CSS SELECTORS -
# Tags / Classes      / IDs
# h1   / .btn-primary / #header

def scrape_movie(movie_url)
  # we open the url
  html_file = URI.open(movie_url, 'Accept-Language' => 'en-US').read
  # we create the html doc
  html_doc = Nokogiri::HTML(html_file)
  # we find the right css for each of the criteria
  title = html_doc.search('h1').text.strip
  if html_doc.search("p[class*='GenresAndPlot__Plot'] span").size > 0
  storyline = html_doc.search("p[class*='GenresAndPlot__Plot'] span").first.text.strip
  else
    storyline = "Not there yet"
  end
  poster_url = html_doc.search('.ipc-media img').first.attribute('src').value
  rating = html_doc.search('.ipc-button__text span').first.text

  {
    title: title,
    overview: storyline,
    poster_url: poster_url,
    rating: rating
  }
end

puts "Fetching movies urls"
top50_movie_urls = fetch_movies_urls(50)

top50_movie_urls.each do |movie_url|
  puts "Creating #{movie_url}"
  Movie.create! scrape_movie(movie_url)
end

puts "All movies created!"


List.create(name: "Action", picture_url: "https://images.unsplash.com/photo-1520371764250-8213f40bc3ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1548&q=80")
List.create(name: "Adventure", picture_url: "https://images.unsplash.com/photo-1452421822248-d4c2b47f0c81?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1548&q=80")
List.create(name: "Horror", picture_url: "https://images.unsplash.com/photo-1505635552518-3448ff116af3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80")
List.create(name: "Love", picture_url: "https://images.unsplash.com/photo-1494774157365-9e04c6720e47?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")
Bookmark.create(comment: "Action a fond", movie_id: Movie.first.id, list_id: List.first.id)
