<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">  
   
    protected void Button1_Click(object sender, DirectEventArgs e)
    {  
        
        //Класс QuestionMessage проверяет предложение на вопросительность
        QuestionMessage QM = new QuestionMessage(TextArea1.Text);
        DateTime now = DateTime.Now;

        String data = now.Year+"."+now.Month+"."+now.Day+" "+now.Hour+"/"+now.Minute;
        if (QM.Question.ToString() != "В вашем предложении отсутствует вопросительный знак, убедитесь что это вопрос и добавьте знак вопроса!")
        {
            XMLClass XML = new XMLClass(QM.Question.ToString(), false, now.ToString());

            this.TextArea1.Text = "";
            Store1.Reload();
        }
        else { }
       X.Msg.Notify(new NotificationConfig {  
            Icon  = Icon.Accept,
            Title = "Working",
            Html  = QM.Question
        }).Show();
    }
    public string asd;
    [DirectMethod]
    public void DoConfirm()
    {
        // Manually configure Handler...
        //Msg.Confirm("Message", "Confirm?", "if (buttonId == 'yes') { CompanyX.DoYes(); } else { CompanyX.DoNo(); }").Show();

        // Configure individualock Buttons using a ButtonsConfig...
        QuestionMessage QM = new QuestionMessage(TextArea1.Text);
        asd = QM.Question;
        if (QM.Question.ToString() != "В вашем предложении отсутствует вопросительный знак, убедитесь что это вопрос и добавьте знак вопроса!")
        {
            X.Msg.Confirm("Вместо unity3D", asd, new MessageBoxButtonsConfig
            {
                Yes = new MessageBoxButtonConfig
                {
                    Handler = "CompanyX.DoYes()",
                    Text = "True"
                },
                No = new MessageBoxButtonConfig
                {
                    Handler = "CompanyX.DoNo()",
                    Text = "False"
                }
            }).Show();
        }
    }
 [DirectMethod]
    public void DoYes()
    {
        DateTime now = DateTime.Now;
        XMLClass XML = new XMLClass(this.TextArea1.Text, true,  
now.Year + "." + now.Month + "." + now.Day + " " + now.Hour + "/" + now.Minute
       );
        this.TextArea1.Text = "";
        Store1.Reload();

        X.Msg.Notify(new NotificationConfig
        {
            Icon = Icon.Accept,
            Title = "Working",
            Html = "Ваш ответ 'True'"
        }).Show();
    }

    [DirectMethod]
    public void DoNo()
 {
        DateTime now = DateTime.Now; 
        XMLClass XML = new XMLClass(this.TextArea1.Text, false,
            now.Year + "." + now.Month + "." + now.Day + " " + now.Hour + "/" + now.Minute
);
        this.TextArea1.Text = "";
        Store1.Reload();

        X.Msg.Notify(new NotificationConfig
        {
            Icon = Icon.Accept,
            Title = "Working",
            Html = "ваш ответ 'False'"
        }).Show();
    }
    protected void Store1_Load(object sender, EventArgs e)
    {
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server"> 
    <title>Ext.NET Example</title>
     <link href="/resources/css/examples.css" rel="stylesheet" />
  
    <script>
       
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" Theme="Gray" DirectMethodNamespace="CompanyX"  />
    
        <a href="http://www.ext.net/"><img src="http://speed.ext.net/identity/extnet-logo-small.png" /></a>
          
        
        <asp:XmlDataSource 
            ID="XmlDataSource1" 
            runat="server" 
             DataFile="Log.xml"
            TransformFile="Log.xsl" 
            />    
       
        <ext:Window 
            ID="Window1"
            runat="server" 
            Title="Вопросник"
            Height="467"
            Width="759"
            BodyPadding="5"
            DefaultButton="0"
            Layout="AnchorLayout"
            DefaultAnchor="100%"
       ><Items>
           
            <ext:Toolbar ID="Toolbar1"
                    dock ="Top"
                     runat="server"
                    > 
                    <Items> 
                     <%--OnDirectClick="Button2_Click"--%>  
                        <ext:TextField
                            ID="TextArea1"
                            runat="server"
                            width="645"
                            fieldLabel="Вопрос"
                            />  
                        <ext:Button ID="Button1"
                            runat="server"
                            width="85"
                            text="Отправить"
                           
                            ><Listeners>
                    <Click Handler="CompanyX.DoConfirm()" />
                </Listeners></ext:Button>
                    </Items>
                        
               </ext:Toolbar>
          
          
         <ext:GridPanel ID="GridPanel1" 
            runat="server" 
            Width="600" 
            Height="300"
            Title="Лог" 
            Frame="true">
            <Store>
                <ext:Store ID="Store1" runat="server" DataSourceID="XmlDataSource1" PageSize="10" OnLoad="Store1_Load"
                  >
                    <Model>
                        <ext:Model ID="Model1" runat="server">
                            <Fields>
                                <ext:ModelField Name="Question" />
                                <ext:ModelField Name="Respond" />
                                <ext:ModelField Name="Date"/>                                
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="Question" Direction="ASC" />
                    </Sorters>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ID="Column1" runat="server" Text="Вопрос" DataIndex="Question" Width="220" Sortable="true" Flex="1" />
                    <ext:Column ID="Column2" runat="server" Text="Ответ" DataIndex="Respond" Width="130" />  
                    <ext:Column ID="Column3" runat="server" Text="Дата" DataIndex="Date" Width="130" />               
                    <%--<ext:DateColumn ID="DateColumn1" runat="server" Text="Available" DataIndex="Date" Width="95"  Format="Y-m-d " />--%>                    
                </Columns>
            </ColumnModel>           
            <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar1" runat="server" HideRefresh="true" />
            </BottomBar>
        </ext:GridPanel>  
        </Items>
        </ext:Window>
          
    </form>
</body>
</html>