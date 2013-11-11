unit sqlparser;

{Equivale a un archivo .h }
interface

uses
  sqlscanner;

function ProgramaSQL_Parse: boolean;
function SentenciaSQL_Parse: boolean;
function SentenciaCREATE_Parse: boolean;
function SentenciaALTER_Parse: boolean;
function SentenciaDESCRIBE_Parse: boolean;
function SentenciaDROP_Parse: boolean;
function SentenciaTRUNCATE_Parse: boolean;
function SentenciaSHOW_Parse: boolean;
function SentenciaSELECT_Parse: boolean;
function SentenciaINSERT_Parse: boolean;
function SentenciaUPDATE_Parse: boolean;
function SentenciaDELETE_Parse: boolean;
function SentenciaCREATETABLE_Parse: boolean;
function SentenciaDROPTABLE_Parse:boolean;
function SentenciaINSERTINTO_Parse:boolean;
function SentenciaINSERTINTOTABLE_Parse:boolean;
function SentenciaINSERTINTOTABLEVALUES_Parse:boolean;
function SentenciaINSERTINTOTABLEVALUES_Parse:boolean;


{Equivale a un archivo .c con #include ".h" }
implementation

function ProgramaSQL_Parse: boolean;
begin
  repeat
    Result := SentenciaSQL_Parse;
    T := Scanner_SiguienteToken;
    if T.Tipo = T_PUNTOYCOMA then
    begin
      Scanner_Avanzar;
      Result := true;    
    end;
  until (T.Tipo = T_EOF) or (not Result);
end;

function SentenciaSQL_Parse: boolean;
begin
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_CREATE:	Result := SentenciaCREATE_Parse;
  T_ALTER:	Result := SentenciaALTER_Parse;
  T_DESCRIBE:	Result := SentenciaDESCRIBE_Parse;
  T_DROP:	Result := SentenciaDROP_Parse;
  T_TRUNCATE:	Result := SentenciaTRUNCATE_Parse;
  T_SHOW:	Result := SentenciaSHOW_Parse;
  T_SELECT:	Result := SentenciaSELECT_Parse;
  T_INSERT:	Result := SentenciaINSERT_Parse;
  T_UPDATE:	Result := SentenciaUPDATE_Parse;
  T_DELETE:	Result := SentenciaDELETE_Parse;
  T_USE:	Result := SentenciaUSE_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;

function SentenciaCREATE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaCREATETABLE_Parse;
  T_DATABASE:	Result := SentenciaCREATEDATABASE_Parse;
  T_VIEW:	Result := SentenciaCREATEVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;

function SentenciaALTER_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;

function SentenciaDESCRIBE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaDESCRIBE_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaDROP_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaCREATETABLE_Parse;
  T_DATABASE:	Result := SentenciaCREATEDATABASE_Parse;
  T_VIEW:	Result := SentenciaCREATEVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;

end;
function SentenciaDROPTABLE_Parse;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaDROPTABLE_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
end;

function SentenciaTRUNCATE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;  boolean;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaSHOW_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaSHOW_Parse;
  T_VIEW:	Result := SentenciaSHOW_Parse;
  T_TRIGGERS:   Result := SentenciaSHOW_Parse;
  T_INDEX:      Result := SentenciaSHOW_Parse;
  T_DATABASE:   Result := SentenciaSHOW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaSELECT_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaINSERT_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
 case T.Tipo of
 T_INTO:  Result:= SentenciaINSERTINTO_Parse;



  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
  end;
end;
function SentenciaUPDATE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaDELETE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaUSE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  case T.Tipo of
  T_TABLE:	Result := SentenciaALTERTABLE_Parse;
  T_VIEW:	Result := SentenciaALTERVIEW_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;


function SentenciaCREATETABLE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaCREATETABLE_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
    writeln('Error: token inesperado');
    Result := false;  
  end;
end;

end.
