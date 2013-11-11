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
  end
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
  T_TABLE:	Result := SentenciaDROPTABLE_Parse;
  T_DATABASE:	Result := SentenciaDROPDATABASE_Parse;
  T_VIEW:	Result := SentenciaDROPVIEW_Parse;
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
function SentenciaDROPVIEW_Parse;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaDROPVIEW_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaDROPDATABASE_Parse;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaDROPDATABASE_Interpret;
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
  T_TABLE:	Result := SentenciaSHOWTABLE_Parse;
  T_INDEX:      Result := SentenciaSHOWINDEX_Parse;
  T_DATABASE:   Result := SentenciaSHOWDATABASE_Parse;
  else
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaSHOWTABLE_Parse;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaSHOWTABLE_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
end;
function SentenciaSHOWINDEX_Parse
begin
  Scanner_Avanzar;
  T:=Scanner_SiguienteToken;
  case T.Tipo of
  T_FROM: Result :=SentenciaSHOWINDEXFROM;
  else
    writeln('Error:token inesperado');
    Result:=false;
  end;
end;
function SentenciaSHOWINDEXFROM_Parse
begin
  Scanner_Avanzar;
  T:=Scanner_SiguienteToken;
  if T.Tipo=T_ID then
  begin
    SentenciaSHOWINDEXFROM_Interpret;
    T:=Scanner_Avanzar;
    Result:=false;
  end;
end;
function SentenciaSHOWDATABASE_Parse;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
  if T.Tipo = T_ID then
  begin
    SentenciaSHOWDATABASE_Interpret;
    T := Scanner_Avanzar;
    Result := true;
  end
  else
  begin
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
 else


  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
  end;
end;
function SentenciaINSERTINT0_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
 case T.Tipo of
 T_ID:  Result:= SentenciaINSERTINTOTABLE_Parse;

 else

  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
  end;
end;
function SentenciaINSERTINT0TABLE_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
 case T.Tipo of
 T_PARENTESIS:  Result:= SentenciaINSERTINTOTABLECAMPOS_Parse;


  else
  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
  end;
end;
function SentenciaINSERTINT0TABLECAMPOS_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
   if T.Tipo = T_ID THEN
        BEGIN
          T:= Scanner_SiguienteToken;
        while T.Tipo != T_Parentesis do
        begin
          if T.Tipo = T_COMA THEN
               begin
               T:= Scanner_SiguienteToken;
                   if T.Tipo = T_ID then
                        begin
                          T:= Scanner_SiguienteToken;
                        end;
                   else T.Tipo != T_ID then
                        begin
                           writeln('Error: token inesperado');
                            Result := false;
                             break;

                          end;
               end;
          else if T.tipo != T_PARENTESIS THEN
                begin
    writeln('Error: token inesperado');
    Result := false;
    break;
  end;




          end;
        Result:= SentenciaINSERTINTOTABLECAMPOSVALUES_Parse;

          END;
   ELSE
       BEGIN
          writeln('Error: token inesperado');
          Result := false;
         END;

 end;
function SentenciaINSERTINT0TABLECAMPOSVALUES_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
 case T.Tipo of
 T_PARENTESIS:  Result:= SentenciaINSERTINTOTABLECAMPOSVALUESDATOS_Parse;



  begin
    writeln('Error: token inesperado');
    Result := false;
  end;
  end;
end;
function SentenciaINSERTINT0TABLECAMPOSVALUESDATOS_Parse: boolean;
begin
  Scanner_Avanzar;
  T := Scanner_SiguienteToken;
   if T.Tipo = T_ID THEN
        BEGIN
          T:= Scanner_SiguienteToken;
        while T.Tipo != T_Parentesis do
        begin
          if T.Tipo = T_COMA THEN
               begin
               T:= Scanner_SiguienteToken;
                   if T.Tipo = T_ID then
                        begin
                          T:= Scanner_SiguienteToken;
                        end;
                   else T.Tipo != T_ID then
                        begin
                           writeln('Error: token inesperado');
                            Result := false;
                             break;

                          end;
               end;
          else if T.tipo != T_PARENTESIS THEN
                begin
    writeln('Error: token inesperado');
    Result := false;
    break;
  end;




          end;
        Result:= SentenciaINSERTINTOTABLECAMPOSVALUESDATOS_Interpret;

          END;
    ELSE
       BEGIN
          writeln('Error: token inesperado');
          Result := false;
         END;

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
