require 'csv'

class Gossip
    attr_accessor :author, :content
    def initialize(author, content) 
        @author = author
        @content = content 
    end

    # Méthode qui permet de sauvegarder un potin dans le CSV
    def save
        CSV.open("db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
          end    
    end
    # Méthode qui affiche tout les potins sur la page d'accueil
    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end
    # Méthode qui affiche tout les potins sur la page d'accueil
    def self.find(id)
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips[id.to_i]
      end
   
    # Méthode qui permet de modifier un potin
    def self.update(new_author, new_content, id)

        rows_array = Array.new
        CSV.read('./db/gossip.csv').each do |csv_line|
          rows_array << Gossip.new(csv_line[0], csv_line[1])
        end

        gossip = rows_array[id]
        gossip.author = new_author
        gossip.content = new_content
        rows_array[id] = gossip
        CSV.open('./db/gossip.csv', 'w') do |csv|
        rows_array.each do |gossip|
          csv << [gossip.author, gossip.content]
        end
      end
end
end 