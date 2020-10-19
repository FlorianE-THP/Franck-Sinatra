require 'gossip'
require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base
      get '/' do
        erb :index, locals: {gossips: Gossip.all}
      end
      #Ici ca envoie vers la vue pour créer un potin
      get '/gossips/new/' do
        erb :new_gossip
      end
      #Ici ca envoie vers la fonction pour créer un potin
      post '/gossips/new/' do
        Gossip.new("#{params["gossip_author"]}", "#{params["gossip_content"]}").save
        redirect '/'
      end
      #Ici ca envoie vers l'ID d'un potin
      get "/gossips/:id" do
        erb :show, locals: {gossip: Gossip.find(params["id"]), id: params["id"]}
      end
      #Ici ca envoie vers la vue pour modifier
      get '/gossips/:id/edit/' do 
        erb :edit, locals: {gossips: Gossip.all}
      end
      #Ici ca envoie vers la fonction pour modifier
      post '/gossips/:id/edit/' do 
        Gossip.update(params["gossip_author"], params["gossip_content"], params["id"].to_i)
        redirect '/'
      end 
end