# -*- coding: utf-8 -*-

require 'sinatra'
require 'json'
require 'mysql2'
#require 'httparty'

require './config/request'
require './config/bootstrap'

configure { 
	set :server, :puma 
}

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

get '/' do
	content_type :html, 'charset' => 'utf-8'
	headers 'Access-Control-Allow-Origin' => 'http://localhost:8888'
	'Error : URI vacía'
end

get '/*' do
	content_type :html, 'charset' => 'utf-8'
	headers 'Access-Control-Allow-Origin' => 'http://localhost:8888'

	url = params[:splat]
	r = Request.new(url)
	if r.metodo != ""
		b = Bootstrap.new(r, params, session)
		rpta = nil

		begin 
			content_type :html, 'charset' => 'utf-8'
			rpta = b.rpta
		rescue  ZeroDivisionError => e#Errno::ENOENT => e
			rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "Error", :error => e}.to_json
		end
	else
		rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "Error: Método no existe", :error => e}.to_json
	end

	rpta
end

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

post '/' do
	content_type :html, 'charset' => 'utf-8'
	headers 'Access-Control-Allow-Origin' => 'http://localhost:8888'
	'Error : URI vacía'
end

post '/*' do
	headers 'Access-Control-Allow-Origin' => 'http://localhost:8888'
	content_type :html, 'charset' => 'utf-8'

	url = params[:splat]
	r = Request.new(url)
	if r.metodo != ""
		b = Bootstrap.new(r, params, session)
		rpta = nil

		begin 
			content_type :html, 'charset' => 'utf-8'
			rpta = b.rpta
		rescue  ZeroDivisionError => e#Errno::ENOENT => e
			rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "Error", :error => e}.to_json
		end
	else
		rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "Error: Método no existe", :error => e}.to_json
	end

	rpta
end

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#rerun 'ruby index.rb -p 3000'