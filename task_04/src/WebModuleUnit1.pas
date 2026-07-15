unit WebModuleUnit1;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Data.DB,
  Data.Win.ADODB;

type
  TWebModule1 = class(TWebModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;

    procedure WebModule1DefaultHandlerAction(
      Sender: TObject;
      Request: TWebRequest;
      Response: TWebResponse;
      var Handled: Boolean
    );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(
  Sender: TObject;
  Request: TWebRequest;
  Response: TWebResponse;
  var Handled: Boolean
);
var
  Html: string;
begin
  Html :=
    '<!DOCTYPE html>' +
    '<html lang="ru">' +
    '<head>' +
    '<meta charset="UTF-8">' +
    '<title>Туристическое агентство</title>' +
    '<style>' +
    'body { font-family: Arial, sans-serif; margin: 40px; }' +
    'h1 { margin-bottom: 10px; }' +
    'table { border-collapse: collapse; width: 100%; margin-top: 20px; }' +
    'th, td { border: 1px solid #cccccc; padding: 10px; text-align: left; }' +
    'th { background-color: #eeeeee; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<h1>Туристическое агентство</h1>' +
    '<p>Список туров из базы данных MS SQL Server</p>' +
    '<table>' +
    '<tr>' +
    '<th>ID</th>' +
    '<th>Название тура</th>' +
    '<th>Страна</th>' +
    '<th>Город</th>' +
    '<th>Длительность</th>' +
    '<th>Цена</th>' +
    '</tr>';

  ADOQuery1.Close;
  ADOQuery1.Open;

  while not ADOQuery1.Eof do
  begin
    Html := Html +
      '<tr>' +
      '<td>' +
      ADOQuery1.FieldByName('tour_id').AsString +
      '</td>' +
      '<td>' +
      ADOQuery1.FieldByName('tour_name').AsString +
      '</td>' +
      '<td>' +
      ADOQuery1.FieldByName('country').AsString +
      '</td>' +
      '<td>' +
      ADOQuery1.FieldByName('city').AsString +
      '</td>' +
      '<td>' +
      ADOQuery1.FieldByName('duration_days').AsString +
      ' дней</td>' +
      '<td>' +
      ADOQuery1.FieldByName('base_price').AsString +
      ' руб.</td>' +
      '</tr>';

    ADOQuery1.Next;
  end;

  ADOQuery1.Close;

  Html := Html +
    '</table>' +
    '</body>' +
    '</html>';

  Response.ContentType := 'text/html; charset=utf-8';
  Response.Content := Html;
  Handled := True;
end;

end.
