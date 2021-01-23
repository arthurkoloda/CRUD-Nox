using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// Descrição resumida de DBUsuario
/// </summary>
public abstract class DBUsuario
{
    private static List<Usuario> usuarios;
    protected List<Usuario> DBListar(string grupo, string busca)
    {
        if(usuarios == null)
        {
            usuarios = new List<Usuario>();
        }

        return usuarios.Where(u => (u.Cpf.Contains(busca) ||
                                   u.Nome.Contains(busca)) && (u.Grupo.Equals(grupo) || grupo == "")).ToList();
    }

    protected void DBInserir(Usuario usuario)
    {
        if(usuarios == null)
        {
            usuarios = new List<Usuario>();
        }

        if(usuarios.Count == 0)
        {
            usuario.Codigo = 1;
        }
        else
        {
            usuario.Codigo = usuarios.Max(u => u.Codigo) + 1;
        }        

        usuarios.Add(usuario);
    }

    protected void DBAtualizar(Usuario usuario)
    {
        if(usuario == null)
        {
            throw new Exception("A lista de usuários não foi encontrada, verifique!");
        }
        else
        {
            usuarios.Remove(usuarios.Find(u => u.Codigo == usuario.Codigo));

            usuarios.Add(usuario);
        }
    }

    protected void DBExcluir(Usuario usuario)
    {
        if(usuario == null)
        {
            throw new Exception("A lista de usuários não foi encontrada, verifique!");
        }
        else
        {
            usuarios.Remove(usuarios.Find(u => u.Codigo == usuario.Codigo));
        }
    }
}