<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CRUD Nox</title>

    <script src="lib/jquery/jquery-3.4.1.js"></script>

    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <link href="lib/bootstrap/css/bootstrap.css" rel="stylesheet" />

    <script src="lib/jQueryUI/jquery-ui.js"></script>
    <link href="lib/jQueryUI/jquery-ui.css" rel="stylesheet" />
    <script src="lib/jQueryUI/jquery-ui.min.js"></script>

    <script src="lib/funcoes.js"></script>
</head>
<body>
    <br />
    <form id="form1" runat="server">
        <!-- CLASSES PERSONALIZADAS - INÍCIO -->
        <style type="text/css">
            .fonteResponsiva {
                font-size: 1em;
            }
            @media (max-width: 768px) {
                .fonteResponsiva {
                    font-size: 0.8em;
                }
            }
            .ui-datepicker {
                z-index: 30000 !important;
            }
        </style>
        <!-- CLASSES PERSONALIZADAS - FIM -->

        <asp:ScriptManager runat="server" ID="scmDefault"></asp:ScriptManager>
        <div class="container-fluid">
            <div class="panel panel-default">
                <div class="panel-heading">Usuário</div>
                <div class="panel-body">
                    <!-- BUSCA - INÍCIO -->
                    <div class="row">
                        <div class="col-xs-12 col-md-4">
                            <label>Grupo</label>
                            <asp:DropDownList runat="server" ID="ddlBuscaGrupo" CssClass="form-control" OnSelectedIndexChanged="Buscar" AutoPostBack="true">
                                <asp:ListItem Value="Todos"></asp:ListItem>
                                <asp:ListItem Value="Administrativo"></asp:ListItem>
                                <asp:ListItem Value="Produção"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-xs-12 col-md-8">
                            <label>Parâmetros</label>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="tbBusca" CssClass="form-control"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:LinkButton runat="server" ID="lbtBuscar" CssClass="btn btn-default" OnClick="Buscar" ToolTip="Buscar">
                                                <span class="glyphicon glyphicon-search"></span>
                                                <span class="hidden-xs hidden-sm">Buscar</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="lbtAdicionar" CssClass="btn btn-primary" OnClick="Adicionar" ToolTip="Adicionar novo usuário">
                                                <span class="glyphicon glyphicon-plus"></span>
                                                <span class="hidden-xs hidden-sm">Adicionar</span>
                                    </asp:LinkButton>
                                </span>
                            </div>
                        </div>
                    </div>
                    <!-- BUSCA - FIM -->
                    <br />

                    <!-- LISTAGEM DE DADOS - INÍCIO -->
                    <asp:UpdatePanel runat="server" ID="upUsuarios" UpdateMode="Conditional">
                        <ContentTemplate>
                            <ul class="list-group">
                                <asp:Repeater runat="server" ID="rptUsuarios" OnItemDataBound="rptUsuarios_ItemDataBound">
                                    <HeaderTemplate>
                                        <li class="list-group-item active hidden-xs hidden-sm">
                                            <div class="row">
                                                <div class="col-md-2">Nome</div>
                                                <div class="col-md-2">Grupo</div>
                                                <div class="col-md-2">CPF</div>
                                                <div class="col-md-2">Nascimento</div>
                                                <div class="col-md-2">Contratado em</div>
                                                <div class="col-md-2"></div>
                                            </div>
                                        </li>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <li class="list-group-item" runat="server" id="liUsuario">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <span class="hidden-xs hidden-sm"><%# Eval("Nome") %></span>
                                                    <span class="hidden-md hidden-lg" style="font-weight: bold;"><%# Eval("Nome") %></span>
                                                </div>
                                                <div class="col-md-2 fonteResponsiva">
                                                    <b class="hidden-md hidden-lg">Grupo:</b>
                                                    <%# Eval("Grupo") %>
                                                </div>
                                                <div class="col-md-2 fonteResponsiva">
                                                    <b class="hidden-md hidden-lg">CPF:</b>
                                                    <%# Eval("Cpf") %>
                                                </div>
                                                <div class="col-md-2 fonteResponsiva">
                                                    <b class="hidden-md hidden-lg">Nascimento:</b>
                                                    <%# Eval("DataNascimento", "{0:d}") %>
                                                </div>
                                                <div class="col-md-2 fonteResponsiva">
                                                    <b class="hidden-md hidden-lg">Contratado em:</b>
                                                    <%# Eval("DataContratacao", "{0:d}") %>
                                                </div>
                                                <div class="col-md-2 text-right">
                                                    <div class="btn-group btn-group-sm">
                                                        <asp:LinkButton runat="server" ID="lbtEditar" CssClass="btn btn-default" ToolTip="Editar usuário" OnClientClick=<%# "return Editar('"+ Eval("Codigo") +"')" %>>
                                                            <span class="glyphicon glyphicon-pencil"></span>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton runat="server" ID="lbtExcluir" CssClass="btn btn-danger" ToolTip="Excluir usuário" OnClientClick=<%# "return Excluir('"+ Eval("Codigo") +"')" %>>
                                                            <span class="glyphicon glyphicon-trash"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lbtBuscar" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlBuscaGrupo" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="lbtConfirmarCadastro" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="lbtConfirmarExclusao" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <!-- LISTAGEM DE DADOS - FIM -->
                </div>
            </div>
        </div>
        <!-- MODAL DE CADASTRO E EDIÇÃO - INÍCIO -->
        <div class="modal fade" id="modalCadastro" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <asp:UpdatePanel runat="server" ID="upCadastro" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">Usuário</div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>CPF</label>
                                            <asp:TextBox runat="server" ID="tbCadastroCPF" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-12">
                                            <label>Nome</label>
                                            <asp:TextBox runat="server" ID="tbCadastroNome" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-12">
                                            <label>Data Nascimento</label>
                                            <div class="input-group">
                                                <asp:TextBox 
                                                    runat="server" 
                                                    ID="tbCadastroDataNascimento" 
                                                    CssClass="form-control"
                                                    MaxLength="10"
                                                    onblur="MascData(this)"
                                                    onfocus="this.select()"
                                                    onkeydown="return MascaraData(this, event);"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <a class="btn btn-default" onclick="return Calendario('tbCadastroDataNascimento');">
                                                        <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
                                                    </a>
                                                </span>
                                            </div>
                                            
                                        </div>
                                        <div class="col-xs-12">
                                            <label>Data Contratação</label>
                                            <div class="input-group">
                                                <asp:TextBox 
                                                    runat="server" 
                                                    ID="tbCadastroDataContratacao" 
                                                    CssClass="form-control"
                                                    MaxLength="10"
                                                    onblur="MascData(this)"
                                                    onfocus="this.select()"
                                                    onkeydown="return MascaraData(this, event);"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <a class="btn btn-default" onclick="return Calendario('tbCadastroDataContratacao');">
                                                        <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <label>Grupo</label>
                                            <asp:DropDownList runat="server" ID="ddlCadastroGrupo" CssClass="form-control">
                                                <asp:ListItem Value="Administrativo"></asp:ListItem>
                                                <asp:ListItem Value="Produção"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton runat="server" ID="lbtConfirmarCadastro" CssClass="btn btn-success" OnClick="ConfirmarCadastro">
                            <span class="glyphicon glyphicon-ok"></span>
                            Confirmar
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" ID="lbtCancelarCadastro" CssClass="btn btn-danger" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove"></span>
                            Cancelar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lbtAdicionar" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="hfEditar" EventName="ValueChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
        <!-- MODAL DE CADASTRO E EDIÇÃO - FIM -->

        <!-- MODAL DE CONFIRMAÇÃO DE EXCLUSÃO - INÍCIO -->
        <div class="modal fade" id="modalExcluir" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">Excluir</div>
                    <div class="modal-body text-center">
                        <br />
                        Tem certeza que deseja excluir este usuário ?
                        <br />
                        Esta ação não pode ser desfeita!
                        <br />
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton runat="server" ID="lbtConfirmarExclusao" CssClass="btn btn-success" ToolTip="Confirmar exclusão" OnClick="ConfirmarExclusao">
                            <span class="glyphicon glyphicon-ok"></span>
                            Confirmar
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lbtCancelarExclusao" CssClass="btn btn-danger" ToolTip="Cancelar exclusão" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove"></span>
                            Cancelar
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <!-- MODAL DE CONFIRMAÇÃO DE EXCLUSÃO - FIM -->

        <!-- HIDDEN FIELDS - INÍCIO -->
        <asp:UpdatePanel runat="server" ID="upHidden" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:HiddenField runat="server" ID="hfEditar" Value="0" OnValueChanged="Editar" />
                <asp:HiddenField runat="server" ID="hfExcluir" Value="0" OnValueChanged="Excluir" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <!-- HIDDEN FIELDS - FIM -->

        <!-- CÓDIGOS EM JAVASCRIPT - INÍCIO -->
        <script type="text/javascript">
            function Editar(codigo) {
                var hfEditar = $('#hfEditar');

                hfEditar.val(codigo);

                __doPostBack(hfEditar.attr('name'), '');

                return false;
            }
            function Excluir(codigo) {
                var hfEditar = $('#hfExcluir');

                hfEditar.val(codigo);

                __doPostBack(hfEditar.attr('name'), '');

                return false;
            }
    </script>
        <!-- CÓDIGOS EM JAVASCRIPT - FIM -->
    </form>    
</body>
</html>
