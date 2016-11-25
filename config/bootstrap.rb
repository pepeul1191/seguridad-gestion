# -*- coding: utf-8 -*-

# config/boostrap.rb

require './config/controller'

class Bootstrap
    def initialize(request, params = nil, session = nil)
    	controlador = request.controlador
    	metodo = request.metodo
    	argumento = request.argumento

    	begin
	    	require File.expand_path('../../controllers/' + controlador, __FILE__)
	    	continuar = true
		rescue LoadError => e#ZeroDivisionError#LoadError
			@rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "LoadError: controlador no existe", :error => e}.to_json
			continuar = false
		end

		if continuar
			controlador = Object.const_get(controlador.capitalize).new
			begin
            	controlador.send("set_params", params)
				rpta_request = controlador.send(metodo, *argumento)
				@rpta = rpta_request
			rescue ArgumentError => e#ZeroDivisionError#
				@rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "ArgumentError: número de argumentos no coincide"}.to_json
			rescue ZeroDivisionError => e#NoMethodError#
				@rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "NoMethodError: método no existe en clase"}.to_json
			rescue TypeError => e #ZeroDivisionError#
				@rpta = {:tipo_mensaje => 'error', :rpta_mensaje => "TypeError: Método no existe"}.to_json
			end
		end
    end

     def rpta
     	@rpta
    end

    def redirect
    	@redirect
    end

    def redirect_clear
    	@redirect = false
    end
end