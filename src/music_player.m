function varargout = music_player(varargin)


% MUSIC_PLAYER MATLAB code for music_player.fig
%      MUSIC_PLAYER, by itself, creates a new MUSIC_PLAYER or raises the existing
%      singleton*.
%
%      H = MUSIC_PLAYER returns the handle to a new MUSIC_PLAYER or the handle to
%      the existing singleton*.
%
%      MUSIC_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUSIC_PLAYER.M with the given input arguments.
%
%      MUSIC_PLAYER('Property','Value',...) creates a new MUSIC_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before music_player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to music_player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help music_player

% Last Modified by GUIDE v2.5 05-Jan-2022 22:52:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @music_player_OpeningFcn, ...
                   'gui_OutputFcn',  @music_player_OutputFcn, ...
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


% --- Executes just before music_player is made visible.
function music_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to music_player (see VARARGIN)

% Choose default command line output for music_player
handles.output = hObject;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

update_filters(hObject,handles);

%set(handles.PlayList,'max',1);
handle.volume=get(handles.VolumeSlider,'value');
set(handles.VolumeVal, 'String',handle.volume);
%Fill_PlayList(hObject,handles,'*.m4a' ,'Music/');
Fill_PlayList(hObject,handles,{'*.mp3','*.m4a'} ,'Music/');

