# config/controller.rb

require './config/model'

class Controller
	def load_model(modelo)
		require File.expand_path('../../models/' + modelo, __FILE__)
		Object.const_get(modelo.capitalize).new
	end

	def load_controller(controlador)
		require File.expand_path('../../controllers/' + controlador, __FILE__)
		Object.const_get(controlador.capitalize).new
	end

	def json_rpta(tipo_mensaje, rpta_mensaje)
		{:tipo_mensaje => tipo_mensaje, :rpta_mensaje => rpta_mensaje}.to_json
	end

	def load_lib(libreria)
		#FALTA, ver el de php
	end

	def post(url)
		HTTParty.post(URI.encode(url))
	end

	def get(url)
		HTTParty.get(URI.encode(url))
	end

	def set_params(params)
		@params = params
	end

	def params
		@params
	end
end