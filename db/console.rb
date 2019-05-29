require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => "Bob Dylan"})

artist1.save()

album1 = Album.new({'title' => 'Blonde on Blonde', 'genre' => 'Rock', 'artist_id' => artist1.id})
album2 = Album.new({'title' => 'Blood on the Tracks', 'genre' => 'Rock', 'artist_id' => artist1.id})

album1.save()
album2.save()


binding.pry
nil
