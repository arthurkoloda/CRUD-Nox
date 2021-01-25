using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descrição resumida de Usuario
/// </summary>
public class Usuario : DBUsuario
{
    private DateTime _dataNascimento;
    private DateTime _dataContratacao;
    private int _codigo;
    private string _cpf;
    private string _grupo;
    private string _nome;
    public Usuario()
    {
        //
        // TODO: Adicionar lógica do construtor aqui
        //
    }
    public Usuario(int codigo)
    {
        Codigo = codigo;

        base.DBSelecionar(this);
    }

    public Usuario(int codigo, string nome, string cpf, DateTime dataNascimento, DateTime dataContratacao, string grupo)
    {
        Codigo = codigo;
        Nome = nome;
        Cpf = cpf;
        DataNascimento = dataNascimento;
        DataContratacao = dataContratacao;
        Grupo = grupo;
    }

    public DateTime DataNascimento { get => _dataNascimento; set => _dataNascimento = value; }
    public DateTime DataContratacao { get => _dataContratacao; set => _dataContratacao = value; }
    public int Codigo { get => _codigo; set => _codigo = value; }
    public string Cpf { get => _cpf; set => _cpf = value; }
    public string Grupo { get => _grupo; set => _grupo = value; }
    public string Nome { get => _nome; set => _nome = value; }

    public string Atualizar()
    {
        this.Cpf = this.Cpf.Replace(".", "").Replace(".", "-");
        if (this.Cpf.Length != 11)
        {
            return "Cpf inválido!";
        }

        if (string.IsNullOrEmpty(this.Nome))
        {
            return "Nome inválido!";
        }

        if (this.DataNascimento > DateTime.Today)
        {
            return "Data de nascimento incorreta!";
        }

        if (this.DataContratacao > DateTime.Today)
        {
            return "Data de contratação incorreta!";
        }

        if (this.DataContratacao < this.DataNascimento)
        {
            return "A data de contratação não pode ser menor que a data de nascimento!";
        }

        base.DBAtualizar(this);

        return "";
    }
    public void Excluir()
    {
        base.DBExcluir(this);
    }
    public string Inserir()
    {
        if(this.Cpf.Length != 11)
        {
            return "Cpf inválido!";
        }

        if(string.IsNullOrEmpty(this.Nome))
        {
            return "Nome inválido!";
        }

        if(this.DataNascimento > DateTime.Today)
        {
            return "Data de nascimento incorreta!";
        }

        if(this.DataContratacao > DateTime.Today)
        {
            return "Data de contratação incorreta!";
        }

        if(this.DataContratacao < this.DataNascimento)
        {
            return "A data de contratação não pode ser menor que a data de nascimento!";
        }

        base.DBInserir(this);

        return "";
    }
    public List<Usuario> Listar(string grupo, string busca)
    {
        return base.DBListar(grupo, busca);
    }
}