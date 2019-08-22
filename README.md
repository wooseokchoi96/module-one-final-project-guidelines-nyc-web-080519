# Anime Query Machine

Hello! Welcome to Anime Query Machine.
This is a basic CRUD CLI database application where you can create reviews and search for anime.
The API we used for this application is Jikan.moe, which is an open-source API that sources and parses data from (https://myanimelist.net)
For documentation and a link to the API: (https://jikan.moe/)
Jikan.moe is written in PHP, so we had to use a Ruby wrapper: (https://github.com/Zerocchi/jikan.rb)


## Project
We have three models for this project: User, Anime, Review
* As a user, I can login with a username and password
* As a user, I can sing up and create an account
* As a user, I can see all my written reviews
* As a user, I can create a review
* As a user, I can read a review 
* As a user, I can update a review
* As a user, I can delete a review
* As a user, I can search for an anime and read a random review for that anime

## Install Instructions
```
bundle
rake db:migrate
rake db:seed
ruby bin/run.rb
```


5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   

