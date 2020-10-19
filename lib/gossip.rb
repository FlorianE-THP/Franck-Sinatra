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
    CSV.read("./db/gossip.csv").each_with_index do |row, index|
        if index+1 == id 
            return "L'auteur : #{row[0]} <br> Et son potin : #{row[1]} "
        end
    end
   end
   
    # Méthode qui permet de modifier un potin
   def self.update(author, content, id)
        update_array = self.all
		update_array[id.to_i].content = content
		update_array[id.to_i].author = author
		File.open("./db/gossip.csv", 'w') {|file|}
		update_array.each do |gossip|
			gossip.save
		end	
   end
end