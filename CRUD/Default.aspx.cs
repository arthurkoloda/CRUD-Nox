using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario usuario = new Usuario(1, "Arthur", "09897817980", new DateTime(1999, 6, 24), new DateTime(2021, 1, 23), "Adm");

        usuario.Inserir();

        gvTeste.DataSource = new Usuario().Listar("", "");
        gvTeste.DataBind();
    }
}