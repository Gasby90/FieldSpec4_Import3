# FieldSpec4_Import3
A MATLAB script for importing spectra ASCII data file (from .asd FieldSpec 4 files) in MATLAB workspace.

“FieldSpec4_Import3.m” is a MATLAB code allowing ASCII data file import in MATLAB workspace. The ASCII data result from the conversion of .asd spectra files ( collected using the FieldSpec 4 standard Res) by using the ViewSpec Pro software (ASD Inc).

The procedure to get the ASCII data file from several .ASD files.

  1. Import all the .asd files into ViewSpec Pro;
  2. Select all the .asd files;
  3. Export .asd files into ASCII file;
  4. Select reflectance value and tab separated values;
  5. Open the ASCII file and check if the reflectance decimal values are separated by dot.
  
If the decimal values are separated with commas, use “comma2dot.m” for replacing all commas with dots inside the text file.

The script “fieldspec_import4.m” allows to import ASCII data and creates a Dataset with reflectance values. By running the script, the axis scale is set with the actual wavelength. The labels are set with the name of the data acquisition. The dataset is then called “A”. Then the channels are divided in three wavelength ranges:

  A) VNIR: 350-1000 nm wavelength interval.
  B) SWIR 1:  1001-1800 nm wavelength interval.
  C) SWIR 2: 1801-2500 nm wavelength interval.
  
Starting from the three channels the datasets VNIR, SWIR1 and SWIR2 are created.

The code can be also utilized to perform Splice Correction pre-process to data (see: http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:1388298/component/escidoc:1388299/EnMAP_FieldGuide_ASD_2015_008.pdf). Data are finally stored in a dataset object DSO (Info on how to open the dataset object can be found at the following links: https://www.mathworks.com/matlabcentral/fileexchange/39336-dataset-object ; DataSet Object web page - http://www.eigenvector.com/software/dataset.htm; DataSet Object wiki documentation - http://wiki.eigenvector.com/index.php?title=DataSet_Object ).

The “provaascii.txt” file can be used as an example.
Compatibility was checked with MATLAB Version: R2019a.

[![DOI](https://zenodo.org/badge/259972948.svg)](https://zenodo.org/badge/latestdoi/259972948)
