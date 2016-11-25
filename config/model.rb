# config/model.rb

require_relative 'database'

class Model
	def initialize
		db = Database.new
		@connection = db.connection
		@last_id = nil
	end

	def  stringify(rpta_query)
		array_json = []
		begin
			#cuando hay algo en el select 
			rpta_query.each do |row|
			  	array_json << JSON[row]
			  	array_json.to_json
			end 
			array_json.to_json
		rescue
			set_last_id(connection.last_id)
		end
	end
end