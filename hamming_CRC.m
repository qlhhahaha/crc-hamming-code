function varargout = hamming_CRC(varargin)
% HAMMING_CRC MATLAB code for hamming_CRC.fig
%      HAMMING_CRC, by itself, creates a new HAMMING_CRC or raises the existing
%      singleton*.
%
%      H = HAMMING_CRC returns the handle to a new HAMMING_CRC or the handle to
%      the existing singleton*.
%
%      HAMMING_CRC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HAMMING_CRC.M with the given input arguments.
%
%      HAMMING_CRC('Property','Value',...) creates a new HAMMING_CRC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hamming_CRC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hamming_CRC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hamming_CRC

% Last Modified by GUIDE v2.5 25-Apr-2022 21:31:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hamming_CRC_OpeningFcn, ...
                   'gui_OutputFcn',  @hamming_CRC_OutputFcn, ...
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


% --- Executes just before hamming_CRC is made visible.
function hamming_CRC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hamming_CRC (see VARARGIN)

% Choose default command line output for hamming_CRC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hamming_CRC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hamming_CRC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_incode_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to edit_incode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_incode_hamming as text
%        str2double(get(hObject,'String')) returns contents of edit_incode_hamming as a double


% --- Executes during object creation, after setting all properties.
function edit_incode_hamming_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_incode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_code_hamming.
function pushbutton_code_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_code_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkflag=0;
checkincode=str2double(get(handles.edit_incode_hamming,'String'));
if isnan(checkincode)
    set(handles.edit_incode_hamming, 'String','');
    errordlg('必须输入数字','Error');%报错只能输入数字
    checkflag=1;
elseif checkincode <0
    set(handles.edit_incode_hamming, 'String','');
    errordlg('输入要为正二进制数','Error');
    checkflag=1;
elseif rem(checkincode,1)>0
    set(handles.edit_incode_hamming, 'String','');
    errordlg('输入要为二进制整数','Error');
    checkflag=1;
else
    checkincode=get(handles.edit_incode_hamming,'String');
    for i=1:length(checkincode)
        if checkincode(i) ~= '0' && checkincode(i) ~= '1'
            set(handles.edit_incode_hamming, 'String','');
            errordlg('输入要为二进制数','Error');
            checkflag=1;
            break;
        end
    end
end

if checkflag == 0
    incode=get(handles.edit_incode_hamming,'String');
    code=str2double(incode(1));
    for i=2:length(incode)
        code=[code str2double(incode(i))];
    end
    outcode=hamming_code(code);
    outcode_str=cell2mat(strrep(cellstr(num2str(outcode)),' ',''));
    set(handles.edit_outcode_hamming,'String',outcode_str);
end

% --- Executes on button press in pushbutton_decode_hamming.
function pushbutton_decode_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indecode=get(handles.edit_incode_hamming,'String');
decode=str2double(indecode(1));
for i=2:length(indecode)
    decode=[decode str2double(indecode(i))];
end
[outdecode, iswrong]=hamming_decode(decode);
outdecode_str=cell2mat(strrep(cellstr(num2str(outdecode)),' ',''));
set(handles.edit_outdecode_hamming,'String',outdecode_str);
if iswrong == 0
    check_str = '编码无错误';
    set(handles.edit_check_hamming,'String',check_str);
else
    check_str = ['编码在第',num2str(iswrong),'位出错'];
    set(handles.edit_check_hamming,'String',check_str);
end


function edit_outcode_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outcode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outcode_hamming as text
%        str2double(get(hObject,'String')) returns contents of edit_outcode_hamming as a double


% --- Executes during object creation, after setting all properties.
function edit_outcode_hamming_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outcode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_outdecode_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outdecode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outdecode_hamming as text
%        str2double(get(hObject,'String')) returns contents of edit_outdecode_hamming as a double


% --- Executes during object creation, after setting all properties.
function edit_outdecode_hamming_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outdecode_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_check_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to edit_check_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_check_hamming as text
%        str2double(get(hObject,'String')) returns contents of edit_check_hamming as a double


