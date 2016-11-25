# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# app/models/activos.rb

class Activos  < Model
    def listar
        stringify(@connection.query('
             SELECT A.id, A.codigo, A.descripcion, C.nombre AS capa, U.nombre AS ubicacion, TA.nombre AS tipo_activo, AG.codigo AS agente, CR.grado AS criticidad  
             FROM activos A 
             INNER JOIN capas C ON A.capa_id = C.id 
             INNER JOIN ubicaciones U ON A.ubicacion_id = U.id 
             INNER JOIN tipo_activos TA ON A.tipo_activo_id = TA.id 
             INNER JOIN agentes AG ON A.agente_id = AG.id
             INNER JOIN criticidades CR ON A.criticidad_id = CR.id;')
        )
    end

    def crear(codigo, descripcion)
            stmt = @connection.prepare('INSERT INTO agentes (codigo, descripcion) VALUES (?,?)')
            stmt.execute(codigo, descripcion)
            @connection.last_id
    end

    def editar(id, codigo, descripcion)
            stmt = @connection.prepare('UPDATE agentes SET codigo = ?, descripcion = ? WHERE id = ?')
            stmt.execute(codigo, descripcion, id)
    end

    def eliminar(id)
            stmt = @connection.prepare('DELETE FROM agentes WHERE id = ?')
            stmt.execute(id)
    end
end