using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descrição resumida de Usuario
/// </summary>
public class Usuario
{
    private int _codigo;
    private string _nome;
    private string _cpf;
    private DateTime _dataNascimento;
    private DateTime _dataContratacao;
    public Usuario()
    {
        //
        // TODO: Adicionar lógica do construtor aqui
        //
    }

    public Usuario(int codigo, string nome, string cpf, DateTime dataNascimento, DateTime dataContratacao)
    {
        Codigo = codigo;
        Nome = nome;
        Cpf = cpf;
        DataNascimento = dataNascimento;
        DataContratacao = dataContratacao;
    }

    public int Codigo { get => _codigo; set => _codigo = value; }
    public string Nome { get => _nome; set => _nome = value; }
    public string Cpf { get => _cpf; set => _cpf = value; }
    public DateTime DataNascimento { get => _dataNascimento; set => _dataNascimento = value; }
    public DateTime DataContratacao { get => _dataContratacao; set => _dataContratacao = value; }

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

        return "";
    }

    public void Excluir()
    {

    }

    public string Atualizar()
    {
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

        return "";
    }
}