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

unit UArrayDescriptor;
{$INCLUDE def.inc}
{$MODE DELPHI}
interface
uses gzctnrvectortypes,uzedimensionaltypes,sysutils,LCLProc,TypeDescriptors,uzbtypesbase,varmandef,uzbtypes,gzctnrvectordata,uzbmemman;
type
PArrayIndexDescriptor=^ArrayIndexDescriptor;
ArrayIndexDescriptor=record
                           IndexMin,IndexCount:GDBInteger;
                     end;
TArrayIndexDescriptorVector=GZVectorData<ArrayIndexDescriptor>;
PArrayDescriptor=^ArrayDescriptor;
ArrayDescriptor=object(TUserTypeDescriptor)
                     NumOfIndex:GDBInteger;
                     typeof:PUserTypeDescriptor;
                     Indexs:{GDBOpenArrayOfData}TArrayIndexDescriptorVector;
                     constructor init(var t:PUserTypeDescriptor;tname:string;pu:pointer);
                     procedure AddIndex(var Index:ArrayIndexDescriptor);
                     function CreateProperties(const f:TzeUnitsFormat;mode:PDMode;PPDA:PTPropertyDeskriptorArray;Name:TInternalScriptString;PCollapsed:Pointer;ownerattrib:Word;var bmode:Integer;var addr:Pointer;ValKey,ValType:TInternalScriptString):PTPropertyDeskriptorArray;virtual;
                     destructor Done;virtual;
                     function GetValueAsString(pinstance:Pointer):TInternalScriptString;virtual;
               end;
implementation
uses {ZBasicVisible,}varman;
function ArrayDescriptor.GetValueAsString(pinstance:Pointer):TInternalScriptString;
var
   PAID:PArrayIndexDescriptor;
   ir:itrec;
   i:integer;
begin
     result:='(';
     PAID:=Indexs.beginiterate(ir);
     if paid<>nil then
                     repeat
                           for i:=paid^.IndexMin to paid^.IndexMin+paid^.IndexCount-1 do
                           begin
                                if i<>paid^.IndexMin then
                                                         begin
                                                              result:=result+',';
                                                              //if typeof^.GetTypeAttributes=TA_COMPOUND then result:=result+#10#13;
                                                         end;
                                result:=result+typeof^.GetValueAsString(pinstance);
                                typeof^.IncAddr(pinstance);
                           end;
                           PAID:=Indexs.iterate(ir);
                     until paid=nil;
     result:=result+')'{#10#13;};
end;

constructor ArrayDescriptor.init;
begin
     inherited init(0,tname,pu);
     NumOfIndex:=0;
     typeof:=t;
     Indexs.init({$IFDEF DEBUGBUILD}'{1A33FBB9-F27B-4CF2-8C08-852A22572791}',{$ENDIF}20{,sizeof(ArrayIndexDescriptor)});
end;
destructor ArrayDescriptor.done;
begin
     inherited;
     Indexs.Done;
end;
procedure ArrayDescriptor.AddIndex;
begin
     indexs.PushBackData(Index);
     inc(NumOfIndex);
     SizeInGDBBytes:=SizeInGDBBytes+typeof^.SizeInGDBBytes*Index.IndexCount
end;
function ArrayDescriptor.CreateProperties;
var ppd:PPropertyDeskriptor;
begin
     if VerboseLog^ then
       debugln(sysutils.Format('{T}[ZSCRIPT]ArrayDescriptor.CreateProperties(%s)',[name]));
     //programlog.LogOutFormatStr('ArrayDescriptor.CreateProperties(%s)',[name],lp_OldPos,LM_Trace);
     ppd:=GetPPD(ppda,bmode);
     ppd^.Name:=name;
     ppd^.PTypeManager:=@self;
     ppd^.Attr:=ownerattrib;
     ppd^.Collapsed:=PCollapsed;
     ppd^.valueAddres:=addr;
     ppd^.value:=GetValueAsString(addr);//'not ready';

           if ppd<>nil then
                           begin
                                //IncAddr(addr);
                                //inc(pGDBByte(addr),SizeInGDBBytes);
                                //if bmode=property_build then PPDA^.add(@ppd);
                           end;
     IncAddr(addr);
end;
begin
end.
