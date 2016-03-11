# spinner-sinatra-assessment
Spinner for Discogs tracks how you use your vinyl collection. 


All users can see the library (it's seeded with a portion of my collection) and all users can inspect album details-and even import the tracklisting if they want. To spin an album, though, or to add it to your collection, edit or delete it, you must be logged in. 

At present, it comes with a datase seeded from my Discogs collection, using the CSV file downloaded from the site. The code in db/seeds.rb is tailored specifically do Discogs' database setup. It contains information useful for linking this Album's entry in the database to a specific version of the album. This is useful for importing an accurate tracklisting. If that's not important to you, then the link from the library page (/all-albums) will take you to the Discogs search results. 

Albums don't come automatically with tracklisting. They aren't stored that way in Discogs; instead, you either go to the "master release" page or if, like I did, you seed it with your own collection, you can use the individual release ID to take you to the page for that specific release. If you don't add an album this way, the process is fiddlier. If I refactor, I'll fix this. 




