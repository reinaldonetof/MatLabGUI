function varargout = gui_ctrc(varargin)
% GUI_CTRC MATLAB code for gui_ctrc.fig
%      GUI_CTRC, by itself, creates a new GUI_CTRC or raises the existing
%      singleton*.
%
%      H = GUI_CTRC returns the handle to a new GUI_CTRC or the handle to
%      the existing singleton*.
%
%      GUI_CTRC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CTRC.M with the given input arguments.
%
%      GUI_CTRC('Property','Value',...) creates a new GUI_CTRC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_ctrc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_ctrc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_ctrc

% Last Modified by GUIDE v2.5 14-Jun-2016 16:25:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_ctrc_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_ctrc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_ctrc is made visible.
function gui_ctrc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_ctrc (see VARARGIN)

% Choose default command line output for gui_ctrc
handles.output = hObject

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_ctrc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_ctrc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in hlis.
function hlis_Callback(hObject, eventdata, handles)
% hObject    handle to hlis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hlis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hlis


% --- Executes during object creation, after setting all properties.
function hlis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hlis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hini.
function hini_Callback(hObject, eventdata, handles)
% hObject    handle to hini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if isempty(handles.
    
handles.hini.Enable='off';
handles.hfim.Enable='on';
uicontrol(handles.hfim);


if isfield(handles,'cont')==0
    cont=1;
else
    cont=handles.cont;
end

temp = handles.activex1.controls.currentPosition;
temp = seconds(temp);
tempo = duration(temp,'Format','hh:mm:ss.SSS');
tempo = char(tempo);
text=[handles.nomurl '.srt'];
fid=fopen(text,'a+');
fprintf(fid,'%i\n',cont);
fprintf(fid,'%s --> ',tempo);
fclose(fid);



handles.cont=cont+1;
guidata(hObject, handles);
% 'estava em ini'
% --- Executes on button press in hfim.
function hfim_Callback(hObject, eventdata, handles)
% hObject    handle to hfim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.hini.Enable='on';
handles.hfim.Enable='off';
uicontrol(handles.hini);
temp = handles.activex1.controls.currentPosition;
temp = seconds(temp);
tempo = duration(temp,'Format','hh:mm:ss.SSS');
tempo = char(tempo);
text=[handles.nomurl '.srt'];
fid=fopen(text,'a+');
fprintf(fid,'%s\n',tempo);
fprintf(fid,'%s\n',handles.a{1});
fprintf(fid,'\n');
fclose(fid);
string=handles.a(2:end);
handles.hlis.String=string;
handles.a=string;

guidata(hObject, handles);

% 'estava em fim'

% --------------------------------------------------------------------
function Colar_Callback(hObject, eventdata, handles)
% hObject    handle to Colar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = clipboard('paste');

a=strsplit(str,'\n');

f=@(x) isempty(x);
vaz=cellfun(f,a);
a(vaz)=[];
handles.hlis.String=a;
if ~isempty(handles.hlis.String) && ~isempty(handles.activex1.URL)
     handles.pus_play.Enable='on';
end
handles.a=a;
guidata(hObject, handles);


% --- Executes on button press in pus_loadvid.
function pus_loadvid_Callback(hObject, eventdata, handles)
% hObject    handle to pus_loadvid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename1, filepath1]=uigetfile({'*.*','All Files'},'Select Data File 1');
handles.activex1.URL=[filepath1 filename1];
handles.nomurl = filename1(1:end-4);
if ~isempty(handles.hlis.String) && ~isempty(handles.activex1.URL)
     handles.pus_play.Enable='on';
end
handles.static_text.String = handles.nomurl;
guidata(hObject, handles);


% --- Executes on button press in pus_play.
function pus_play_Callback(hObject, eventdata, handles)
% hObject    handle to pus_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=3:-1:0
    if (i==0)
        handles.pus_play.String = [];
        handles.activex1.controls.play();
        handles.pus_play.FontSize = 20;
        handles.pus_play.String = 'PLAY';
        handles.pus_play.Enable='off';
    else
    handles.pus_play.String = [];
    handles.pus_play.Enable = 'on';
    handles.pus_play.FontSize = 30;
    handles.pus_play.String = [num2str(i) ' s'];
    pause(0.5);
    handles.pus_play.Enable = 'off';
    pause(0.5);
    end
end
uicontrol(handles.hini);
