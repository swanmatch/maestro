json.extract! song, :id, :title, :composer, :tempo, :key, :scale, :score, :created_at, :updated_at
json.url song_url(song, format: :json)