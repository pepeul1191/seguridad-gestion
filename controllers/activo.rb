# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# app/controllers/activo.rb

class Activo < Controller
    def initialize
        @activos = load_model("activos")
    end
    
    def listar
        @activos.listar
    end

    def guardar
        data = params[:data]
        array_json_tabla = JSON.parse(data)

        nuevos = array_json_tabla["nuevos"]
        editados = array_json_tabla["editados"]
        eliminados = array_json_tabla["eliminados"]

        begin
            if !eliminados.empty?
                for i in 0..eliminados.length - 1
                    id = eliminados[i]

                    eliminar(id)
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha registrado los cambios en los activos", array_nuevos] }.to_json
        rescue StandardError => e #ZeroDivisionError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Se ha producido un error en guardar la tabla de activos", e] }.to_json
        end

        rpta
    end

    private
    def crear(temp_id, codigo, descripcion)
        id_generado = @activos.crear(codigo, descripcion)
        {:temporal => temp_id, :nuevo_id => id_generado}
    end

    private
    def editar(id, codigo, descripcion)
        @activos.editar(id, codigo, descripcion)
    end

    private
    def eliminar(id)
        @activos.eliminar(id)
    end
end