set(handles.ASNone,'Value',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes music_player wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = music_player_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Fill_PlayList(hObject,handles,format,inputDir)

%inputDir = 'Music/';
%for changing the directory of the folder change the 
%address
Files=struct('name',{},'folder',{},'date',{},'bytes',{},'isdir',{},'datenum',{});
for fmt=1:length(format)
Files=[Files; dir([inputDir format{fmt}])];
end
%Files=dir([inputDir format]);
N = length(Files);
C = cell(1,N);
for k = 1:N
    FileNames=Files(k).name;
    C{k} = FileNames;
end
set(handles.PlayList,'String',C);


guidata(hObject,handles)
function y=get_song_path(hObject,handles)
handle.index_selected = get(handles.PlayList,'Value');
list = get(handles.PlayList,'String');
handle.item_selected = list{handle.index_selected};
y=append("Music/",handle.item_selected);
guidata(hObject,handles)



function y=play_song(x,Fs,hObject,handles)

handles.Fs=Fs;
%[x,handles.Fs]=audioread(get_song_path(hObject,handles));
%dur=round(1*(length(x)/round(length(x)/handles.Fs)))-1;
%x=x(1:dur,:);


handles.g1=get(handles.slider0,'value');
handles.g2=get(handles.slider1,'value');
handles.g3=get(handles.slider2,'value');
handles.g4=get(handles.slider3,'value');
handles.g5=get(handles.slider4,'value');
handles.g6=get(handles.slider5,'value');
handles.g7=get(handles.slider6,'value');
handles.g8=get(handles.slider7,'value');
handles.g9=get(handles.slider8,'value');


tic;
%%%%%%%%%%%
N=100;
%%%%%%%%%%%
Fstop=63; %cut off low pass dalama Hz
Apass=handles.g1;
y1=LPF(N,x,Fs,Fstop,Apass);


% %bandpass1
Fstop1=64;
Fstop2=249;
Apass=handles.g2;
y2=BPF(N,x,Fs,Fstop1,Fstop2,Apass);


% %bandpass2
Fstop1=250;
Fstop2=499;
Apass=handles.g3;
y3=BPF(N,x,Fs,Fstop1,Fstop2,Apass);


% %bandpass3
Fstop1=500;
Fstop2=999;
Apass=handles.g4;
y4=BPF(N,x,Fs,Fstop1,Fstop2,Apass);

% %bandpass4
Fstop1=1000;
Fstop2=1999;
Apass=handles.g5;
y5=BPF(N,x,Fs,Fstop1,Fstop2,Apass);

% %bandpass5
Fstop1=2000;
Fstop2=3999;
Apass=handles.g6;
y6=BPF(N,x,Fs,Fstop1,Fstop2,Apass);

% %bandpass6
Fstop1=4000;
Fstop2=7999;
Apass=handles.g7;
y7=BPF(N,x,Fs,Fstop1,Fstop2,Apass);

% %bandpass7
Fstop1=8000;
Fstop2=15999;
Apass=handles.g8;
y8=BPF(N,x,Fs,Fstop1,Fstop2,Apass);

% %highpass
Fstop=16000;
Apass=handles.g9;
y9=HPF(N,x,Fs,Fstop,Apass);
%result

handles.YT=y1+y2+y3+y4+y5+y6+y7+y8+y9;




if get(handles.ASLow,'Value')==1
% %lowpass
Fstop=250; %cut off low pass dalama Hz
Apass=get(handles.BOOST,'value');
tmp=LPF(N,handles.YT,handles.Fs,Fstop,Apass);
handles.YT=handles.YT+Apass*tmp;
    
elseif get(handles.ASMid,'Value')==1
% %bandpass
Fstop1=251;
Fstop2=15000;
Apass=get(handles.BOOST,'value');
tmp=BPF(N,handles.YT,handles.Fs,Fstop1,Fstop2,Apass);
handles.YT=handles.YT+Apass*tmp;
elseif get(handles.ASHigh,'Value')==1
% %highpass
Fstop=15001;
Apass=get(handles.BOOST,'value');
tmp=HPF(N,handles.YT,handles.Fs,Fstop,Apass);
handles.YT=handles.YT+Apass*tmp;
end




if get(handles.SurroundCh,'Value')==1
    handles.YT=surround_sfx(handles.YT,handles.Fs);
end

if get(handles.EchoCh,'Value')==1
    val=get(handles.Slider_soundeffect,'Value');
    handles.YT=echo_sfx(handles.YT,handles.Fs,val,false);
end

if get(handles.MuffledCh,'Value')==1
    handles.YT=muffle_sfx(handles.YT,handles.Fs);
end
if get(handles.SlowCh,'Value')==1
    val=get(handles.SliderSlow,'Value');
    handles.Fs=round(val*handles.Fs);
end

if get(handles.Compare,'Value')==1
    if length(handles.YT(:,1))>length(x(:,2))
     tmp=[x(:,2)' zeros(1,length(handles.YT(:,1))-length(x(:,2)))]';
     handles.YT=[handles.YT(:,1) tmp];
    else
     tmp=[handles.YT(:,1)' zeros(1,length(x(:,2))-length(handles.YT(:,1)))]';
     handles.YT=[tmp x(:,2)];
    end
end
toc
global player;
handle.volume=get(handles.VolumeSlider,'value');
player=audioplayer(handle.volume*handles.YT/100,handles.Fs);
y=player;
%play(player);



function update_filters(hObject,handles)

%[handles.y,handles.Fs] = audioread(handles.fullpathname);
%handles.Volume=get(handles.Slider_soundeffect,'value');

handles.g1=get(handles.slider0,'value');
handles.g2=get(handles.slider1,'value');
handles.g3=get(handles.slider2,'value');
handles.g4=get(handles.slider3,'value');
handles.g5=get(handles.slider4,'value');
handles.g6=get(handles.slider5,'value');
handles.g7=get(handles.slider6,'value');
handles.g8=get(handles.slider7,'value');
handles.g9=get(handles.slider8,'value');

set(handles.val_slider0, 'String',handles.g1);
set(handles.val_slider1, 'String',handles.g2);
set(handles.val_slider2, 'String',handles.g3);
set(handles.val_slider3, 'String',handles.g4);
set(handles.val_slider4, 'String',handles.g5);
set(handles.val_slider5, 'String',handles.g6);
set(handles.val_slider6, 'String',handles.g7);
set(handles.val_slider7, 'String',handles.g8);
set(handles.val_slider8, 'String',handles.g9);
guidata(hObject,handles)




% --- Executes during object creation, after setting all properties.
function PlayButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in PlayButton.
function PlayButton_Callback(hObject, eventdata, handles)
%uistack(handles.PlayButton,'top');
%set(handles.PlayButton,'visible','on');

% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
[x,handles.Fs]=audioread(get_song_path(hObject,handles));
%dur=round(1*(length(x)/round(length(x)/handles.Fs)));
%x=x(1:dur,:);

player=play_song(x,handles.Fs,hObject,handles);
play(player);

uistack(handles.PauseButton,'top');
set(handles.PauseButton,'visible','on');
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of PlayButton



function PlayButton_DeleteFcn(hObject, eventdata, handles)
global player;
stop(player);
guidata(hObject,handles)




% --- Executes on button press in PauseButton.
function PauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
pause(player);
uistack(handles.ResumeButton,'top');
set(handles.ResumeButton,'visible','on');
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function PauseButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
handle.No0fSongs=length(get(handles.PlayList,'String'));
handle.index_selected = get(handles.PlayList,'Value');
if handle.index_selected==1
handle.index_selected=handle.No0fSongs+1;
end
set(handles.PlayList,'Value',handle.index_selected-1);


global player;
[x,handles.Fs]=audioread(get_song_path(hObject,handles));
%dur=round(10*(length(x)/round(length(x)/handles.Fs)));
player=play_song(x,handles.Fs,hObject,handles);
play(player);

uistack(handles.PauseButton,'top');
set(handles.PauseButton,'visible','on');

%handle.index_selected = get(handles.PlayList,'Value');
%disp(handle.index_selected);



% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.listbox3,'string',"Arcane- League of Legends OP - Opening.m4a"); 

handle.No0fSongs=length(get(handles.PlayList,'String'));
handle.index_selected = get(handles.PlayList,'Value');
if handle.index_selected==handle.No0fSongs
handle.index_selected=0;
end
set(handles.PlayList,'Value',handle.index_selected+1);



global player;
[x,handles.Fs]=audioread(get_song_path(hObject,handles));
%dur=round(10*(length(x)/round(length(x)/handles.Fs)));
player=play_song(x,handles.Fs,hObject,handles);
play(player);


uistack(handles.PauseButton,'top');
set(handles.PauseButton,'visible','on');

%handle.index_selected = get(handles.PlayList,'Value');
%disp(handle.index_selected);


% --- Executes on slider movement.
function slider0_Callback(hObject, eventdata, handles)
% hObject    handle to slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g1=get(handles.slider0,'value');
set(handles.val_slider0, 'String',handles.g1);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g2=get(handles.slider1,'value');
set(handles.val_slider1, 'String',handles.g2);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g3=get(handles.slider2,'value');
set(handles.val_slider2, 'String',handles.g3);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g4=get(handles.slider3,'value');
set(handles.val_slider3, 'String',handles.g4);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g5=get(handles.slider4,'value');
set(handles.val_slider4, 'String',handles.g5);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g6=get(handles.slider5,'value');
set(handles.val_slider5, 'String',handles.g6);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g9=get(handles.slider8,'value');
set(handles.val_slider8, 'String',handles.g9);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g7=get(handles.slider6,'value');
set(handles.val_slider6, 'String',handles.g7);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.g8=get(handles.slider7,'value');
set(handles.val_slider7, 'String',handles.g8);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end









% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider7_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider7 as text
%        str2double(get(hObject,'String')) returns contents of val_slider7 as a double


% --- Executes during object creation, after setting all properties.
function val_slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider8_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider8 as text
%        str2double(get(hObject,'String')) returns contents of val_slider8 as a double


% --- Executes during object creation, after setting all properties.
function val_slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider5_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider5 as text
%        str2double(get(hObject,'String')) returns contents of val_slider5 as a double


% --- Executes during object creation, after setting all properties.
function val_slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider6_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider6 as text
%        str2double(get(hObject,'String')) returns contents of val_slider6 as a double


% --- Executes during object creation, after setting all properties.
function val_slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider3_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider3 as text
%        str2double(get(hObject,'String')) returns contents of val_slider3 as a double


% --- Executes during object creation, after setting all properties.
function val_slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider4_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider4 as text
%        str2double(get(hObject,'String')) returns contents of val_slider4 as a double


% --- Executes during object creation, after setting all properties.
function val_slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider1_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider1 as text
%        str2double(get(hObject,'String')) returns contents of val_slider1 as a double


% --- Executes during object creation, after setting all properties.
function val_slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider2_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider2 as text
%        str2double(get(hObject,'String')) returns contents of val_slider2 as a double


% --- Executes during object creation, after setting all properties.
function val_slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_slider0_Callback(hObject, eventdata, handles)
% hObject    handle to val_slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_slider0 as text
%        str2double(get(hObject,'String')) returns contents of val_slider0 as a double


% --- Executes during object creation, after setting all properties.
function val_slider0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in NormalPreset.
function NormalPreset_Callback(hObject, eventdata, handles)
% hObject    handle to NormalPreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider0,'value',0);
set(handles.slider1,'value',0);
set(handles.slider2,'value',0);
set(handles.slider3,'value',0);
set(handles.slider4,'value',0);
set(handles.slider5,'value',0);
set(handles.slider6,'value',0);
set(handles.slider7,'value',0);
set(handles.slider8,'value',0);

update_filters(hObject,handles);

uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');


% --- Executes on button press in PopPreset.
function PopPreset_Callback(hObject, eventdata, handles)
% hObject    handle to PopPreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider0,'value',0);
set(handles.slider1,'value',0);
set(handles.slider2,'value',0);
set(handles.slider3,'value',0);
set(handles.slider4,'value',2);
set(handles.slider5,'value',2);
set(handles.slider6,'value',3);
set(handles.slider7,'value',-2);
set(handles.slider8,'value',-4);

