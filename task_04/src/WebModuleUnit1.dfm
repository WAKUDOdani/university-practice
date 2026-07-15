object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Tourism123!;Persist Security Info=T' +
      'rue;User ID=tourism_user;Initial Catalog=tourism_web_db;Data Sou' +
      'rce=localhost\SQLEXPRESS;Use Procedure for Prepare=1;Auto Transl' +
      'ate=True;Packet Size=4096;Workstation ID=DESKTOP-HB0CMNT;Use Enc' +
      'ryption for Data=False;Tag with column collation when possible=F' +
      'alse'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 96
    Top = 72
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '    tour_id,'
      '    tour_name,'
      '    country,'
      '    city,'
      '    duration_days,'
      '    base_price'
      'FROM tours'
      'ORDER BY tour_id;')
    Left = 224
    Top = 80
  end
end
