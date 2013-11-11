unit sqlscanner;

interface

type
  TTipoToken = ( T_CREATE, T_ALTER,T_DESCRIBE,T_DROP,T_TRUNCATE,
            T_SHOW,T_SELECT,T_INSERT,T_UPDATE,T_DELETE,T_USE,
            T_TABLE, T_DATABASE, T_VIEW, T_ID, T_PARENTESIS);

  TToken = record
    Tipo : TTipoToken;
    Valor : integer; {NOTA: Debe modificarse}
  end;

function Scanner_SiguienteToken: TToken;
procedure Scanner_Avanzar;

implementation

function Scanner_SiguienteToken: TToken;
begin
end;

procedure Scanner_Avanzar;
begin
end;

end.
