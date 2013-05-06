require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'net/http'

set :public_folder, File.dirname(__FILE__) + '/static'

use BetterErrors::Middleware
BetterErrors.application_root = File.expand_path("..", __FILE__)

class MerriamWebster
  extend Mixlib::Config
end

Dir.glob(File.dirname(__FILE__) + '/initializers/*.rb').each do |lib|
 require(lib)
end

get '/' do
  "<h3>please direct visit /:word url</h3>"
end

get '/:word' do
  @word = params[:word]
  @mw = mw(@word)
  slim :index
end

def mw(word)
  raise 'please set your merriam-webster api_key' unless MerriamWebster.api_key

  url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}"
  url = URI.parse(url)
  url.query = URI.encode_www_form({ :key => MerriamWebster.api_key })
  body = Net::HTTP.get(url)

  parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
  list = parser.parse(body)
  mw = list[:entry_list][:entry]
  mw = mw.first if mw.class == Array
  f = mw[:sound][:wav]
  mw[:sound_url] = "http://media.merriam-webster.com/soundc11/#{f[0]}/#{f}"
  mw
end
