# config/request.rb

class Request 
    def initialize(url_path)
        @rpta = nil
        url_path_array = url_path[0].split("/")

        @controlador = url_path_array.shift
        @metodo = url_path_array.shift
        @argumento = url_path_array
    end

    def controlador
        @controlador
    end

    def metodo
        @metodo
    end

    def argumento
        @argumento
    end

    def rpta
        @rpta
    end

    def to_string 
        "controlador : " + @controlador + ", metodo : " + @metodo + " , argumento(s) : " + @argumento 
    end
end