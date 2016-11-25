# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# app/controllers/agente.rb

class Agente < Controller
    def initialize
        @agentes = load_model("agentes")
    end
    
    def listar
        @agentes.listar
    end

    def guardar
        data = params[:data]
        array_json_tabla = JSON.parse(data)

        nuevos = array_json_tabla["nuevos"]
        editados = array_json_tabla["editados"]
        eliminados = array_json_tabla["eliminados"]

        begin
            if !nuevos.empty?
                array_nuevos = Array.new
                for i in 0..nuevos.length - 1
                    temp_id = nuevos[i]['id']
                    codigo = nuevos[i]['codigo'].gsub(" ", "%20") #esto es para reemplazar los espacios en blanco porque httparty arroja error
                    descripcion = nuevos[i]['descripcion']

                    nuevo = crear(temp_id, codigo, descripcion)
                    array_nuevos.push(nuevo)
                end
            end
            if !editados.empty?
                for i in 0..editados.length - 1
                    id = editados[i]['id']
                    codigo = editados[i]['codigo'].gsub(" ", "%20") #esto es para reemplazar los espacios en blanco porque httparty arroja error
                    descripcion = editados[i]['descripcion']

                    editar(id, codigo, descripcion)
                end
            end
            if !eliminados.empty?
                for i in 0..eliminados.length - 1
                    id = eliminados[i]

                    eliminar(id)
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha registrado los cambios en los agentes", array_nuevos] }.to_json
        rescue StandardError => e #ZeroDivisionError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Se ha producido un error en guardar la tabla de agentes", e] }.to_json
        end

        rpta
    end

    private
    def crear(temp_id, codigo, descripcion)
        id_generado = @agentes.crear(codigo, descripcion)
        {:temporal => temp_id, :nuevo_id => id_generado}
    end

    private
    def editar(id, codigo, descripcion)
        @agentes.editar(id, codigo, descripcion)
    end

    private
    def eliminar(id)
        @agentes.eliminar(id)
    end
end