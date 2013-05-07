require 'rubygems'
require 'sqlite3'
require 'mixlib/config'
require 'nori'

class MerriamWebster
  extend Mixlib::Config
end

require 'net/http'
require './initializers/merriam_webster.rb'

def output(word, t = 3)
  filename = load_by_url(word)
  `play -q tmp/audio/#{filename}`
  sleep t 
end


def load_by_url(word)
  begin
    db = SQLite3::Database.new 'tmp/audio/words.db'
    db.execute 'CREATE TABLE IF NOT EXISTS Words(Word TEXT, File TEXT)'

    stm = db.prepare "SELECT * FROM Words WHERE Word = '#{word}' LIMIT 1" 
    rs = stm.execute

    rs.each do |row|
      return row.last if File.exists?("tmp/audio/#{row.last}")
    end

    url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}"
    url = URI.parse(url)
    url.query = URI.encode_www_form({ :key => MerriamWebster.api_key })
    body = Net::HTTP.get(url)

    parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
    list = parser.parse(body)
    mw = list[:entry_list][:entry]
    mw = mw.first if mw.class == Array
    raise 'unknown word' unless mw
    f = mw[:sound][:wav]
    f = f.first if f.class == Array

    unless File.exists?("tmp/audio/#{f}")
      `wget http://media.merriam-webster.com/soundc11/#{f[0]}/#{f} -O tmp/audio/#{f}`
    end

    db.execute "INSERT INTO Words VALUES('#{word}', '#{f}')"

    f
  rescue SQLite3::Exception => e 
    puts "Exception occured"
    puts e
  ensure
    stm.close if stm
    db.close if db
  end
end