% --- Executes during object creation, after setting all properties.
function edit_check_hamming_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_check_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_g_crc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_g_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_g_crc as text
%        str2double(get(hObject,'String')) returns contents of edit_g_crc as a double


% --- Executes during object creation, after setting all properties.
function edit_g_crc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_g_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_incode_crc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_incode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_incode_crc as text
%        str2double(get(hObject,'String')) returns contents of edit_incode_crc as a double


% --- Executes during object creation, after setting all properties.
function edit_incode_crc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_incode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_code_crc.
function pushbutton_code_crc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_code_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkflag=0;
checkincode=str2double(get(handles.edit_g_crc,'String'));
if isnan(checkincode)
    set(handles.edit_g_crc, 'String','');
    errordlg('必须输入数字','Error');%报错只能输入数字
    checkflag=1;
elseif checkincode <0
    set(handles.edit_g_crc, 'String','');
    errordlg('输入要为正二进制数','Error');
    checkflag=1;
elseif rem(checkincode,1)>0
    set(handles.edit_g_crc, 'String','');
    errordlg('输入要为二进制整数','Error');
    checkflag=1;
else
    checkincode=get(handles.edit_g_crc,'String');
    for i=1:length(checkincode)
        if checkincode(i) ~= '0' && checkincode(i) ~= '1'
            set(handles.edit_g_crc, 'String','');
            errordlg('输入要为二进制数','Error');
            checkflag=1;
            break;
        end
    end
end

if checkflag == 0
    G=get(handles.edit_g_crc,'String');
    Gcode=str2double(G(1));
    for i=2:length(G)
        Gcode=[Gcode str2double(G(i))];
    end
    incode=get(handles.edit_incode_crc,'String');
    code=str2double(incode(1));
    for i=2:length(incode)
        code=[code str2double(incode(i))];
    end
    outcode=crc_encode(Gcode,code);
    outcode_str=cell2mat(strrep(cellstr(num2str(outcode)),' ',''));
    set(handles.edit_outcode_crc,'String',outcode_str);
end



% --- Executes on button press in pushbutton_decode_crc.
function pushbutton_decode_crc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkflag=0;
checkincode=str2double(get(handles.edit_g_crc,'String'));
if isnan(checkincode)
    set(handles.edit_g_crc, 'String','');
    errordlg('必须输入数字','Error');%报错只能输入数字
    checkflag=1;
elseif checkincode <0
    set(handles.edit_g_crc, 'String','');
    errordlg('输入要为正二进制数','Error');
    checkflag=1;
elseif rem(checkincode,1)>0
    set(handles.edit_g_crc, 'String','');
    errordlg('输入要为二进制整数','Error');
    checkflag=1;
else
    checkincode=get(handles.edit_g_crc,'String');
    for i=1:length(checkincode)
        if checkincode(i) ~= '0' && checkincode(i) ~= '1'
            set(handles.edit_g_crc, 'String','');
            errordlg('输入要为二进制数','Error');
            checkflag=1;
            break;
        end
    end
end
if checkflag == 0
    G=get(handles.edit_g_crc,'String');
    Gcode=str2double(G(1));
    for i=2:length(G)
        Gcode=[Gcode str2double(G(i))];
    end
    incode=get(handles.edit_incode_crc,'String');
    code=str2double(incode(1));
    for i=2:length(incode)
        code=[code str2double(incode(i))];
    end
    isright=crc_check(Gcode,code);
    if isright == 1
        check_str = '余数为0编码无错误';
        set(handles.edit_outdecode_crc,'String',check_str);
    elseif isright == 0
        check_str = '编码有错误';
        set(handles.edit_outdecode_crc,'String',check_str);
    end
end





function edit_outcode_crc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outcode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outcode_crc as text
%        str2double(get(hObject,'String')) returns contents of edit_outcode_crc as a double


% --- Executes during object creation, after setting all properties.
function edit_outcode_crc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outcode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_outdecode_crc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outdecode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outdecode_crc as text
%        str2double(get(hObject,'String')) returns contents of edit_outdecode_crc as a double


% --- Executes during object creation, after setting all properties.
function edit_outdecode_crc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outdecode_crc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
