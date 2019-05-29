require_relative('../db/sql_runner')

class Album

attr_reader :id, :artist_id
attr_accessor :title, :genre

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

#CREATE
  def save()
    sql = "INSERT INTO albums
    (
      title, genre, artist_id
    )
    VALUES
    (
      $1, $2, $3
    ) RETURNING * "
    values = [@title, @genre, @artist_id]
    album = SqlRunner.run(sql, values)
    @id = album[0]['id'].to_i
  end

#UPDATE
  def update()
    sql = "UPDATE albums SET
    (
      title, genre, artist_id
    )
    =
    (
      $1, $2, $3
    ) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)

  end

#READ
  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)
    return artist[0]
  end



#READ
  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    albums.map {|album| Album.new(album)}
  end

#DELETE

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

#READ
  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result[0]
  end
end
