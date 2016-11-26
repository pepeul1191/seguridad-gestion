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

    def obtener(id)
        @activos.obtener(id)
    end

    def obtener_controles(id)
        @activos.obtener_controles(id)
    end

    def obtener_vulnerabilidades(id)
        @activos.obtener_vulnerabilidades(id)
    end

    def obtener_amenazas(id)
        @activos.obtener_amenazas(id)
    end

    def obtener_riesgos(id)
        @activos.obtener_riesgos(id)
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

    def crear
        activo = JSON.parse(params[:data])
        begin
            id_generado = @activos.crear(activo['codigo'], activo['descripcion'], activo['id_agente'], activo['id_capa'], activo['id_criticidad'], activo['id_tipo_activo'], activo['id_ubicacion'])
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha añadido un nuevo activo", id_generado] }.to_json
        rescue StandardError => e 
            puts e
            rpta = { :tipo_mensaje => "error", :mensaje => ["Se ha producido un error en crear el nuevo activo", e] }.to_json
        end
        rpta
    end

    def editar
       activo = JSON.parse(params[:data])
       begin
            @activos.editar(activo['id_activo'], activo['codigo'], activo['descripcion'], activo['id_agente'], activo['id_capa'], activo['id_criticidad'], activo['id_tipo_activo'], activo['id_ubicacion'])
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha editado un activo"] }.to_json
        rescue
            rpta = { :tipo_mensaje => "error", :mensaje => ["Se ha producido un error en editar el activo", e] }.to_json
        end
        rpta
    end

    private
    def eliminar(id)
        @activos.eliminar(id)
    end

    def asociar_control
        data = JSON.parse(params[:data])
        begin
            id_activo = data['id_activo']
            data['grupos_check'].each do |item|
                if item['valor'] == true
                    if @activos.existe_asociacion_control(id_activo, item['control_id']) == 0
                        @activos.asociar_control(id_activo, item['control_id'])
                    end
                else
                    @activos.desasociar_control(id_activo, item['control_id'])
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha asociado los controles al activo de información"] }.to_json
        rescue ZeroDivisionError => e #StandardError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Ha ocurrido un error al asociar los controles al activo de información", e] }.to_json
        end 
        rpta
    end

    def asociar_vulnerabilidad
        data = JSON.parse(params[:data])
        begin
            id_activo = data['id_activo']
            data['grupos_check'].each do |item|
                if item['valor'] == true
                    if @activos.existe_asociacion_vulnerabilidad(id_activo, item['vulnerabilidad_id']) == 0
                        @activos.asociar_vulnerabilidad(id_activo, item['vulnerabilidad_id'])
                    end
                else
                    @activos.desasociar_vulnerabilidad(id_activo, item['vulnerabilidad_id'])
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha asociado las amenazas al activo de información"] }.to_json
        rescue ZeroDivisionError => e #StandardError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Ha ocurrido un error al asociar las amenazas al activo de información", e] }.to_json
        end 
        rpta
    end

    def asociar_amenaza
        data = JSON.parse(params[:data])
        begin
            id_activo = data['id_activo']
            data['grupos_check'].each do |item|
                if item['valor'] == true
                    if @activos.existe_asociacion_amenaza(id_activo, item['amenaza_id']) == 0
                        @activos.asociar_amenaza(id_activo, item['amenaza_id'])
                    end
                else
                    @activos.desasociar_amenaza(id_activo, item['amenaza_id'])
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha asociado las amenazas al activo de información"] }.to_json
        rescue ZeroDivisionError => e #StandardError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Ha ocurrido un error al asociar las amenazas al activo de información", e] }.to_json
        end 
        rpta
    end

    def asociar_riesgo
        data = JSON.parse(params[:data])
        begin
            id_activo = data['id_activo']
            data['grupos_check'].each do |item|
                if item['valor'] == true
                    if @activos.existe_asociacion_riesgo(id_activo, item['riesgo_id']) == 0
                        @activos.asociar_riesgo(id_activo, item['riesgo_id'])
                    end
                else
                    @activos.desasociar_riesgo(id_activo, item['riesgo_id'])
                end
            end
            rpta = { :tipo_mensaje => "success", :mensaje => ["Se ha asociado los riesgos al activo de información"] }.to_json
        rescue ZeroDivisionError => e #StandardError
            rpta = { :tipo_mensaje => "error", :mensaje => ["Ha ocurrido un error al asociar los riesgos al activo de información", e] }.to_json
        end 
        rpta
    end
end