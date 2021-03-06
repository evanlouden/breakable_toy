![Build Status](https://codeship.com/projects/93141260-e8b8-0133-1109-0a601490f276/status?branch=master)
[![Code Climate](https://codeclimate.com/github/evanlouden/breakable_toy/badges/gpa.svg)](https://codeclimate.com/github/evanlouden/breakable_toy)
[![Coverage Status](https://coveralls.io/repos/github/evanlouden/breakable_toy/badge.svg?branch=master)](https://coveralls.io/github/evanlouden/breakable_toy?branch=master)

Golf is a great game but in decline. Lots of people have their opinions on why:

http://www.economist.com/blogs/economist-explains/2015/04/economist-explains-1
http://www.mensjournal.com/magazine/the-death-of-golf-20150625
https://www.washingtonpost.com/news/wonk/wp/2015/03/05/why-america-fell-out-of-love-with-golf/

I have mine...

Today, most players play for a "score" (i.e. 99, 89, 79). As gratifying as it can be to finally break 100 (or 90, or 80), it is much more likely that a golfer will shoot a score right around their average ability.

Golf originated as a game. Like many other games it was meant to be played by two people, against each other. However, at some point "old man par" came in to play and the game switched from a competition between competitors to an individual game against an imaginary (and unbeatable) opponent. Despite the fact that shooting a personal best or playing against "old man par" can be entertaining, there is no substitute for the exciting back and forth that a match between two competitors can provide.

I firmly believe, match play is the most entertaining form of golf and this app is designed with the sole purpose of facilitating just that. Find a friend. Figure out your handicaps. Play a match.

This is an open-source Golf Match Play web app built with Ruby on Rails.

Some of the technologies used in development are: Devise Authentication, Javascript, PostgreSQL, and Foundation CSS.

Users start a match by creating a new match from the menu. The other user can then see and join matches by clicking their username in the menu and clicking on the appropriate match from the list.

The game will auto adjust handicaps of the players for each match and assign strokes based on adjusted handicaps and hole difficulty.

Use the app here: http://golfmatchplay.herokuapp.com


** Note this app is really only functional for two users. For demo purposes you might ask a friend to help. **

** Also this app is styled exclusively for mobile. Use Chrome DevTools' Device Mode for a proper experience on desktop **
