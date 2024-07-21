function varargout = prog1(varargin)
% PROG1 MATLAB code for prog1.fig
%      PROG1, by itself, creates a new PROG1 or raises the existing
%      singleton*.
%
%      H = PROG1 returns the handle to a new PROG1 or the handle to
%      the existing singleton*.
%
%      PROG1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROG1.M with the given input arguments.
%
%      PROG1('Property','Value',...) creates a new PROG1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prog1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prog1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prog1

% Last Modified by GUIDE v2.5 09-Dec-2023 04:52:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prog1_OpeningFcn, ...
                   'gui_OutputFcn',  @prog1_OutputFcn, ...
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


% --- Executes just before prog1 is made visible.
function prog1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prog1 (see VARARGIN)

% Choose default command line output for prog1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prog1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prog1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_image_pb.
function select_image_pb_Callback(hObject, eventdata, handles)
% hObject    handle to select_image_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1 im2
[path, nofile] = imgetfile();
if nofile
    msgbox(sprintf('Image not Found'), 'Error', 'Warning');
    return
end
im1 = imread(path);
im1 = im2double(im1);
im2 = im1;
handles.im1 = im1; % Store im1 in handles structure
guidata(hObject, handles); % Update handles structure
axes(handles.axes1);
imshow(im1)

% --- Executes on button press in huffman_en_pb.
function huffman_en_pb_Callback(hObject, eventdata, handles)
% hObject    handle to huffman_en_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Use try-catch block to handle errors
try
    % Access im1 from handles structure
    I = handles.im1;
    I = uint8(I * 255);
catch
    msgbox('Error accessing the image. Please select an image first.', 'Error', 'Warning');
end

% Get the dimensions (rows and columns) of the image
[m,n] = size(I);

% Calculate the total number of pixels in the image
Totalcount = m * n;
disp("Total count:");
disp(Totalcount);

[r,g,b] = imsplit(I);

handles.r = r; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.g = g; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.b = b; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure

disp(r);
disp(g);
disp(b);

% Get the dimensions (rows and columns) of the image
[m_r,n_r] = size(r);

% Calculate the total number of pixels in the image for RGB

Totalcount_r = m_r * n_r;

[m_g,n_g] = size(g);

Totalcount_g = m_g * n_g;

[m_b,n_b] = size(b);

Totalcount_b = m_b * n_b;

handles.m_r = m_r; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.m_g = m_g; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.m_b = m_b; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure

handles.n_r = n_r; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.n_g = n_g; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.n_b = n_b; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure

% Find unique pixel values in the image for RGB

symbols_r = unique(r);
symbols_g = unique(g);
symbols_b = unique(b);

% Count the occurrences of each unique pixel value in the image for RGB

counts_r = histc(r(:), symbols_r);
counts_g = histc(g(:), symbols_g);
counts_b = histc(b(:), symbols_b);

% Calculate the probabilities of each unique pixel value for RGB

pro_r = counts_r ./ Totalcount_r;
pro_g = counts_g ./ Totalcount_g;
pro_b = counts_b ./ Totalcount_b;

disp("Huffman symbols");
disp(symbols_r);
disp(symbols_g);
disp(symbols_b);

disp("Huffman probabilities");
disp(pro_r);
disp(pro_g);
disp(pro_b);

% Generate Huffman dictionary and average code length for RGB

[dict_r, avglen_r] = huffmandict(symbols_r, pro_r);
[dict_g, avglen_g] = huffmandict(symbols_g, pro_g);
[dict_b, avglen_b] = huffmandict(symbols_b, pro_b);

handles.dict_r = dict_r; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.dict_g = dict_g; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.dict_b = dict_b; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure

disp("Huffman dictionary");
disp(dict_r);
disp(dict_g);
disp(dict_b);

% Reshape the image into a vector for Huffman encoding

newvec_r = reshape(r, 1, []);
newvec_g = reshape(g, 1, []);
newvec_b = reshape(b, 1, []);