update_filters(hObject,handles);

uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');


% --- Executes on button press in ClassicPreset.
function ClassicPreset_Callback(hObject, eventdata, handles)
% hObject    handle to ClassicPreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider0,'value',0);
set(handles.slider1,'value',0);
set(handles.slider2,'value',-1);
set(handles.slider3,'value',-6);
set(handles.slider4,'value',0);
set(handles.slider5,'value',1);
set(handles.slider6,'value',1);
set(handles.slider7,'value',0);
set(handles.slider8,'value',6);

update_filters(hObject,handles);

uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');

% --- Executes on button press in JazzPreset.
function JazzPreset_Callback(hObject, eventdata, handles)
% hObject    handle to JazzPreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider0,'value',0);
set(handles.slider1,'value',0);
set(handles.slider2,'value',2);
set(handles.slider3,'value',5);
set(handles.slider4,'value',-6);
set(handles.slider5,'value',-2);
set(handles.slider6,'value',-1);
set(handles.slider7,'value',2);
set(handles.slider8,'value',-1);

update_filters(hObject,handles);

uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');



% --- Executes on button press in RockPreset.
function RockPreset_Callback(hObject, eventdata, handles)
% hObject    handle to RockPreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider0,'value',0);
set(handles.slider1,'value',0);
set(handles.slider2,'value',1);
set(handles.slider3,'value',3);
set(handles.slider4,'value',-10);
set(handles.slider5,'value',-2);
set(handles.slider6,'value',-1);
set(handles.slider7,'value',3);
set(handles.slider8,'value',3);

