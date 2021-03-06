{
*****************************************************************************
*                                                                           *
*  This file is part of the ZCAD                                            *
*                                                                           *
*  See the file COPYING.modifiedLGPL.txt, included in this distribution,    *
*  for details about the copyright.                                         *
*                                                                           *
*  This program is distributed in the hope that it will be useful,          *
*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
*                                                                           *
*****************************************************************************
}
{
@author(Andrey Zubarev <zamtmn@yandex.ru>) 
}

unit uzgeomproxy;
{$INCLUDE def.inc}
interface
uses uzgeomentity,//uzgprimitivessarray,math,uzglgeomdata,uzgldrawcontext,uzgvertex3sarray,uzgldrawerabstract,
     {uzbtypesbase,}sysutils,uzbtypes,uzbmemman,
     gzctnrvectortypes,uzbgeomtypes,uzegeometry;
type
{Export+}
PTGeomProxy=^TGeomProxy;
TGeomProxy={$IFNDEF DELPHI}packed{$ENDIF} object(TGeomEntity)
                                             LLEntsStart,LLEntsEnd:TArrayIndex;
                                             BB:TBoundingBox;
                                             constructor init(const LLS,LLE:TArrayIndex;const _BB:TBoundingBox);
                                             function GetBB:TBoundingBox;virtual;
                                           end;
{Export-}
implementation
function TGeomProxy.GetBB:TBoundingBox;
begin
  result:=BB;
end;
constructor TGeomProxy.init(const LLS,LLE:TArrayIndex;const _BB:TBoundingBox);
begin
  LLEntsStart:=LLS;
  LLEntsEnd:=LLE;
  bb:=_bb;
end;
begin
end.