% Perform Huffman encoding using the generated dictionary
hcode_r = huffmanenco(newvec_r, dict_r);
hcode_g = huffmanenco(newvec_g, dict_g);
hcode_b = huffmanenco(newvec_b, dict_b);

disp("Huffman codes:");
disp(hcode_r);
disp(hcode_r);
disp(hcode_r);

handles.hcode_r = hcode_r; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.hcode_g = hcode_g; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure
handles.hcode_b = hcode_b; % Store hcode_r in handles structure
guidata(hObject, handles); % Update handles structure

set(handles.txt_hcode_r, 'String', num2str(hcode_r));
set(handles.txt_hcode_g, 'String', num2str(hcode_g));
set(handles.txt_hcode_b, 'String', num2str(hcode_b));

% Calculate entropy of the original image
H = entropy(uint8(I));
disp('Entropy is:');
disp(H);

[~, length_r_comp] = size(hcode_r);
disp(length_r_comp);

[~, length_g_comp] = size(hcode_g);
disp(length_g_comp);

[~, length_b_comp] = size(hcode_b);
disp(length_b_comp);


% Calculate compression ratio
Cr_r = (Totalcount_r * 8) / length_r_comp;
disp('Compression ratio R is:');
disp(Cr_r);

Cr_g = (Totalcount_g * 8) / length_g_comp;
disp('Compression ratio G is:');
disp(Cr_g);

Cr_b = (Totalcount_b * 8) / length_b_comp;
disp('Compression ratio B is:');
disp(Cr_b);


Cr_total = (Totalcount * 8 * 3) / (length_r_comp + length_g_comp + length_b_comp);
disp('Compression ratio in total is:');
disp(Cr_total);

set(handles.txt_Cr_r, 'String', num2str(Cr_r));
set(handles.txt_Cr_g, 'String', num2str(Cr_g));
set(handles.txt_Cr_b, 'String', num2str(Cr_b));
set(handles.txt_Cr_total, 'String', num2str(Cr_total));

% --- Executes on button press in huffman_dec_pb.
function huffman_dec_pb_Callback(hObject, eventdata, handles)
% hObject    handle to huffman_dec_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Perform Huffman decoding using the generated dictionary

hcode_r = handles.hcode_r; % Retrieve hcode_r from handles structure
hcode_g = handles.hcode_g; % Retrieve hcode_g from handles structure
hcode_b = handles.hcode_b; % Retrieve hcode_b from handles structure

dict_r = handles.dict_r; % Retrieve dict_r from handles structure
dict_g = handles.dict_g; % Retrieve dict_r from handles structure
dict_b = handles.dict_b; % Retrieve dict_r from handles structure

m_r = handles.m_r; % Retrieve m_r from handles structure
m_g = handles.m_g; % Retrieve m_r from handles structure
m_b = handles.m_b; % Retrieve m_r from handles structure

n_r = handles.n_r; % Retrieve m_r from handles structure
n_g = handles.n_g; % Retrieve m_r from handles structure
n_b = handles.n_b; % Retrieve m_r from handles structure

disp("Huffman encoded code");
disp(hcode_r);
disp(hcode_g);
disp(hcode_b);

disp("Huffman dictionary");
disp(dict_r);
disp(dict_g);
disp(dict_b);

DD1_r = huffmandeco(hcode_r, dict_r);
disp("Huffman decoded code");
disp(DD1_r);

DD1_g = huffmandeco(hcode_g, dict_g);
disp(DD1_g);

DD1_b = huffmandeco(hcode_b, dict_b);
disp(DD1_b);


% Convert the decoded code back to uint8 format and reshape to original dimensions
DD_r = uint8(DD1_r);
Restore_r = reshape(DD_r, m_r, n_r);
disp("Restored code");
disp(Restore_r);

DD_g = uint8(DD1_g);
Restore_g = reshape(DD_g, m_g, n_g);
disp(Restore_g);

