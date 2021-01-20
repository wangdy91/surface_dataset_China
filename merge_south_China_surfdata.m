clear all; clc
% define input and output directories
inDir   = 'I:\merge_China_srfdata';
outDir  = 'I:\merge_China_srfdata';

inFile_b21  = 'surfdata_140x80pt_ECMWF_hist_16pfts_Irrig_CMIP6_simyr2000_c201129_b21.nc';
inDirFile_b21 = [inDir, '\', inFile_b21];
inFile_b22  = 'surfdata_140x80pt_ECMWF_hist_16pfts_Irrig_CMIP6_simyr2000_c201129_b22.nc';
inDirFile_b22 = [inDir, '\', inFile_b22];

outFile = 'combine_south_China_srfdata.nc';
outDirFile = [outDir, '\', outFile];
outid = netcdf.create(outFile,'64BIT_OFFSET');

% define dimensions
londimID    = netcdf.defDim(outid,'lsmlon',280);
latdimID    = netcdf.defDim(outid,'lsmlat',80);
nglcecdimID = netcdf.defDim(outid,'nglcec',10);
nglcecp1dimID = netcdf.defDim(outid,'nglcecp1',11);
numurbldimID  = netcdf.defDim(outid,'numurbl',3);
nlevurbdimID  = netcdf.defDim(outid,'nlevurb',5);
numraddimID   = netcdf.defDim(outid,'numrad',2);
nchardimID    = netcdf.defDim(outid,'nchar',256);
nlevsoidimID  = netcdf.defDim(outid,'nlevsoi',10);
timedimID     = netcdf.defDim(outid,'time',12);
lsmpftdimID   = netcdf.defDim(outid,'lsmpft',17);
natpftdimID   = netcdf.defDim(outid,'natpft',15);
cftdimID      = netcdf.defDim(outid,'cft',2);

defotdimID    = netcdf.defDim(outid,'defot',1);

% define variables
mxsoil_color_id = netcdf.defVar(outid,'mxsoil_color','NC_INT',defotdimID);
SOIL_COLOR_id   = netcdf.defVar(outid,'SOIL_COLOR','NC_INT',[londimID, latdimID]);
PCT_SAND_id     = netcdf.defVar(outid,'PCT_SAND','NC_DOUBLE',[londimID, latdimID, nlevsoidimID]);
PCT_CLAY_id     = netcdf.defVar(outid,'PCT_CLAY','NC_DOUBLE',[londimID, latdimID, nlevsoidimID]);
ORGANIC_id      = netcdf.defVar(outid,'ORGANIC','NC_DOUBLE',[londimID, latdimID, nlevsoidimID]);
FMAX_id         = netcdf.defVar(outid,'FMAX','NC_DOUBLE',[londimID, latdimID]);
natpft_id       = netcdf.defVar(outid,'natpft','NC_INT',natpftdimID);
cft_id          = netcdf.defVar(outid,'cft','NC_INT',cftdimID);
LANDFRAC_PFT_id = netcdf.defVar(outid,'LANDFRAC_PFT','NC_DOUBLE',[londimID, latdimID]);
PFTDATA_MASK_id = netcdf.defVar(outid,'PFTDATA_MASK','NC_INT',[londimID, latdimID]);
PCT_NATVEG_id   = netcdf.defVar(outid,'PCT_NATVEG','NC_DOUBLE',[londimID, latdimID]);
PCT_CROP_id     = netcdf.defVar(outid,'PCT_CROP','NC_DOUBLE',[londimID, latdimID]);
PCT_NAT_PFT_id  = netcdf.defVar(outid,'PCT_NAT_PFT','NC_DOUBLE',[londimID, latdimID,natpftdimID]);
PCT_CFT_id      = netcdf.defVar(outid,'PCT_CFT','NC_DOUBLE',[londimID, latdimID, cftdimID]);
MONTHLY_LAI_id  = netcdf.defVar(outid,'MONTHLY_LAI','NC_DOUBLE',[londimID, latdimID, lsmpftdimID, timedimID]);
MONTHLY_SAI_id  = netcdf.defVar(outid,'MONTHLY_SAI','NC_DOUBLE',[londimID, latdimID, lsmpftdimID, timedimID]);
MONTHLY_HEIGHT_TOP_id = netcdf.defVar(outid,'MONTHLY_HEIGHT_TOP','NC_DOUBLE',[londimID, latdimID, lsmpftdimID, timedimID]);
MONTHLY_HEIGHT_BOT_id = netcdf.defVar(outid,'MONTHLY_HEIGHT_BOT','NC_DOUBLE',[londimID, latdimID, lsmpftdimID, timedimID]);

time_id         = netcdf.defVar(outid,'time','NC_INT',timedimID);
AREA_id         = netcdf.defVar(outid,'AREA','NC_DOUBLE',[londimID, latdimID]);
LONGXY_id       = netcdf.defVar(outid,'LONGXY','NC_DOUBLE',[londimID, latdimID]);
LATIXY_id       = netcdf.defVar(outid,'LATIXY','NC_DOUBLE',[londimID, latdimID]);
EF1_BTR_id      = netcdf.defVar(outid,'EF1_BTR','NC_DOUBLE',[londimID, latdimID]);
EF1_FET_id      = netcdf.defVar(outid,'EF1_FET','NC_DOUBLE',[londimID, latdimID]);
EF1_FDT_id      = netcdf.defVar(outid,'EF1_FDT','NC_DOUBLE',[londimID, latdimID]);
EF1_SHR_id      = netcdf.defVar(outid,'EF1_SHR','NC_DOUBLE',[londimID, latdimID]);
EF1_GRS_id      = netcdf.defVar(outid,'EF1_GRS','NC_DOUBLE',[londimID, latdimID]);
EF1_CRP_id      = netcdf.defVar(outid,'EF1_CRP','NC_DOUBLE',[londimID, latdimID]);
CANYON_HWR_id   = netcdf.defVar(outid,'CANYON_HWR','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
EM_IMPROAD_id   = netcdf.defVar(outid,'EM_IMPROAD','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
EM_PERROAD_id   = netcdf.defVar(outid,'EM_PERROAD','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
EM_ROOF_id      = netcdf.defVar(outid,'EM_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
EM_WALL_id      = netcdf.defVar(outid,'EM_WALL','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
HT_ROOF_id      = netcdf.defVar(outid,'HT_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
THICK_ROOF_id   = netcdf.defVar(outid,'THICK_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
THICK_WALL_id   = netcdf.defVar(outid,'THICK_WALL','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
T_BUILDING_MIN_id  = netcdf.defVar(outid,'T_BUILDING_MIN','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
WIND_HGT_CANYON_id = netcdf.defVar(outid,'WIND_HGT_CANYON','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
WTLUNIT_ROOF_id    = netcdf.defVar(outid,'WTLUNIT_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
WTROAD_PERV_id     = netcdf.defVar(outid,'WTROAD_PERV','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
ALB_IMPROAD_DIR_id = netcdf.defVar(outid,'ALB_IMPROAD_DIR','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_IMPROAD_DIF_id = netcdf.defVar(outid,'ALB_IMPROAD_DIF','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_PERROAD_DIR_id = netcdf.defVar(outid,'ALB_PERROAD_DIR','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_PERROAD_DIF_id = netcdf.defVar(outid,'ALB_PERROAD_DIF','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_ROOF_DIR_id    = netcdf.defVar(outid,'ALB_ROOF_DIR','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_ROOF_DIF_id    = netcdf.defVar(outid,'ALB_ROOF_DIF','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_WALL_DIR_id    = netcdf.defVar(outid,'ALB_WALL_DIR','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
ALB_WALL_DIF_id    = netcdf.defVar(outid,'ALB_WALL_DIF','NC_DOUBLE',[londimID, latdimID, numurbldimID, numraddimID]);
TK_ROOF_id      = netcdf.defVar(outid,'TK_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
TK_WALL_id      = netcdf.defVar(outid,'TK_WALL','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
TK_IMPROAD_id   = netcdf.defVar(outid,'TK_IMPROAD','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
CV_ROOF_id      = netcdf.defVar(outid,'CV_ROOF','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
CV_WALL_id      = netcdf.defVar(outid,'CV_WALL','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
CV_IMPROAD_id   = netcdf.defVar(outid,'CV_IMPROAD','NC_DOUBLE',[londimID, latdimID, numurbldimID, nlevurbdimID]);
NLEV_IMPROAD_id = netcdf.defVar(outid,'NLEV_IMPROAD','NC_INT',[londimID, latdimID, numurbldimID]);
peatf_id        = netcdf.defVar(outid,'peatf','NC_DOUBLE',[londimID, latdimID]);
zbedrock_id     = netcdf.defVar(outid,'zbedrock','NC_DOUBLE',[londimID, latdimID]);
abm_id          = netcdf.defVar(outid,'abm','NC_INT',[londimID, latdimID]);
gdp_id          = netcdf.defVar(outid,'gdp','NC_DOUBLE',[londimID, latdimID]);
SLOPE_id        = netcdf.defVar(outid,'SLOPE','NC_DOUBLE',[londimID, latdimID]);
STD_ELEV_id     = netcdf.defVar(outid,'STD_ELEV','NC_DOUBLE',[londimID, latdimID]);
LAKEDEPTH_id    = netcdf.defVar(outid,'LAKEDEPTH','NC_DOUBLE',[londimID, latdimID]);
PCT_WETLAND_id  = netcdf.defVar(outid,'PCT_WETLAND','NC_DOUBLE',[londimID, latdimID]);
PCT_LAKE_id     = netcdf.defVar(outid,'PCT_LAKE','NC_DOUBLE',[londimID, latdimID]);
PCT_GLACIER_id  = netcdf.defVar(outid,'PCT_GLACIER','NC_DOUBLE',[londimID, latdimID]);
GLACIER_REGION_id = netcdf.defVar(outid,'GLACIER_REGION','NC_INT',[londimID, latdimID]);
GLC_MEC_id      = netcdf.defVar(outid,'GLC_MEC','NC_DOUBLE',nglcecp1dimID);
PCT_GLC_MEC_id  = netcdf.defVar(outid,'PCT_GLC_MEC','NC_DOUBLE',[londimID, latdimID, nglcecdimID]);
TOPO_GLC_MEC_id = netcdf.defVar(outid,'TOPO_GLC_MEC','NC_DOUBLE',[londimID, latdimID, nglcecdimID]);
PCT_URBAN_id    = netcdf.defVar(outid,'PCT_URBAN','NC_DOUBLE',[londimID, latdimID, numurbldimID]);
URBAN_REGION_ID_id = netcdf.defVar(outid,'URBAN_REGION_ID','NC_INT',[londimID, latdimID]);
CONST_HARVEST_VH1_id = netcdf.defVar(outid,'CONST_HARVEST_VH1','NC_DOUBLE',[londimID, latdimID]);
CONST_HARVEST_VH2_id = netcdf.defVar(outid,'CONST_HARVEST_VH2','NC_DOUBLE',[londimID, latdimID]);
CONST_HARVEST_SH1_id = netcdf.defVar(outid,'CONST_HARVEST_SH1','NC_DOUBLE',[londimID, latdimID]);
CONST_HARVEST_SH2_id = netcdf.defVar(outid,'CONST_HARVEST_SH2','NC_DOUBLE',[londimID, latdimID]);
CONST_HARVEST_SH3_id = netcdf.defVar(outid,'CONST_HARVEST_SH3','NC_DOUBLE',[londimID, latdimID]);
CONST_GRAZING_id     = netcdf.defVar(outid,'CONST_GRAZING','NC_DOUBLE',[londimID, latdimID]);
CONST_FERTNITRO_CFT_id = netcdf.defVar(outid,'CONST_FERTNITRO_CFT','NC_DOUBLE',[londimID, latdimID, cftdimID]);
UNREPRESENTED_PFT_LULCC_id = netcdf.defVar(outid,'UNREPRESENTED_PFT_LULCC','NC_DOUBLE',[londimID, latdimID, natpftdimID]);
UNREPRESENTED_CFT_LULCC_id = netcdf.defVar(outid,'UNREPRESENTED_CFT_LULCC','NC_DOUBLE',[londimID, latdimID, cftdimID]);

netcdf.endDef(outid);

% read nc files and merge variables
mxsoil_color_b21 = ncread(inDirFile_b21, 'mxsoil_color');
mxsoil_color_b22 = ncread(inDirFile_b22, 'mxsoil_color');
mxsoil_color_cmb = max(mxsoil_color_b21, mxsoil_color_b22);

SOIL_COLOR_b21 = ncread(inDirFile_b21, 'SOIL_COLOR');
SOIL_COLOR_b22 = ncread(inDirFile_b22, 'SOIL_COLOR');
SOIL_COLOR_cmb = cat(1, SOIL_COLOR_b21, SOIL_COLOR_b22);

PCT_SAND_b21 = ncread(inDirFile_b21, 'PCT_SAND');
PCT_SAND_b22 = ncread(inDirFile_b22, 'PCT_SAND');
PCT_SAND_cmb = cat(1, PCT_SAND_b21, PCT_SAND_b22);
 
PCT_CLAY_b21 = ncread(inDirFile_b21, 'PCT_CLAY');
PCT_CLAY_b22 = ncread(inDirFile_b22, 'PCT_CLAY');
PCT_CLAY_cmb = cat(1, PCT_CLAY_b21, PCT_CLAY_b22);

ORGANIC_b21 = ncread(inDirFile_b21, 'ORGANIC');
ORGANIC_b22 = ncread(inDirFile_b22, 'ORGANIC');
ORGANIC_cmb = cat(1,ORGANIC_b21, ORGANIC_b22);

FMAX_b21    = ncread(inDirFile_b21, 'FMAX');
FMAX_b22    = ncread(inDirFile_b22, 'FMAX');
FMAX_cmb    = cat(1, FMAX_b21, FMAX_b22);

natpft_b21  = ncread(inDirFile_b21, 'natpft');
natpft_b22  = ncread(inDirFile_b22, 'natpft');
natpft_cmb  = natpft_b21;  % size: 15x1

cft_b21     = ncread(inDirFile_b21, 'cft');
cft_b22     = ncread(inDirFile_b22, 'cft');
cft_cmb     = cft_b21;     % size: 2x1
 
LANDFRAC_PFT_b21 = ncread(inDirFile_b21, 'LANDFRAC_PFT');
LANDFRAC_PFT_b22 = ncread(inDirFile_b22, 'LANDFRAC_PFT');
LANDFRAC_PFT_cmb = cat(1, LANDFRAC_PFT_b21, LANDFRAC_PFT_b22);

PFTDATA_MASK_b21 = ncread(inDirFile_b21, 'PFTDATA_MASK');
PFTDATA_MASK_b22 = ncread(inDirFile_b22, 'PFTDATA_MASK');
PFTDATA_MASK_cmb = cat(1, PFTDATA_MASK_b21, PFTDATA_MASK_b22);
 
PCT_NATVEG_b21  = ncread(inDirFile_b21, 'PCT_NATVEG');
PCT_NATVEG_b22  = ncread(inDirFile_b22, 'PCT_NATVEG');
PCT_NATVEG_cmb  = cat(1, PCT_NATVEG_b21, PCT_NATVEG_b22); 

PCT_CROP_b21     = ncread(inDirFile_b21, 'PCT_CROP');
PCT_CROP_b22     = ncread(inDirFile_b22, 'PCT_CROP');
PCT_CROP_cmb    = cat(1, PCT_CROP_b21, PCT_CROP_b22);
  
PCT_NAT_PFT_b21 = ncread(inDirFile_b21, 'PCT_NAT_PFT');
PCT_NAT_PFT_b22 = ncread(inDirFile_b22, 'PCT_NAT_PFT');
PCT_NAT_PFT_cmb = cat(1, PCT_NAT_PFT_b21, PCT_NAT_PFT_b22);
 
PCT_CFT_b21     = ncread(inDirFile_b21, 'PCT_CFT');
PCT_CFT_b22     = ncread(inDirFile_b22, 'PCT_CFT');
PCT_CFT_cmb     = cat(1, PCT_CFT_b21, PCT_CFT_b22);

MONTHLY_LAI_b21 = ncread(inDirFile_b21, 'MONTHLY_LAI');
MONTHLY_LAI_b22 = ncread(inDirFile_b22, 'MONTHLY_LAI');
MONTHLY_LAI_cmb = cat(1, MONTHLY_LAI_b21, MONTHLY_LAI_b22);

MONTHLY_SAI_b21 = ncread(inDirFile_b21, 'MONTHLY_SAI');
MONTHLY_SAI_b22 = ncread(inDirFile_b22, 'MONTHLY_SAI');
MONTHLY_SAI_cmb = cat(1, MONTHLY_SAI_b21, MONTHLY_SAI_b22);

MONTHLY_HEIGHT_TOP_b21 = ncread(inDirFile_b21, 'MONTHLY_HEIGHT_TOP');
MONTHLY_HEIGHT_TOP_b22 = ncread(inDirFile_b22, 'MONTHLY_HEIGHT_TOP');
MONTHLY_HEIGHT_TOP_cmb = cat(1, MONTHLY_HEIGHT_TOP_b21, MONTHLY_HEIGHT_TOP_b22);
 
MONTHLY_HEIGHT_BOT_b21 = ncread(inDirFile_b21, 'MONTHLY_HEIGHT_BOT');
MONTHLY_HEIGHT_BOT_b22 = ncread(inDirFile_b22, 'MONTHLY_HEIGHT_BOT');
MONTHLY_HEIGHT_BOT_cmb = cat(1, MONTHLY_HEIGHT_BOT_b21, MONTHLY_HEIGHT_BOT_b22);

time_b21    = ncread(inDirFile_b21, 'time');
time_b22    = ncread(inDirFile_b22, 'time');
time_cmb    = time_b21;   % size 12x1
 
AREA_b21    = ncread(inDirFile_b21, 'AREA');
AREA_b22    = ncread(inDirFile_b22, 'AREA');
AREA_cmb    = cat(1, AREA_b21, AREA_b22);
 
LONGXY_b21  = ncread(inDirFile_b21, 'LONGXY');
LONGXY_b22  = ncread(inDirFile_b22, 'LONGXY');
LONGXY_cmb  = cat(1, LONGXY_b21, LONGXY_b22);

LATIXY_b21 = ncread(inDirFile_b21, 'LATIXY');
LATIXY_b22 = ncread(inDirFile_b22, 'LATIXY');
LATIXY_cmb = cat(1, LATIXY_b21, LATIXY_b22);
 
EF1_BTR_b21 = ncread(inDirFile_b21, 'EF1_BTR');
EF1_BTR_b22 = ncread(inDirFile_b22, 'EF1_BTR');
EF1_BTR_cmb = cat(1, EF1_BTR_b21, EF1_BTR_b22);

EF1_FET_b21 = ncread(inDirFile_b21, 'EF1_FET');
EF1_FET_b22 = ncread(inDirFile_b22, 'EF1_FET');
EF1_FET_cmb = cat(1, EF1_FET_b21, EF1_FET_b22);

EF1_FDT_b21 = ncread(inDirFile_b21, 'EF1_FDT');
EF1_FDT_b22 = ncread(inDirFile_b22, 'EF1_FDT');
EF1_FDT_cmb = cat(1, EF1_FDT_b21, EF1_FDT_b22);

EF1_SHR_b21 = ncread(inDirFile_b21, 'EF1_SHR');
EF1_SHR_b22 = ncread(inDirFile_b22, 'EF1_SHR');
EF1_SHR_cmb = cat(1, EF1_SHR_b21, EF1_SHR_b22);
 
EF1_GRS_b21 = ncread(inDirFile_b21, 'EF1_GRS');
EF1_GRS_b22 = ncread(inDirFile_b22, 'EF1_GRS');
EF1_GRS_cmb = cat(1, EF1_GRS_b21, EF1_GRS_b22);
 
EF1_CRP_b21 = ncread(inDirFile_b21, 'EF1_CRP');
EF1_CRP_b22 = ncread(inDirFile_b22, 'EF1_CRP');
EF1_CRP_cmb = cat(1, EF1_CRP_b21, EF1_CRP_b22);

CANYON_HWR_b21 = ncread(inDirFile_b21, 'CANYON_HWR');
CANYON_HWR_b22 = ncread(inDirFile_b22, 'CANYON_HWR');
CANYON_HWR_cmb = cat(1, CANYON_HWR_b21, CANYON_HWR_b22);
 
EM_IMPROAD_b21 = ncread(inDirFile_b21, 'EM_IMPROAD');
EM_IMPROAD_b22 = ncread(inDirFile_b22, 'EM_IMPROAD');
EM_IMPROAD_cmb = cat(1, EM_IMPROAD_b21, EM_IMPROAD_b22);

EM_PERROAD_b21 = ncread(inDirFile_b21, 'EM_PERROAD');
EM_PERROAD_b22 = ncread(inDirFile_b22, 'EM_PERROAD');
EM_PERROAD_cmb = cat(1, EM_PERROAD_b21, EM_PERROAD_b22);
 
EM_ROOF_b21 = ncread(inDirFile_b21, 'EM_ROOF');
EM_ROOF_b22 = ncread(inDirFile_b22, 'EM_ROOF');
EM_ROOF_cmb = cat(1, EM_ROOF_b21, EM_ROOF_b22);

EM_WALL_b21 = ncread(inDirFile_b21, 'EM_WALL');
EM_WALL_b22 = ncread(inDirFile_b22, 'EM_WALL');
EM_WALL_cmb = cat(1, EM_WALL_b21, EM_WALL_b22);
 
HT_ROOF_b21 = ncread(inDirFile_b21, 'HT_ROOF');
HT_ROOF_b22 = ncread(inDirFile_b22, 'HT_ROOF');
HT_ROOF_cmb = cat(1, HT_ROOF_b21, HT_ROOF_b22);
 
THICK_ROOF_b21 = ncread(inDirFile_b21, 'THICK_ROOF');
THICK_ROOF_b22 = ncread(inDirFile_b22, 'THICK_ROOF');
THICK_ROOF_cmb = cat(1, THICK_ROOF_b21, THICK_ROOF_b22);

THICK_WALL_b21 = ncread(inDirFile_b21, 'THICK_WALL');
THICK_WALL_b22 = ncread(inDirFile_b22, 'THICK_WALL');
THICK_WALL_cmb = cat(1, THICK_WALL_b21, THICK_WALL_b22);
 
T_BUILDING_MIN_b21 = ncread(inDirFile_b21, 'T_BUILDING_MIN');
T_BUILDING_MIN_b22 = ncread(inDirFile_b22, 'T_BUILDING_MIN');
T_BUILDING_MIN_cmb = cat(1, T_BUILDING_MIN_b21, T_BUILDING_MIN_b22);

WIND_HGT_CANYON_b21 = ncread(inDirFile_b21, 'WIND_HGT_CANYON');
WIND_HGT_CANYON_b22 = ncread(inDirFile_b22, 'WIND_HGT_CANYON');
WIND_HGT_CANYON_cmb = cat(1, WIND_HGT_CANYON_b21, WIND_HGT_CANYON_b22);
 
WTLUNIT_ROOF_b21 = ncread(inDirFile_b21, 'WTLUNIT_ROOF');
WTLUNIT_ROOF_b22 = ncread(inDirFile_b22, 'WTLUNIT_ROOF');
WTLUNIT_ROOF_cmb = cat(1, WTLUNIT_ROOF_b21, WTLUNIT_ROOF_b22);

WTROAD_PERV_b21 = ncread(inDirFile_b21, 'WTROAD_PERV');
WTROAD_PERV_b22 = ncread(inDirFile_b22, 'WTROAD_PERV');
WTROAD_PERV_cmb = cat(1, WTROAD_PERV_b21, WTROAD_PERV_b22);
 
ALB_IMPROAD_DIR_b21 = ncread(inDirFile_b21, 'ALB_IMPROAD_DIR');
ALB_IMPROAD_DIR_b22 = ncread(inDirFile_b22, 'ALB_IMPROAD_DIR');
ALB_IMPROAD_DIR_cmb = cat(1, ALB_IMPROAD_DIR_b21, ALB_IMPROAD_DIR_b22);

ALB_IMPROAD_DIF_b21 = ncread(inDirFile_b21, 'ALB_IMPROAD_DIF');
ALB_IMPROAD_DIF_b22 = ncread(inDirFile_b22, 'ALB_IMPROAD_DIF');
ALB_IMPROAD_DIF_cmb = cat(1, ALB_IMPROAD_DIF_b21, ALB_IMPROAD_DIF_b22);
 
ALB_PERROAD_DIR_b21 = ncread(inDirFile_b21, 'ALB_PERROAD_DIR');
ALB_PERROAD_DIR_b22 = ncread(inDirFile_b22, 'ALB_PERROAD_DIR');
ALB_PERROAD_DIR_cmb = cat(1, ALB_PERROAD_DIR_b21, ALB_PERROAD_DIR_b22);
 
ALB_PERROAD_DIF_b21 = ncread(inDirFile_b21, 'ALB_PERROAD_DIF');
ALB_PERROAD_DIF_b22 = ncread(inDirFile_b22, 'ALB_PERROAD_DIF');
ALB_PERROAD_DIF_cmb = cat(1, ALB_PERROAD_DIF_b21, ALB_PERROAD_DIF_b22);

ALB_ROOF_DIR_b21 = ncread(inDirFile_b21, 'ALB_ROOF_DIR');
ALB_ROOF_DIR_b22 = ncread(inDirFile_b22, 'ALB_ROOF_DIR');
ALB_ROOF_DIR_cmb = cat(1, ALB_ROOF_DIR_b21, ALB_ROOF_DIR_b22);
 
ALB_ROOF_DIF_b21 = ncread(inDirFile_b21, 'ALB_ROOF_DIF');
ALB_ROOF_DIF_b22 = ncread(inDirFile_b22, 'ALB_ROOF_DIF');
ALB_ROOF_DIF_cmb = cat(1, ALB_ROOF_DIF_b21, ALB_ROOF_DIF_b22);

ALB_WALL_DIR_b21 = ncread(inDirFile_b21, 'ALB_WALL_DIR');
ALB_WALL_DIR_b22 = ncread(inDirFile_b22, 'ALB_WALL_DIR');
ALB_WALL_DIR_cmb = cat(1, ALB_WALL_DIR_b21, ALB_WALL_DIR_b22);

ALB_WALL_DIF_b21 = ncread(inDirFile_b21, 'ALB_WALL_DIF');
ALB_WALL_DIF_b22 = ncread(inDirFile_b22, 'ALB_WALL_DIF');
ALB_WALL_DIF_cmb = cat(1, ALB_WALL_DIF_b21, ALB_WALL_DIF_b22);

TK_ROOF_b21 = ncread(inDirFile_b21, 'TK_ROOF');
TK_ROOF_b22 = ncread(inDirFile_b22, 'TK_ROOF');
TK_ROOF_cmb = cat(1, TK_ROOF_b21, TK_ROOF_b22);
 
TK_WALL_b21 = ncread(inDirFile_b21, 'TK_WALL');
TK_WALL_b22 = ncread(inDirFile_b22, 'TK_WALL');
TK_WALL_cmb = cat(1, TK_WALL_b21, TK_WALL_b22);

TK_IMPROAD_b21 = ncread(inDirFile_b21, 'TK_IMPROAD');
TK_IMPROAD_b22 = ncread(inDirFile_b22, 'TK_IMPROAD');
TK_IMPROAD_cmb = cat(1, TK_IMPROAD_b21, TK_IMPROAD_b22);
 
CV_ROOF_b21 = ncread(inDirFile_b21, 'CV_ROOF');
CV_ROOF_b22 = ncread(inDirFile_b22, 'CV_ROOF');
CV_ROOF_cmb = cat(1, CV_ROOF_b21, CV_ROOF_b22);

CV_WALL_b21 = ncread(inDirFile_b21, 'CV_WALL');
CV_WALL_b22 = ncread(inDirFile_b22, 'CV_WALL');
CV_WALL_cmb = cat(1, CV_WALL_b21, CV_WALL_b22);
 
CV_IMPROAD_b21 = ncread(inDirFile_b21, 'CV_IMPROAD');
CV_IMPROAD_b22 = ncread(inDirFile_b22, 'CV_IMPROAD');
CV_IMPROAD_cmb = cat(1, CV_IMPROAD_b21, CV_IMPROAD_b22);

NLEV_IMPROAD_b21 = ncread(inDirFile_b21, 'NLEV_IMPROAD');
NLEV_IMPROAD_b22 = ncread(inDirFile_b22, 'NLEV_IMPROAD');
NLEV_IMPROAD_cmb = cat(1, NLEV_IMPROAD_b21, NLEV_IMPROAD_b22);

peatf_b21 = ncread(inDirFile_b21, 'peatf');
peatf_b22 = ncread(inDirFile_b22, 'peatf');
peatf_cmb = cat(1, peatf_b21, peatf_b22);

zbedrock_b21 = ncread(inDirFile_b21, 'zbedrock');
zbedrock_b22 = ncread(inDirFile_b22, 'zbedrock');
zbedrock_cmb = cat(1, zbedrock_b21, zbedrock_b22);

abm_b21 = ncread(inDirFile_b21, 'abm');
abm_b22 = ncread(inDirFile_b22, 'abm');
abm_cmb = cat(1, abm_b21, abm_b22);

gdp_b21 = ncread(inDirFile_b21, 'gdp');
gdp_b22 = ncread(inDirFile_b22, 'gdp');
gdp_cmb = cat(1, gdp_b21, gdp_b22);

SLOPE_b21 = ncread(inDirFile_b21, 'SLOPE');
SLOPE_b22 = ncread(inDirFile_b22, 'SLOPE');
SLOPE_cmb = cat(1, SLOPE_b21, SLOPE_b22);
 
STD_ELEV_b21 = ncread(inDirFile_b21, 'STD_ELEV');
STD_ELEV_b22 = ncread(inDirFile_b22, 'STD_ELEV');
STD_ELEV_cmb = cat(1, STD_ELEV_b21, STD_ELEV_b22);

LAKEDEPTH_b21 = ncread(inDirFile_b21, 'LAKEDEPTH');
LAKEDEPTH_b22 = ncread(inDirFile_b22, 'LAKEDEPTH');
LAKEDEPTH_cmb = cat(1, LAKEDEPTH_b21, LAKEDEPTH_b22);
 
PCT_WETLAND_b21 = ncread(inDirFile_b21, 'PCT_WETLAND');
PCT_WETLAND_b22 = ncread(inDirFile_b22, 'PCT_WETLAND');
PCT_WETLAND_cmb = cat(1, PCT_WETLAND_b21, PCT_WETLAND_b22);
 
PCT_LAKE_b21 = ncread(inDirFile_b21, 'PCT_LAKE');
PCT_LAKE_b22 = ncread(inDirFile_b22, 'PCT_LAKE');
PCT_LAKE_cmb = cat(1, PCT_LAKE_b21, PCT_LAKE_b22);
 
PCT_GLACIER_b21 = ncread(inDirFile_b21, 'PCT_GLACIER');
PCT_GLACIER_b22 = ncread(inDirFile_b22, 'PCT_GLACIER');
PCT_GLACIER_cmb = cat(1, PCT_GLACIER_b21, PCT_GLACIER_b22);
 
GLACIER_REGION_b21 = ncread(inDirFile_b21, 'GLACIER_REGION');
GLACIER_REGION_b22 = ncread(inDirFile_b22, 'GLACIER_REGION');
GLACIER_REGION_cmb = cat(1, GLACIER_REGION_b21, GLACIER_REGION_b22);
 
GLC_MEC_b21 = ncread(inDirFile_b21, 'GLC_MEC');
GLC_MEC_b22 = ncread(inDirFile_b22, 'GLC_MEC');
GLC_MEC_cmb = GLC_MEC_b21;   % size 11x1
 
PCT_GLC_MEC_b21 = ncread(inDirFile_b21, 'PCT_GLC_MEC');
PCT_GLC_MEC_b22 = ncread(inDirFile_b22, 'PCT_GLC_MEC');
PCT_GLC_MEC_cmb = cat(1, PCT_GLC_MEC_b21, PCT_GLC_MEC_b22);
 
TOPO_GLC_MEC_b21 = ncread(inDirFile_b21, 'TOPO_GLC_MEC');
TOPO_GLC_MEC_b22 = ncread(inDirFile_b22, 'TOPO_GLC_MEC');
TOPO_GLC_MEC_cmb = cat(1, TOPO_GLC_MEC_b21, TOPO_GLC_MEC_b22);
 
PCT_URBAN_b21 = ncread(inDirFile_b21, 'PCT_URBAN');
PCT_URBAN_b22 = ncread(inDirFile_b22, 'PCT_URBAN');
PCT_URBAN_cmb = cat(1, PCT_URBAN_b21, PCT_URBAN_b22);

URBAN_REGION_ID_b21 = ncread(inDirFile_b21, 'URBAN_REGION_ID');
URBAN_REGION_ID_b22 = ncread(inDirFile_b22, 'URBAN_REGION_ID');
URBAN_REGION_ID_cmb = cat(1, URBAN_REGION_ID_b21, URBAN_REGION_ID_b22);
 
CONST_HARVEST_VH1_b21 = ncread(inDirFile_b21, 'CONST_HARVEST_VH1');
CONST_HARVEST_VH1_b22 = ncread(inDirFile_b22, 'CONST_HARVEST_VH1');
CONST_HARVEST_VH1_cmb = cat(1, CONST_HARVEST_VH1_b21, CONST_HARVEST_VH1_b22);
 
CONST_HARVEST_VH2_b21 = ncread(inDirFile_b21, 'CONST_HARVEST_VH2');
CONST_HARVEST_VH2_b22 = ncread(inDirFile_b22, 'CONST_HARVEST_VH2');
CONST_HARVEST_VH2_cmb = cat(1, CONST_HARVEST_VH2_b21, CONST_HARVEST_VH2_b22);
 
CONST_HARVEST_SH1_b21 = ncread(inDirFile_b21, 'CONST_HARVEST_SH1');
CONST_HARVEST_SH1_b22 = ncread(inDirFile_b22, 'CONST_HARVEST_SH1');
CONST_HARVEST_SH1_cmb = cat(1, CONST_HARVEST_SH1_b21, CONST_HARVEST_SH1_b22);
 
CONST_HARVEST_SH2_b21 = ncread(inDirFile_b21, 'CONST_HARVEST_SH2');
CONST_HARVEST_SH2_b22 = ncread(inDirFile_b22, 'CONST_HARVEST_SH2');
CONST_HARVEST_SH2_cmb = cat(1, CONST_HARVEST_SH2_b21, CONST_HARVEST_SH2_b22);
 
CONST_HARVEST_SH3_b21 = ncread(inDirFile_b21, 'CONST_HARVEST_SH3');
CONST_HARVEST_SH3_b22 = ncread(inDirFile_b22, 'CONST_HARVEST_SH3');
CONST_HARVEST_SH3_cmb = cat(1, CONST_HARVEST_SH3_b21, CONST_HARVEST_SH3_b22);
 
CONST_GRAZING_b21 = ncread(inDirFile_b21, 'CONST_GRAZING');
CONST_GRAZING_b22 = ncread(inDirFile_b22, 'CONST_GRAZING');
CONST_GRAZING_cmb = cat(1, CONST_GRAZING_b21, CONST_GRAZING_b22);
 
CONST_FERTNITRO_CFT_b21 = ncread(inDirFile_b21, 'CONST_FERTNITRO_CFT');
CONST_FERTNITRO_CFT_b22 = ncread(inDirFile_b22, 'CONST_FERTNITRO_CFT');
CONST_FERTNITRO_CFT_cmb = cat(1, CONST_FERTNITRO_CFT_b21, CONST_FERTNITRO_CFT_b22);
 
UNREPRESENTED_PFT_LULCC_b21 = ncread(inDirFile_b21, 'UNREPRESENTED_PFT_LULCC');
UNREPRESENTED_PFT_LULCC_b22 = ncread(inDirFile_b22, 'UNREPRESENTED_PFT_LULCC');
UNREPRESENTED_PFT_LULCC_cmb = cat(1, UNREPRESENTED_PFT_LULCC_b21, UNREPRESENTED_PFT_LULCC_b22);
 
UNREPRESENTED_CFT_LULCC_b21 = ncread(inDirFile_b21, 'UNREPRESENTED_CFT_LULCC');
UNREPRESENTED_CFT_LULCC_b22 = ncread(inDirFile_b22, 'UNREPRESENTED_CFT_LULCC');
UNREPRESENTED_CFT_LULCC_cmb = cat(1, UNREPRESENTED_CFT_LULCC_b21, UNREPRESENTED_CFT_LULCC_b22);
 
% put variables into nc
netcdf.putVar(outid, mxsoil_color_id, mxsoil_color_cmb);
netcdf.putVar(outid, SOIL_COLOR_id, SOIL_COLOR_cmb);
netcdf.putVar(outid, PCT_SAND_id, PCT_SAND_cmb);
netcdf.putVar(outid, PCT_CLAY_id, PCT_CLAY_cmb);
netcdf.putVar(outid, ORGANIC_id, ORGANIC_cmb);
netcdf.putVar(outid, FMAX_id, FMAX_cmb);
netcdf.putVar(outid, natpft_id, natpft_cmb);
netcdf.putVar(outid, cft_id, cft_cmb);
netcdf.putVar(outid, LANDFRAC_PFT_id, LANDFRAC_PFT_cmb);
netcdf.putVar(outid, PFTDATA_MASK_id, PFTDATA_MASK_cmb);
netcdf.putVar(outid, PCT_NATVEG_id, PCT_NATVEG_cmb);
netcdf.putVar(outid, PCT_CROP_id, PCT_CROP_cmb);
netcdf.putVar(outid, PCT_NAT_PFT_id, PCT_NAT_PFT_cmb);
netcdf.putVar(outid, PCT_CFT_id, PCT_CFT_cmb);
netcdf.putVar(outid, MONTHLY_LAI_id, MONTHLY_LAI_cmb);
netcdf.putVar(outid, MONTHLY_SAI_id, MONTHLY_SAI_cmb);
netcdf.putVar(outid, MONTHLY_HEIGHT_TOP_id, MONTHLY_HEIGHT_TOP_cmb);
netcdf.putVar(outid, MONTHLY_HEIGHT_BOT_id, MONTHLY_HEIGHT_BOT_cmb);
netcdf.putVar(outid, time_id, time_cmb);
netcdf.putVar(outid, AREA_id, AREA_cmb);
netcdf.putVar(outid, LONGXY_id, LONGXY_cmb);
netcdf.putVar(outid, LATIXY_id, LATIXY_cmb);
netcdf.putVar(outid, EF1_BTR_id, EF1_BTR_cmb);
netcdf.putVar(outid, EF1_FET_id, EF1_FET_cmb);
netcdf.putVar(outid, EF1_FDT_id, EF1_FDT_cmb);
netcdf.putVar(outid, EF1_SHR_id, EF1_SHR_cmb);
netcdf.putVar(outid, EF1_GRS_id, EF1_GRS_cmb);
netcdf.putVar(outid, EF1_CRP_id, EF1_CRP_cmb);
netcdf.putVar(outid, CANYON_HWR_id, CANYON_HWR_cmb);
netcdf.putVar(outid, EM_IMPROAD_id, EM_IMPROAD_cmb);
netcdf.putVar(outid, EM_PERROAD_id, EM_PERROAD_cmb);
netcdf.putVar(outid, EM_ROOF_id, EM_ROOF_cmb);
netcdf.putVar(outid, EM_WALL_id, EM_WALL_cmb);
netcdf.putVar(outid, HT_ROOF_id, HT_ROOF_cmb);
netcdf.putVar(outid, THICK_ROOF_id, THICK_ROOF_cmb);
netcdf.putVar(outid, THICK_WALL_id, THICK_WALL_cmb);
netcdf.putVar(outid, T_BUILDING_MIN_id, T_BUILDING_MIN_cmb);
netcdf.putVar(outid, WIND_HGT_CANYON_id, WIND_HGT_CANYON_cmb);
netcdf.putVar(outid, WTLUNIT_ROOF_id, WTLUNIT_ROOF_cmb);
netcdf.putVar(outid, WTROAD_PERV_id, WTROAD_PERV_cmb);
netcdf.putVar(outid, ALB_IMPROAD_DIR_id, ALB_IMPROAD_DIR_cmb);
netcdf.putVar(outid, ALB_IMPROAD_DIF_id, ALB_IMPROAD_DIF_cmb);
netcdf.putVar(outid, ALB_PERROAD_DIR_id, ALB_PERROAD_DIR_cmb);
netcdf.putVar(outid, ALB_PERROAD_DIF_id, ALB_PERROAD_DIF_cmb);
netcdf.putVar(outid, ALB_ROOF_DIR_id, ALB_ROOF_DIR_cmb);
netcdf.putVar(outid, ALB_ROOF_DIF_id, ALB_ROOF_DIF_cmb);
netcdf.putVar(outid, ALB_WALL_DIR_id, ALB_WALL_DIR_cmb);
netcdf.putVar(outid, ALB_WALL_DIF_id, ALB_WALL_DIF_cmb);
netcdf.putVar(outid, TK_ROOF_id, TK_ROOF_cmb);
netcdf.putVar(outid, TK_WALL_id, TK_WALL_cmb);
netcdf.putVar(outid, TK_IMPROAD_id, TK_IMPROAD_cmb);
netcdf.putVar(outid, CV_ROOF_id, CV_ROOF_cmb);
netcdf.putVar(outid, CV_WALL_id, CV_WALL_cmb);
netcdf.putVar(outid, CV_IMPROAD_id, CV_IMPROAD_cmb);
netcdf.putVar(outid, NLEV_IMPROAD_id, NLEV_IMPROAD_cmb);
netcdf.putVar(outid, peatf_id, peatf_cmb);
netcdf.putVar(outid, zbedrock_id, zbedrock_cmb);
netcdf.putVar(outid, abm_id, abm_cmb);
netcdf.putVar(outid, gdp_id, gdp_cmb);
netcdf.putVar(outid, SLOPE_id, SLOPE_cmb);
netcdf.putVar(outid, STD_ELEV_id, STD_ELEV_cmb);
netcdf.putVar(outid, LAKEDEPTH_id, LAKEDEPTH_cmb);
netcdf.putVar(outid, PCT_WETLAND_id, PCT_WETLAND_cmb);
netcdf.putVar(outid, PCT_LAKE_id, PCT_LAKE_cmb);
netcdf.putVar(outid, PCT_GLACIER_id, PCT_GLACIER_cmb);
netcdf.putVar(outid, GLACIER_REGION_id, GLACIER_REGION_cmb);
netcdf.putVar(outid, GLC_MEC_id, GLC_MEC_cmb);
netcdf.putVar(outid, PCT_GLC_MEC_id, PCT_GLC_MEC_cmb);
netcdf.putVar(outid, TOPO_GLC_MEC_id, TOPO_GLC_MEC_cmb);
netcdf.putVar(outid, PCT_URBAN_id, PCT_URBAN_cmb);
netcdf.putVar(outid, URBAN_REGION_ID_id, URBAN_REGION_ID_cmb);
netcdf.putVar(outid, CONST_HARVEST_VH1_id, CONST_HARVEST_VH1_cmb);
netcdf.putVar(outid, CONST_HARVEST_VH2_id, CONST_HARVEST_VH2_cmb);
netcdf.putVar(outid, CONST_HARVEST_SH1_id, CONST_HARVEST_SH1_cmb);
netcdf.putVar(outid, CONST_HARVEST_SH2_id, CONST_HARVEST_SH2_cmb);
netcdf.putVar(outid, CONST_HARVEST_SH3_id, CONST_HARVEST_SH3_cmb);
netcdf.putVar(outid, CONST_GRAZING_id, CONST_GRAZING_cmb);
netcdf.putVar(outid, CONST_FERTNITRO_CFT_id, CONST_FERTNITRO_CFT_cmb);
netcdf.putVar(outid, UNREPRESENTED_PFT_LULCC_id, UNREPRESENTED_PFT_LULCC_cmb);
netcdf.putVar(outid, UNREPRESENTED_CFT_LULCC_id, UNREPRESENTED_CFT_LULCC_cmb);

netcdf.reDef(outid);

netcdf.putAtt(outid, mxsoil_color_id, 'longname', 'maximum numbers of soil colors');
netcdf.putAtt(outid, mxsoil_color_id, 'units', 'unitless');

netcdf.putAtt(outid, SOIL_COLOR_id, 'longname', 'soil color');
netcdf.putAtt(outid, SOIL_COLOR_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_SAND_id, 'longname', 'percent sand');
netcdf.putAtt(outid, PCT_SAND_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_CLAY_id, 'longname', 'percent clay');
netcdf.putAtt(outid, PCT_CLAY_id, 'units', 'unitless');

netcdf.putAtt(outid, ORGANIC_id, 'longname', 'organic matter density at soil levels');
netcdf.putAtt(outid, ORGANIC_id, 'units', 'kg/m3 (assumed carbon content 0.58 gC per gOM)');

netcdf.putAtt(outid, FMAX_id, 'longname', 'maximum fractional saturated area');
netcdf.putAtt(outid, FMAX_id, 'units', 'unitless');

netcdf.putAtt(outid, natpft_id, 'longname', 'indices of natural PFTs');
netcdf.putAtt(outid, natpft_id, 'units', 'index');

netcdf.putAtt(outid, cft_id, 'longname', 'indices of CFTs');
netcdf.putAtt(outid, cft_id, 'units', 'index');

netcdf.putAtt(outid, LANDFRAC_PFT_id, 'longname', 'land fraction from pft dataset');
netcdf.putAtt(outid, LANDFRAC_PFT_id, 'units', 'unitless');

netcdf.putAtt(outid, PFTDATA_MASK_id, 'longname', 'land mask from pft dataset, indicative of real/fake points');
netcdf.putAtt(outid, PFTDATA_MASK_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_NATVEG_id, 'longname', 'total percent natural vegetation landunit');
netcdf.putAtt(outid, PCT_NATVEG_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_CROP_id, 'longname', 'total percent crop landunit');
netcdf.putAtt(outid, PCT_CROP_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_NAT_PFT_id, 'longname', 'percent plant functional type on the natural veg landunit (% of landunit)');
netcdf.putAtt(outid, PCT_NAT_PFT_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_CFT_id, 'longname', 'percent crop functional type on the crop landunit (% of landunit)');
netcdf.putAtt(outid, PCT_CFT_id, 'units', 'unitless');

netcdf.putAtt(outid, MONTHLY_LAI_id, 'longname', 'monthly leaf area index');
netcdf.putAtt(outid, MONTHLY_LAI_id, 'units', 'unitless');

netcdf.putAtt(outid, MONTHLY_SAI_id, 'longname', 'monthly stem area index'); 
netcdf.putAtt(outid, MONTHLY_SAI_id, 'units', 'unitless');

netcdf.putAtt(outid, MONTHLY_HEIGHT_TOP_id, 'longname', 'monthly height top');
netcdf.putAtt(outid, MONTHLY_HEIGHT_TOP_id, 'units', 'meters');

netcdf.putAtt(outid, MONTHLY_HEIGHT_BOT_id, 'longname', 'monthly height bottom');
netcdf.putAtt(outid, MONTHLY_HEIGHT_BOT_id, 'units', 'meters');

netcdf.putAtt(outid, time_id, 'longname', 'Calendar month');
netcdf.putAtt(outid, time_id, 'units', 'month');

netcdf.putAtt(outid, AREA_id, 'longname', 'area');
netcdf.putAtt(outid, AREA_id, 'units', 'km^2');

netcdf.putAtt(outid, LONGXY_id, 'longname', 'longitude');
netcdf.putAtt(outid, LONGXY_id, 'units', 'degrees east');

netcdf.putAtt(outid, LATIXY_id, 'longname', 'latitude');
netcdf.putAtt(outid, LATIXY_id, 'units', 'degrees north');

netcdf.putAtt(outid, EF1_BTR_id, 'longname', 'EF btr (isoprene)');
netcdf.putAtt(outid, EF1_BTR_id, 'units', 'unitless');

netcdf.putAtt(outid, EF1_FET_id, 'longname', 'EF fet (isoprene)');
netcdf.putAtt(outid, EF1_FET_id, 'units', 'unitless');

netcdf.putAtt(outid, EF1_FDT_id, 'longname', 'EF fdt (isoprene)');
netcdf.putAtt(outid, EF1_FDT_id, 'units', 'unitless');

netcdf.putAtt(outid, EF1_SHR_id, 'longname', 'EF shr (isoprene)');
netcdf.putAtt(outid, EF1_SHR_id, 'units', 'unitless');

netcdf.putAtt(outid, EF1_GRS_id, 'longname', 'EF grs (isoprene)');
netcdf.putAtt(outid, EF1_GRS_id, 'units', 'unitless');

netcdf.putAtt(outid, EF1_CRP_id, 'longname', 'EF crp (isoprene)');
netcdf.putAtt(outid, EF1_CRP_id, 'units', 'unitless');

netcdf.putAtt(outid, CANYON_HWR_id, 'longname', 'canyon height to width ratio');
netcdf.putAtt(outid, CANYON_HWR_id, 'units', 'unitless');

netcdf.putAtt(outid, EM_IMPROAD_id, 'longname', 'emissivity of impervious road');
netcdf.putAtt(outid, EM_IMPROAD_id, 'units', 'unitless');

netcdf.putAtt(outid, EM_PERROAD_id, 'longname', 'emissivity of pervious road');
netcdf.putAtt(outid, EM_PERROAD_id, 'units', 'unitless');

netcdf.putAtt(outid, EM_ROOF_id, 'longname', 'emissivity of roof');
netcdf.putAtt(outid, EM_ROOF_id, 'units', 'unitless');

netcdf.putAtt(outid, EM_WALL_id, 'longname', 'emissivity of wall');
netcdf.putAtt(outid, EM_WALL_id, 'units', 'unitless');

netcdf.putAtt(outid, HT_ROOF_id, 'longname', 'height of roof');
netcdf.putAtt(outid, HT_ROOF_id, 'units', 'meters');

netcdf.putAtt(outid, THICK_ROOF_id, 'longname', 'thickness of roof');
netcdf.putAtt(outid, THICK_ROOF_id, 'units', 'meters');

netcdf.putAtt(outid, THICK_WALL_id, 'longname', 'thickness of wall');
netcdf.putAtt(outid, THICK_WALL_id, 'units', 'meters');

netcdf.putAtt(outid, T_BUILDING_MIN_id, 'longname', 'minimum interior building temperature');
netcdf.putAtt(outid, T_BUILDING_MIN_id, 'units', 'K');

netcdf.putAtt(outid, WIND_HGT_CANYON_id, 'longname', 'height of wind in canyon');
netcdf.putAtt(outid, WIND_HGT_CANYON_id, 'units', 'meters');

netcdf.putAtt(outid, WTLUNIT_ROOF_id, 'longname', 'fraction of roof');
netcdf.putAtt(outid, WTLUNIT_ROOF_id, 'units', 'unitless');

netcdf.putAtt(outid, WTROAD_PERV_id, 'longname', 'fraction of pervious road');
netcdf.putAtt(outid, WTROAD_PERV_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_IMPROAD_DIR_id, 'longname', 'direct albedo of impervious road');
netcdf.putAtt(outid, ALB_IMPROAD_DIR_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_IMPROAD_DIF_id, 'longname', 'diffuse albedo of impervious road');
netcdf.putAtt(outid, ALB_IMPROAD_DIF_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_PERROAD_DIR_id, 'longname', 'direct albedo of pervious road');
netcdf.putAtt(outid, ALB_PERROAD_DIR_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_PERROAD_DIF_id, 'longname', 'diffuse albedo of pervious road');
netcdf.putAtt(outid, ALB_PERROAD_DIF_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_ROOF_DIR_id, 'longname', 'direct albedo of roof');
netcdf.putAtt(outid, ALB_ROOF_DIR_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_ROOF_DIF_id, 'longname', 'diffuse albedo of roof');
netcdf.putAtt(outid, ALB_ROOF_DIF_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_WALL_DIR_id, 'longname', 'direct albedo of wall');
netcdf.putAtt(outid, ALB_WALL_DIR_id, 'units', 'unitless');

netcdf.putAtt(outid, ALB_WALL_DIF_id, 'longname', 'diffuse albedo of wall');
netcdf.putAtt(outid, ALB_WALL_DIF_id, 'units', 'unitless');

netcdf.putAtt(outid, TK_ROOF_id, 'longname', 'thermal conductivity of roof');
netcdf.putAtt(outid, TK_ROOF_id, 'units', 'W/m*K');

netcdf.putAtt(outid, TK_WALL_id, 'longname', 'thermal conductivity of wall');
netcdf.putAtt(outid, TK_WALL_id, 'units', 'W/m*K');

netcdf.putAtt(outid, TK_IMPROAD_id, 'longname', 'thermal conductivity of impervious road');
netcdf.putAtt(outid, TK_IMPROAD_id, 'units', 'W/m*K');

netcdf.putAtt(outid, CV_ROOF_id, 'longname', 'volumetric heat capacity of roof');
netcdf.putAtt(outid, CV_ROOF_id, 'units', 'J/m^3*K');

netcdf.putAtt(outid, CV_WALL_id, 'longname', 'volumetric heat capacity of wall');
netcdf.putAtt(outid, CV_WALL_id, 'units', 'J/m^3*K');

netcdf.putAtt(outid, CV_IMPROAD_id, 'longname', 'volumetric heat capacity of impervious road');
netcdf.putAtt(outid, CV_IMPROAD_id, 'units', 'J/m^3*K');

netcdf.putAtt(outid, NLEV_IMPROAD_id, 'longname', 'number of impervious road layers');
netcdf.putAtt(outid, NLEV_IMPROAD_id, 'units', 'unitless');

netcdf.putAtt(outid, peatf_id, 'longname', 'peatland fraction');
netcdf.putAtt(outid, peatf_id, 'units', 'unitless');

netcdf.putAtt(outid, zbedrock_id, 'longname', 'soil depth');
netcdf.putAtt(outid, zbedrock_id, 'units', 'm');

netcdf.putAtt(outid, abm_id, 'longname', 'agricultural fire peak month');
netcdf.putAtt(outid, abm_id, 'units', 'unitless');

netcdf.putAtt(outid, gdp_id, 'longname', 'gdp');
netcdf.putAtt(outid, gdp_id, 'units', 'unitless');

netcdf.putAtt(outid, SLOPE_id, 'longname', 'mean topographic slope');
netcdf.putAtt(outid, SLOPE_id, 'units', 'degrees');

netcdf.putAtt(outid, STD_ELEV_id, 'longname', 'standard deviation of elevation');
netcdf.putAtt(outid, STD_ELEV_id, 'units', 'm');

netcdf.putAtt(outid, LAKEDEPTH_id, 'longname', 'lake depth');
netcdf.putAtt(outid, LAKEDEPTH_id, 'units', 'm');

netcdf.putAtt(outid, PCT_WETLAND_id, 'longname', 'percent wetland');
netcdf.putAtt(outid, PCT_WETLAND_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_LAKE_id, 'longname', 'percent lake');
netcdf.putAtt(outid, PCT_LAKE_id, 'units', 'unitless');

netcdf.putAtt(outid, PCT_GLACIER_id, 'longname', 'percent glacier');
netcdf.putAtt(outid, PCT_GLACIER_id, 'units', 'unitless');

netcdf.putAtt(outid, GLACIER_REGION_id, 'longname', 'glacier region ID');
netcdf.putAtt(outid, GLACIER_REGION_id, 'units', 'unitless');

netcdf.putAtt(outid, GLC_MEC_id, 'longname', 'Glacier elevation class');
netcdf.putAtt(outid, GLC_MEC_id, 'units', 'm');

netcdf.putAtt(outid, PCT_GLC_MEC_id, 'longname', 'percent glacier for each glacier elevation class (% of landunit)');
netcdf.putAtt(outid, PCT_GLC_MEC_id, 'units', 'unitless');

netcdf.putAtt(outid, TOPO_GLC_MEC_id, 'longname', 'mean elevation on glacier elevation classes');
netcdf.putAtt(outid, TOPO_GLC_MEC_id, 'units', 'm');

netcdf.putAtt(outid, PCT_URBAN_id, 'longname', 'percent urban for each density type');
netcdf.putAtt(outid, PCT_URBAN_id, 'units', 'unitless');

netcdf.putAtt(outid, URBAN_REGION_ID_id, 'longname', 'urban region ID');
netcdf.putAtt(outid, URBAN_REGION_ID_id, 'units', 'unitless');

netcdf.putAtt(outid, CONST_HARVEST_VH1_id, 'longname', 'harvest from primary forest');
netcdf.putAtt(outid, CONST_HARVEST_VH1_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_HARVEST_VH2_id, 'longname', 'harvest from primary non-forest');
netcdf.putAtt(outid, CONST_HARVEST_VH2_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_HARVEST_SH1_id, 'longname', 'harvest from secondary mature-forest');
netcdf.putAtt(outid, CONST_HARVEST_SH1_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_HARVEST_SH2_id, 'longname', 'harvest from secondary young-forest');
netcdf.putAtt(outid, CONST_HARVEST_SH2_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_HARVEST_SH3_id, 'longname', 'harvest from secondary non-forest');
netcdf.putAtt(outid, CONST_HARVEST_SH3_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_GRAZING_id, 'longname', 'grazing of herbacous pfts');
netcdf.putAtt(outid, CONST_GRAZING_id, 'units', 'gC/m2/yr');

netcdf.putAtt(outid, CONST_FERTNITRO_CFT_id, 'longname', 'nitrogen fertilizer for each crop');
netcdf.putAtt(outid, CONST_FERTNITRO_CFT_id, 'units', 'gN/m2/yr');

netcdf.putAtt(outid, UNREPRESENTED_PFT_LULCC_id, 'longname', 'unrepresented PFT gross LULCC transitions');
netcdf.putAtt(outid, UNREPRESENTED_PFT_LULCC_id, 'units', 'unitless');

netcdf.putAtt(outid, UNREPRESENTED_CFT_LULCC_id, 'longname', 'unrepresented crop gross LULCC transitions');
netcdf.putAtt(outid, UNREPRESENTED_CFT_LULCC_id, 'units', 'unitless');

% define global attribution
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Conventions', 'NCAR-CSM');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'History_Log', ['created on: ',datestr(now)]);
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Logname', 'dayon');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Host', '');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Source', 'Community Land Model: CLM5');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Version', 'release-cesm2.2.01/datahuge/wdy_cesmfiles/cesm_2_2_0/components/clm/tools/mksurf');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Compiler_Optimized', 'TRUE');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'no_inlandwet', 'TRUE');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'nglcec', '10');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Input_grid_dataset', 'map_0.25x0.25_MODIS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Input_gridtype', 'global');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'VOC_EF_raw_data_file_name', 'mksrf_vocef_0.5x0.5_simyr2000.c110531.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Inland_lake_raw_data_file_name', 'mksrf_LakePnDepth_3x3min_simyr2004_csplk_c151015.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Inland_wetland_raw_data_file_name', 'mksrf_lanwat.050425.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Glacier_raw_data_file_name', 'mksrf_glacier_3x3min_simyr2000.c120926.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Glacier_region_raw_data_file_name', 'mksrf_GlacierRegion_10x10min_nomask_c170616.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Urban_Topography_raw_data_file_name', 'mksrf_topo.10min.c080912.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Urban_raw_data_file_name', 'mksrf_urban_0.05x0.05_simyr2000.c120621.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Lai_raw_data_file_name', 'mksrf_lai_78pfts_simyr2005.c170413.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'agfirepkmon_raw_data_file_name', 'mksrf_abm_0.5x0.5_AVHRR_simyr2000.c130201.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'gdp_raw_data_file_name', 'mksrf_gdp_0.5x0.5_AVHRR_simyr2000.c130228.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'peatland_raw_data_file_name', 'mksrf_peatf_0.5x0.5_AVHRR_simyr2000.c130228.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'soildepth_raw_data_file_name', 'mksf_soilthk_5x5min_ORNL-Soil_simyr1900-2015_c170630.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'topography_stats_raw_data_file_name', 'mksrf_topostats_1km-merge-10min_HYDRO1K-merge-nomask_simyr2000.c130402.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_pft_file_name', 'map_0.25x0.25_MODIS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_lakwat_file', 'map_3x3min_MODIS-wCsp_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_wetlnd_file', 'map_0.5x0.5_AVHRR_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_glacier_file', 'map_3x3min_GLOBE-Gardner_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_glacier_region_file', 'map_10x10min_nomask_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_soil_texture_file', 'map_5x5min_IGBP-GSDP_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_soil_color_file', 'map_0.25x0.25_MODIS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_soil_organic_file', 'map_5x5min_ISRIC-WISE_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_urban_file', 'map_3x3min_LandScan2004_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_fmax_file', 'map_3x3min_USGS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_VOC_EF_file', 'map_0.5x0.5_AVHRR_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_harvest_file', 'map_0.25x0.25_MODIS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_lai_sai_file', 'map_0.25x0.25_MODIS_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_urban_topography_file', 'map_10x10min_nomask_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_agfirepkmon_file', 'map_0.5x0.5_AVHRR_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_gdp_file', 'map_0.5x0.5_AVHRR_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_peatland_file', 'map_0.5x0.5_AVHRR_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'map_soildepth_file', 'map_1km-merge-10min_HYDRO1K-merge-nomask_to_140x80pt_ECMWF_nomask_aave_da_c201128.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Soil_texture_raw_data_file_name', 'mksrf_soitex.10level.c010119.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Soil_color_raw_data_file_name', 'mksrf_soilcolor_CMIP6_simyr2005.c170623.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Fmax_raw_data_file_name', 'mksrf_fmax_3x3min_USGS_c120911.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Organic_matter_raw_data_file_name', 'mksrf_organic_10level_5x5min_ISRIC-WISE-NCSCD_nlev7_c120830.nc');
netcdf.putAtt(outid, netcdf.getConstant('NC_GLOBAL'), 'Vegetation_type_raw_data_filename', 'mksrf_landuse_histclm50_LUH2_2000.c170629.nc');

netcdf.close(outid);


