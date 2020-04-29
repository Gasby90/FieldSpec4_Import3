%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% FieldSpec4 Importer %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Riccardo Gasbarrone 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VER 3.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This works on .ascii data
%After the conversion of .ASD files in ViewSpecPro, this script allow the
%importation of the ascii file into Matlab for processing within 
%PLS_Toolbox.
%REMEMBER:this script replace commas with dots using comma2dot.m script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%replace commas with dots
[filename,pathname] = uigetfile('*.txt', 'pick text file');
wholefile = fileread(filename);       % read in entire file
newfiledata = strrep(wholefile,',','.');    % replace commas with full stops
fileid = fopen(filename,'w');         % open file to write
fprintf(fileid,'%s',newfiledata);           % print to file
fclose(fileid);
%Import data to ascii
%[filename,pathname] = uigetfile({'*.*', 'All Files (*.*)'},'select ASCII file','MultiSelect','on');
%%%%%%%%Separation value: Use '\t' for tab, ',' for comma .
[stmfile, stmpath] = uigetfile('*.txt', 'pick text file');
Data = importdata(fullfile(stmpath, stmfile), '\t');
%delimiterIn = ',';
%Data = importdata(filename);
%select wavelenghts
w=Data.data(:,1);
%transpose wavelenghts
w=w';
%select only spectra(select all the other columns
cubespectra=Data.data(:,2:end);
%transpose spectra matrix
cubespectra=cubespectra';
%select labels
labels=Data.textdata(2:end);
%PLS_toolbox create new dataset
A=dataset(cubespectra);
%clear variables
%Clearvars -except A w labels
%PLS_toolbox set a rough distribution of items at a range of axisscale "bins" in the new dataset
A.axisscale{2}=w;
A.label{1}=labels;
%DEVIDE THE CHANNELS: VNIR,SWIR1 AND SWIR2. 
%VNIR: 350-1000 nm wavelength.
%SWIR 1 for the wavelength range of 1001 nm to 1800 nm.
%SWIR 2 for the wavelength range of 1801 nm to 2500 nm.
%comment those strings below if %you don't want to operate this process.
VNIR=A(:,1:651);%VNIR: 350-1000 nm wavelength.
SWIR1=A(:,652:1451);%1001 nm to 1800 nm.
SWIR2=A(:,1452:end);%1801 nm to 2500 nm.
sizeSWIR1=length(SWIR1);
sizeSWIR2=length(SWIR2);
% Apply splice correction pre-process
%http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:1388298/component/escidoc:1388299/EnMAP_FieldGuide_ASD_2015_008.pdf
% % R1001=A(:, 652);
% % R1000=A(:, 651);
% % R999=A(:, 650);
% % R1801=A(:, 1452);
% % R1800=A(:, 1451);
% % R1799=A(:, 1450);
% % f1000=R1001-(2.*R1000-R999);
% % f1000=f1000';
% % f1000_r=repmat(f1000, sizeSWIR1);
% % f1000_r=f1000_r';
% % f1800=R1801-(2.*R1800-R1799);
% % f1800=f1800';
% % f1800_r=repmat(f1800, sizeSWIR2);
% % f1800_r=f1800_r';
% % SWIR1=SWIR1-f1000_r;
% %SWIR2=SWIR2-f1800_r;

%create final dataset
Afinale=cat(2, VNIR, SWIR1, SWIR2);
%assign file name
Name=strrep(stmfile,'..txt','');
assignin('base',Name,Afinale);
%clear 
clear('A', 'Afinale', 'cubespectra', 'Data', 'f1000', 'f1000_r', 'f1800','f1800_r', 'labels', 'Name', 'R1000', 'R1001', 'R1799', 'R1800', 'R1801', 'R999', 'sizeSWIR1', 'sizeSWIR2', 'stmfile', 'stmpath', 'SWIR1', 'SWIR2', 'VNIR', 'w', 'ans', 'fileid', 'filename', 'newfiledata', 'pathname', 'wholefile' );