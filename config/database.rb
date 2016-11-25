# config/database.rb

class Database
	def initialize
		@connection = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '123', :database => 'db_seguridad')
	end

	def connection
		@connection
	end
end