DD_b = uint8(DD1_b);
Restore_b = reshape(DD_b, m_b, n_b);
disp(Restore_b);

% Combine the restored R, G, and B layers into a single RGB image
combinedImage = cat(3, Restore_r, Restore_g, Restore_b);

axes(handles.axes2);
imshow(combinedImage)

Orig_r = handles.r;
Orig_g = handles.g;
Orig_b = handles.b;

mse_r = sum((double(Orig_r) - double(Restore_r)).^2, 'all') / (m_r * n_r);
disp("MSE for R:");
disp(mse_r);

mse_g = sum((double(Orig_g) - double(Restore_g)).^2, 'all') / (m_g * n_g);
disp("MSE for G:");
disp(mse_g);

mse_b = sum((double(Orig_b) - double(Restore_b)).^2, 'all') / (m_b * n_b);
disp("MSE for B:");
disp(mse_b);

set(handles.txt_mse_r, 'String', num2str(mse_r));
set(handles.txt_mse_g, 'String', num2str(mse_g));
set(handles.txt_mse_b, 'String', num2str(mse_b));

max_pixel_value = 255; % Assuming pixel values are in the range [0, 255]
psnr_r = 10 * log10((max_pixel_value^2) / mse_r);
disp("PSNR for R:");
disp(psnr_r);

psnr_g = 10 * log10((max_pixel_value^2) / mse_g);
disp("PSNR for G:");
disp(psnr_g);

psnr_b = 10 * log10((max_pixel_value^2) / mse_b);
disp("PSNR for B:");
disp(psnr_b);

set(handles.txt_psnr_r, 'String', num2str(psnr_r));
set(handles.txt_psnr_g, 'String', num2str(psnr_g));
set(handles.txt_psnr_b, 'String', num2str(psnr_b));


% --- Executes on button press in clear_all_pb.
function clear_all_pb_Callback(hObject, eventdata, handles)
% hObject    handle to clear_all_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.txt_hcode_r,'string','');
set(handles.txt_hcode_g,'string','');
set(handles.txt_hcode_b,'string','');

set(handles.txt_Cr_r,'string','');
set(handles.txt_Cr_g,'string','');
set(handles.txt_Cr_b,'string','');
set(handles.txt_Cr_total,'string','');

set(handles.txt_mse_r,'string','');
set(handles.txt_mse_g,'string','');
set(handles.txt_mse_b,'string','');

set(handles.txt_psnr_r,'string','');
set(handles.txt_psnr_g,'string','');
set(handles.txt_psnr_b,'string','');

 cla(handles.axes1,'reset');
 cla(handles.axes2,'reset');

 % Set X and Y axes ticks to empty
set(handles.axes1, 'XTick', []);
set(handles.axes1, 'YTick', []);

set(handles.axes2, 'XTick', []);
set(handles.axes2, 'YTick', []);

% Hide X and Y axis lines
set(handles.axes1, 'XColor', 'none');
set(handles.axes1, 'YColor', 'none');

set(handles.axes2, 'XColor', 'none');
set(handles.axes2, 'YColor', 'none');

clear all;
clc;

% --- Executes on button press in exit_pb.
function exit_pb_Callback(hObject, eventdata, handles)
% hObject    handle to exit_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq(); 


% --- Executes on button press in txt_Cr_g.
function txt_Cr_g_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Cr_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in txt_Cr_b.
function txt_Cr_b_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Cr_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in txt_mse_g.
function txt_mse_g_Callback(hObject, eventdata, handles)
% hObject    handle to txt_mse_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in txt_mse_b.
function txt_mse_b_Callback(hObject, eventdata, handles)
% hObject    handle to txt_mse_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in txt_psnr_g.
function txt_psnr_g_Callback(hObject, eventdata, handles)
% hObject    handle to txt_psnr_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in txt_psnr_b.
function txt_psnr_b_Callback(hObject, eventdata, handles)
% hObject    handle to txt_psnr_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
