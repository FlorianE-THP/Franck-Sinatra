require 'gossip'
require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base
      get '/' do
        erb :index, locals: {gossips: Gossip.all}
      end

      get '/gossips/new/' do
        erb :new_gossip
      end

      post '/gossips/new/' do
        Gossip.new("#{params["gossip_author"]}", "#{params["gossip_content"]}").save
        redirect '/'
      end

      get "/gossips/:id" do
        erb :index_id
      end

      get '/gossips/:id/edit/' do 
        erb :edit
      end

      post '/gossips/:id/edit/' do 
        Gossip.update("#{params["gossip_author"]}", "#{params["gossip_content"]}",params[:id].to_i)
        redirect '/'
      end 

end