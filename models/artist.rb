require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'] if options['id']
  end

#CREATE
  def save()
    sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    ) RETURNING *"
    values = [@name]
    artist = SqlRunner.run(sql, values)
    @id = artist[0]['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    albums.map {|album| Album.new(album)}

  end

#READ
  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    artists.map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


end
