# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# app/models/agentes.rb

class Agentes  < Model
    def listar
        stringify(@connection.query('SELECT * FROM agentes'))
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