update_filters(hObject,handles);

uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');




% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function VolumeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to VolumeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)handles.VolumeSlider
handle.volume=get(hObject,'Value');
set(handles.VolumeVal, 'String',handle.volume);
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function VolumeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VolumeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ASNone.
function ASNone_Callback(hObject, eventdata, handles)
% hObject    handle to ASNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ASNone,'Value',1);
set(handles.ASLow,'Value',0);
set(handles.ASMid,'Value',0);
set(handles.ASHigh,'Value',0);
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');
% Hint: get(hObject,'Value') returns toggle state of ASNone


% --- Executes on button press in ASLow.
function ASLow_Callback(hObject, eventdata, handles)
% hObject    handle to ASLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ASNone,'Value',0);
set(handles.ASLow,'Value',1);
set(handles.ASMid,'Value',0);
set(handles.ASHigh,'Value',0);
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');
% --- Executes on button press in ASMid.
function ASMid_Callback(hObject, eventdata, handles)
% hObject    handle to ASMid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ASNone,'Value',0);
set(handles.ASLow,'Value',0);
set(handles.ASMid,'Value',1);
set(handles.ASHigh,'Value',0);
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');
% --- Executes on button press in ASHigh.
function ASHigh_Callback(hObject, eventdata, handles)
% hObject    handle to ASHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ASNone,'Value',0);
set(handles.ASLow,'Value',0);
set(handles.ASMid,'Value',0);
set(handles.ASHigh,'Value',1);
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');



% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in PlayList.
function PlayList_Callback(hObject, eventdata, handles)
% hObject    handle to PlayList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handle.index_selected = get(hObject,'Value');

%disp(handle.index_selected);
%songs=["Arcane- League of Legends OP - Opening.m4a","Jaskier - Burn, Butcher, Burn _ The Witcher - Season 2 on Netflix _ Soundtrack +.m4a"];
%set(handles.PlayList,'string',songs);

list = get(hObject,'String');
handles.item_selected = list{handle.index_selected}; % Convert from cell array to string
%disp(handles.item_selected);

% Hints: contents = cellstr(get(hObject,'String')) returns PlayList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PlayList


% --- Executes during object creation, after setting all properties.
function PlayList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlayList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Effects.
function Effects_Callback(hObject, eventdata, handles)
% hObject    handle to Effects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.Effects,'String'));
handle.effect=contents{get(handles.Effects,'Value')};
if handle.effect=="Echo"
    %set(handles.Slider_soundeffect,'visible','on');
else
    %set(handles.Slider_soundeffect,'visible','off');
end
% Hints: contents = cellstr(get(hObject,'String')) returns Effects contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Effects


% --- Executes during object creation, after setting all properties.
function Effects_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Effects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Slider_soundeffect_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_soundeffect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_soundeffect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_soundeffect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in MediaScan.
function MediaScan_Callback(hObject, eventdata, handles)
% hObject    handle to MediaScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fill_PlayList(hObject,handles,{'*.m4a','*.mp3'}' ,'Music/');
%Fill_PlayList(hObject,handles,'*.m4a','Music/');



function VolumeVal_Callback(hObject, eventdata, handles)
% hObject    handle to VolumeVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VolumeVal as text
%        str2double(get(hObject,'String')) returns contents of VolumeVal as a double


% --- Executes during object creation, after setting all properties.
function VolumeVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VolumeVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ResumeButton.
function ResumeButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResumeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
resume(player);
uistack(handles.PauseButton,'top');
set(handles.PauseButton,'visible','on');


% --- Executes on button press in ApplySoundEffects.




function Duration_Callback(hObject, eventdata, handles)
% hObject    handle to Duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Duration as text
%        str2double(get(hObject,'String')) returns contents of Duration as a double


% --- Executes during object creation, after setting all properties.
function Duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function ApplySoundEffects_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ApplySoundEffects_Callback(hObject, eventdata, handles)
uistack(handles.PlayButton,'top');
set(handles.PlayButton,'visible','on');


function ApplySoundEffects_DeleteFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AS_apply.
function AS_apply_Callback(hObject, eventdata, handles)
% hObject    handle to AS_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in SurroundCh.
function SurroundCh_Callback(hObject, eventdata, handles)
% hObject    handle to SurroundCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SurroundCh


% --- Executes on button press in MuffledCh.
function MuffledCh_Callback(hObject, eventdata, handles)
% hObject    handle to MuffledCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MuffledCh


% --- Executes on button press in EchoCh.
function EchoCh_Callback(hObject, eventdata, handles)
% hObject    handle to EchoCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EchoCh


% --- Executes on button press in SlowCh.
function SlowCh_Callback(hObject, eventdata, handles)
% hObject    handle to SlowCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SlowCh


% --- Executes on slider movement.
function SliderSlow_Callback(hObject, eventdata, handles)
% hObject    handle to SliderSlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SliderSlow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderSlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function BOOST_Callback(hObject, eventdata, handles)
% hObject    handle to BOOST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function BOOST_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BOOST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Compare.
function Compare_Callback(hObject, eventdata, handles)
% hObject    handle to Compare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Compare
