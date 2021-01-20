clear all; clc
% define input and output directories
inDir   = 'I:\merge_China_srfdata';
outDir  = 'I:\merge_China_srfdata';

inFile_b11  = 'domain.lnd.140x80pt_ECMWF_noocean.201130_b11.nc';
inDirFile_b11 = [inDir, '\', inFile_b11];
inFile_b12  = 'domain.lnd.140x80pt_ECMWF_noocean.201128_b12.nc';
inDirFile_b12 = [inDir, '\', inFile_b12];

outFile = 'domain.lnd.280x80pt_North_China_ECMWF_noocean.201202.nc';
outDirFile = [outDir, '\', outFile];
outid = netcdf.create(outFile,'64BIT_OFFSET');

% define dimensions
ndimID  = netcdf.defDim(outid, 'n', 11200);
nidimID = netcdf.defDim(outid, 'ni', 280);
njdimID = netcdf.defDim(outid, 'nj', 80);
nvdimID = netcdf.defDim(outid, 'nv', 4);

% define variables
xc_id   = netcdf.defVar(outid, 'xc', 'NC_DOUBLE', [nidimID, njdimID]);
yc_id   = netcdf.defVar(outid, 'yc', 'NC_DOUBLE', [nidimID, njdimID]);
xv_id   = netcdf.defVar(outid, 'xv', 'NC_DOUBLE', [nvdimID, nidimID, njdimID]);
yv_id   = netcdf.defVar(outid, 'yv', 'NC_DOUBLE', [nvdimID, nidimID, njdimID]);
mask_id = netcdf.defVar(outid, 'mask', 'NC_INT', [nidimID, njdimID]);
area_id = netcdf.defVar(outid, 'area', 'NC_DOUBLE', [nidimID, njdimID]);
frac_id = netcdf.defVar(outid, 'frac', 'NC_DOUBLE', [nidimID, njdimID]);

netcdf.endDef(outid);

% read nc files and merge variables
xc_b11 = ncread(inDirFile_b11, 'xc');
xc_b12 = ncread(inDirFile_b12, 'xc');
xc_cmb = cat(1, xc_b11, xc_b12);

yc_b11 = ncread(inDirFile_b11, 'yc');
yc_b12 = ncread(inDirFile_b12, 'yc');
yc_cmb = cat(1, yc_b11, yc_b12);

xv_b11 = ncread(inDirFile_b11, 'xv');
xv_b12 = ncread(inDirFile_b12, 'xv');
xv_cmb = cat(2, xv_b11, xv_b12);

yv_b11 = ncread(inDirFile_b11, 'yv');
yv_b12 = ncread(inDirFile_b12, 'yv');
yv_cmb = cat(2, yv_b11, yv_b12);

mask_b11 = ncread(inDirFile_b11, 'mask');
mask_b12 = ncread(inDirFile_b12, 'mask');
mask_cmb = cat(1, mask_b11, mask_b12);

area_b11 = ncread(inDirFile_b11, 'area');
area_b12 = ncread(inDirFile_b12, 'area');
area_cmb = cat(1, area_b11, area_b12);

frac_b11 = ncread(inDirFile_b11, 'frac');
frac_b12 = ncread(inDirFile_b12, 'frac');
frac_cmb = cat(1, frac_b11, frac_b12);

% put variables into nc
netcdf.putVar(outid, xc_id, xc_cmb);
netcdf.putVar(outid, yc_id, yc_cmb);
netcdf.putVar(outid, xv_id, xv_cmb);
netcdf.putVar(outid, yv_id, yv_cmb);
netcdf.putVar(outid, mask_id, mask_cmb);
netcdf.putVar(outid, area_id, area_cmb);
netcdf.putVar(outid, frac_id, frac_cmb);

netcdf.reDef(outid);

netcdf.putAtt(outid, xc_id, 'longname', 'longitude of grid cell center');
netcdf.putAtt(outid, xc_id, 'units', 'degrees_east');
netcdf.putAtt(outid, xc_id, 'bounds', 'xv');

netcdf.putAtt(outid, yc_id, 'longname', 'latitude of grid cell center');
netcdf.putAtt(outid, yc_id, 'units', 'degrees_north');
netcdf.putAtt(outid, yc_id, 'bounds', 'yv');

netcdf.putAtt(outid, xv_id, 'longname', 'longitude of grid cell verticies');
netcdf.putAtt(outid, xv_id, 'units', 'degrees_east');

netcdf.putAtt(outid, yv_id, 'longname', 'latitude of grid cell verticies');
netcdf.putAtt(outid, yv_id, 'units', 'degrees_north');

netcdf.putAtt(outid, mask_id, 'longname', 'domain mask');
netcdf.putAtt(outid, mask_id, 'note', 'unitless');
netcdf.putAtt(outid, mask_id, 'coordinates', 'xc yc');
netcdf.putAtt(outid, mask_id, 'comment', '0 value indicates cell is not active');

netcdf.putAtt(outid, area_id, 'longname', 'area of grid cell in radians squared');
netcdf.putAtt(outid, area_id, 'coordinates', 'xc yc');
netcdf.putAtt(outid, area_id, 'units', 'radian2');

netcdf.putAtt(outid, frac_id, 'longname', 'fraction of grid cell that is active');
netcdf.putAtt(outid, frac_id, 'coordinates', 'xc yc');
netcdf.putAtt(outid, frac_id, 'note', 'unitless');
netcdf.putAtt(outid, frac_id, 'filter1', 'error if frac> 1.0+eps or frac < 0.0-eps; eps = 0.1000000E-11');
netcdf.putAtt(outid, frac_id, 'filter2', 'limit frac to [fminval,fmaxval]; fminval= 0.1000000E-02 fmaxval=  1.000000');

% define global attribution
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'title', 'CESM domain data');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Conventions', 'CF-1.0');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'source_code', 'SVN $Id: gen_domain.F90 65202 2014-11-06 21:07:45Z mlevy@ucar.edu $');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'SVN_url', '$URL: https://svn-ccsm-models.cgd.ucar.edu/tools/mapping/gen_domain/trunk/src/gen_domain.F90 $');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Compiler_Optimized', 'TRUE');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'hostname', '');

netcdf.close(outid);