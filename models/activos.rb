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

    def obtener(id)
        stmt = @connection.prepare('SELECT * FROM activos WHERE id=?')
        rs = stmt.execute(id)
        rpta = ""
        rs.each do |row|
             rpta << JSON[row]
        end
        rpta
    end

    def obtener_controles(id)
        stmt = @connection.prepare('
                        SELECT T.id, T.codigo, T.descripcion, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe FROM
                        (
                            SELECT id, codigo, descripcion, 0 AS existe FROM controles 
                        ) T
                            LEFT JOIN
                        (
                            SELECT C.id, C.codigo, C.descripcion, 1 AS existe  FROM controles C 
                            LEFT JOIN activos_controles AC ON C.id = AC.control_id
                            WHERE AC.activo_id = ?
                        ) P
                        ON T.id = P.id')
         stringify(stmt.execute(id))
    end

    def obtener_vulnerabilidades(id)
        stmt = @connection.prepare('
                        SELECT T.id, T.codigo, T.descripcion, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe FROM
                        (
                            SELECT id, codigo, descripcion, 0 AS existe FROM vulnerabilidades
                        ) T
                            LEFT JOIN
                        (
                            SELECT V.id, V.codigo, V.descripcion, 1 AS existe  FROM vulnerabilidades V 
                            LEFT JOIN activos_vulnerabilidades AV ON V.id = AV.vulnerabilidad_id
                            WHERE AV.activo_id = ?
                        ) P
                        ON T.id = P.id')
         stringify(stmt.execute(id))
    end

    def obtener_amenazas(id)
        stmt = @connection.prepare('
                        SELECT T.id, T.codigo, T.descripcion, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe FROM
                        (
                            SELECT id, codigo, descripcion, 0 AS existe FROM amenazas
                        ) T
                        LEFT JOIN
                        (
                            SELECT A.id, A.codigo, A.descripcion, 1 AS existe  FROM amenazas A 
                            LEFT JOIN activos_amenazas AA ON A.id = AA.amenaza_id
                            WHERE AA.activo_id = ?
                        ) P
                        ON T.id = P.id')
         stringify(stmt.execute(id))
    end

    def obtener_riesgos(id)
        stmt = @connection.prepare('
                        SELECT T.id, T.codigo, T.descripcion, (CASE WHEN (P.existe = 1) THEN 1 ELSE 0 END) AS existe FROM
                        (
                        SELECT id, codigo, descripcion, 0 AS existe FROM riesgos
                        ) T
                        LEFT JOIN
                        (
                        SELECT R.id, R.codigo, R.descripcion, 1 AS existe  FROM riesgos R 
                        LEFT JOIN activos_riesgos AR ON R.id = AR.riesgo_id
                        WHERE AR.activo_id = ?
                        ) P
                        ON T.id = P.id')
         stringify(stmt.execute(id))
    end

    def crear(codigo, descripcion, agente_id, capa_id, criticidad_id, tipo_activo_id, ubicacion_id)
        stmt = @connection.prepare('INSERT INTO activos (codigo, descripcion, agente_id, capa_id, criticidad_id, tipo_activo_id, ubicacion_id) VALUES (?,?,?,?,?,?,?)')
        stmt.execute(codigo, descripcion, agente_id, capa_id, criticidad_id, tipo_activo_id, ubicacion_id)
            @connection.last_id
    end

    def editar(id, codigo, descripcion, agente_id, capa_id, criticidad_id, tipo_activo_id, ubicacion_id)
        stmt = @connection.prepare('UPDATE activos SET codigo = ?, descripcion = ?, agente_id = ?, capa_id = ?, criticidad_id = ?, tipo_activo_id = ?, ubicacion_id = ? WHERE id = ?')
        stmt.execute(codigo, descripcion, agente_id, capa_id, criticidad_id, tipo_activo_id, ubicacion_id, id)
    end

    def eliminar(id)
        stmt = @connection.prepare('DELETE FROM activos WHERE id = ?')
        stmt.execute(id)
    end

    def existe_asociacion_control(activo_id, control_id)
        stmt = @connection.prepare('SELECT COUNT(*) AS cantidad FROM activos_controles  WHERE activo_id = ? AND control_id = ?')
         rs = stmt.execute(activo_id, control_id)
         cantidad = ""
         rs.each do |row|
            cantidad = row['cantidad']
         end 
         Integer(cantidad)
    end

    def asociar_control(activo_id, control_id)
         stmt = @connection.prepare('INSERT INTO activos_controles (activo_id, control_id) VALUES (?,?)')
         rs = stmt.execute(activo_id, control_id)
    end

    def desasociar_control(activo_id, control_id)
         stmt = @connection.prepare('DELETE FROM activos_controles WHERE activo_id = ? AND control_id = ?')
         stmt.execute(activo_id, control_id)
    end

    def existe_asociacion_vulnerabilidad(activo_id, vulnerabilidad_id)
        stmt = @connection.prepare('SELECT COUNT(*) AS cantidad FROM activos_vulnerabilidades  WHERE activo_id = ? AND vulnerabilidad_id = ?')
         rs = stmt.execute(activo_id, vulnerabilidad_id)
         cantidad = ""
         rs.each do |row|
            cantidad = row['cantidad']
         end 
         Integer(cantidad)
    end

    def asociar_vulnerabilidad(activo_id, vulnerabilidad_id)
         stmt = @connection.prepare('INSERT INTO activos_vulnerabilidades (activo_id, vulnerabilidad_id) VALUES (?,?)')
         rs = stmt.execute(activo_id, vulnerabilidad_id)
    end

    def desasociar_vulnerabilidad(activo_id, vulnerabilidad_id)
         stmt = @connection.prepare('DELETE FROM activos_vulnerabilidades WHERE activo_id = ? AND vulnerabilidad_id = ?')
         stmt.execute(activo_id, vulnerabilidad_id)
    end

    def existe_asociacion_amenaza(activo_id, amenaza_id)
        stmt = @connection.prepare('SELECT COUNT(*) AS cantidad FROM activos_amenazas  WHERE activo_id = ? AND amenaza_id = ?')
         rs = stmt.execute(activo_id, amenaza_id)
         cantidad = ""
         rs.each do |row|
            cantidad = row['cantidad']
         end 
         Integer(cantidad)
    end

    def asociar_amenaza(activo_id, amenaza_id)
         stmt = @connection.prepare('INSERT INTO activos_amenazas (activo_id, amenaza_id) VALUES (?,?)')
         rs = stmt.execute(activo_id, amenaza_id)
    end

    def desasociar_amenaza(activo_id, amenaza_id)
         stmt = @connection.prepare('DELETE FROM activos_amenazas WHERE activo_id = ? AND amenaza_id = ?')
         stmt.execute(activo_id, amenaza_id)
    end

    def existe_asociacion_riesgo(activo_id, riesgo_id)
        stmt = @connection.prepare('SELECT COUNT(*) AS cantidad FROM activos_riesgos  WHERE activo_id = ? AND riesgo_id = ?')
         rs = stmt.execute(activo_id, riesgo_id)
         cantidad = ""
         rs.each do |row|
            cantidad = row['cantidad']
         end 
         Integer(cantidad)
    end

    def asociar_riesgo(activo_id, riesgo_id)
         stmt = @connection.prepare('INSERT INTO activos_riesgos (activo_id, riesgo_id) VALUES (?,?)')
         rs = stmt.execute(activo_id, riesgo_id)
    end

    def desasociar_riesgo(activo_id, riesgo_id)
         stmt = @connection.prepare('DELETE FROM activos_riesgos WHERE activo_id = ? AND riesgo_id = ?')
         stmt.execute(activo_id, riesgo_id)
    end
end