using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Adicionar(object sender, EventArgs e)
    {
        ExecutarJavaScript("$('#modalCadastro').modal('show');");

        tbCadastroCPF.Text = "";
        tbCadastroCPF.Enabled = true;
        tbCadastroDataContratacao.Text = "";
        tbCadastroDataNascimento.Text = "";
        tbCadastroNome.Text = "";
        ddlCadastroGrupo.SelectedIndex = 0;

        Session["Cadastro"] = null;
    }
    protected void Buscar(object sender, EventArgs e)
    {
        rptUsuarios.DataSource = new Usuario().Listar(ddlBuscaGrupo.SelectedValue, tbBusca.Text);
        rptUsuarios.DataBind();
    }
    protected void ConfirmarCadastro(object sender, EventArgs e)
    {
        try
        {
            DateTime dataNascimento = Convert.ToDateTime(tbCadastroDataNascimento.Text);
        }
        catch
        {
            ExibirAlerta("Ocorreu um problema com a data de nascimento, verifique!");
            return;
        }

        try
        {
            DateTime dataContratacao = Convert.ToDateTime(tbCadastroDataContratacao.Text);
        }
        catch
        {
            ExibirAlerta("Ocorreu um problema com a data de contratação, verifique!");
            return;
        }

        try
        {
            Usuario usuario = new Usuario(0, tbCadastroNome.Text, tbCadastroCPF.Text, Convert.ToDateTime(tbCadastroDataNascimento.Text), Convert.ToDateTime(tbCadastroDataContratacao.Text), ddlCadastroGrupo.SelectedValue);

            if(Session["Cadastro"] == null)
            {
                string insercao = usuario.Inserir();

                if (!string.IsNullOrEmpty(insercao))
                {
                    ExibirAlerta(insercao);
                    return;
                }
                else
                {
                    ExecutarJavaScript("$('#modalCadastro').modal('hide');");

                    Buscar(sender, e);

                    ExibirAlerta("Usuário inserido com sucesso!");
                }
            }
            else
            {
                Usuario usu = Session["Cadastro"] as Usuario;

                usuario.Codigo = usu.Codigo;

                string atualizacao = usuario.Atualizar();

                if (!string.IsNullOrEmpty(atualizacao))
                {
                    ExibirAlerta(atualizacao);
                    return;
                }
                else
                {
                    ExecutarJavaScript("$('#modalCadastro').modal('hide');");

                    ExibirAlerta("Usuário alterado com sucesso!");

                    Buscar(sender, e);
                }
            }
        }
        catch
        {
            ExibirAlerta("Ocorreu um problema no cadastro, verifique!");
            return;
        }

        Session["Cadastro"] = null;
    }
    protected void ConfirmarExclusao(object sender, EventArgs e)
    {
        Usuario usuario = Session["Exclusao"] as Usuario;

        try
        {
            usuario.Excluir();

            ExecutarJavaScript("$('#modalExcluir').modal('hide');");

            Buscar(sender, e);

            ExibirAlerta("Usuário excluído com sucesso!");

            Session["Exclusao"] = null;
        }
        catch
        {
            ExibirAlerta("Não foi possível excluir o usuário, verifique!");
            return;
        }
    }
    protected void Editar(object sender, EventArgs e)
    {
        if(hfEditar.Value != "0")
        {
            Usuario usuario = new Usuario(Convert.ToInt32(hfEditar.Value));

            Session["Cadastro"] = usuario;

            tbCadastroCPF.Text = usuario.Cpf;
            tbCadastroCPF.Enabled = false;
            tbCadastroNome.Text = usuario.Nome;
            tbCadastroDataContratacao.Text = usuario.DataContratacao.ToShortDateString();
            tbCadastroDataNascimento.Text = usuario.DataNascimento.ToShortDateString();
            ddlCadastroGrupo.SelectedValue = usuario.Grupo;

            ExecutarJavaScript("$('#modalCadastro').modal('show');");

            hfEditar.Value = "0";
        }
    }
    protected void Excluir(object sender, EventArgs e)
    {
        if(hfExcluir.Value != "0")
        {
            Usuario usuario = new Usuario(Convert.ToInt32(hfExcluir.Value));

            Session["Exclusao"] = usuario;

            ExecutarJavaScript("$('#modalExcluir').modal('show');");

            hfExcluir.Value = "0";
        }
    }
    protected void ExecutarJavaScript(string comando)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ComandoJS", comando, true);
    }
    protected void ExibirAlerta(string mensagem)
    {
        ExecutarJavaScript("alert('" + mensagem + "');");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Session["Exclusao"] = null;
            Session["Cadastro"] = null;
            Buscar(sender, e);
        }
    }
    protected void rptUsuarios_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HtmlGenericControl liUsuario = e.Item.FindControl("liUsuario") as HtmlGenericControl;

            if(e.Item.ItemIndex %2 != 0)
            {
                liUsuario.Style.Add("background-color", "#EEE");
            }
        }
    }
}