clear all; clc
% define input and output directories
inDir   = 'I:\merge_China_srfdata';
outDir  = 'I:\merge_China_srfdata';

inFile  = 'surfdata_280x160pt_China_ECMWF_hist_16pfts_Irrig_CMIP6_simyr2000_c201202.nc';
inDirFile = [inDir, '\', inFile];

outFile = 'surfdata_280x160pt_China_ECMWF_hist_16pfts_Irrig_CMIP6_simyr2000_c201202_Smoth.nc';
outDirFile = [outDir, '\', outFile];
outid = netcdf.create(outFile,'64BIT_OFFSET');

% define dimensions
londimID    = netcdf.defDim(outid,'lsmlon',280);
latdimID    = netcdf.defDim(outid,'lsmlat',160);
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

% read nc files and somth variables (the line 140 = (line139 + line141)/2 )
mxsoil_color_org = ncread(inDirFile, 'mxsoil_color'); % size 1x1
mxsoil_color_smth = mxsoil_color_org;       

SOIL_COLOR_org = ncread(inDirFile, 'SOIL_COLOR'); % size 280x160
SOIL_COLOR_org(140,:) = (SOIL_COLOR_org(139,:) + SOIL_COLOR_org(141,:))/2;
SOIL_COLOR_smth = SOIL_COLOR_org;

PCT_SAND_org = ncread(inDirFile, 'PCT_SAND'); % size 280x160x10
for i = 1:10
    PCT_SAND_org(140,:,i) = (PCT_SAND_org(139,:,i) + PCT_SAND_org(141,:,i))/2;    
end
PCT_SAND_smth = PCT_SAND_org;
 
PCT_CLAY_org  = ncread(inDirFile, 'PCT_CLAY'); % size 280x160x10
for i = 1:10
    PCT_CLAY_org(140,:,i) = (PCT_CLAY_org(139,:,i) + PCT_CLAY_org(141,:,i))/2;    
end
PCT_CLAY_smth = PCT_CLAY_org;

ORGANIC_org = ncread(inDirFile, 'ORGANIC'); % size 280x160x10
for i = 1:10
    ORGANIC_org(140,:,i) = (ORGANIC_org(139,:,i) + ORGANIC_org(141,:,i))/2;
end
ORGANIC_smth = ORGANIC_org;

FMAX_org    = ncread(inDirFile, 'FMAX'); % size 280x160
FMAX_org(140,:) = (FMAX_org(139,:) + FMAX_org(141,:))/2;
FMAX_smth   = FMAX_org;

natpft_org  = ncread(inDirFile, 'natpft'); % size: 15x1
natpft_smth = natpft_org;  

cft_org     = ncread(inDirFile, 'cft'); % size: 2x1
cft_smth    = cft_org;    
 
LANDFRAC_PFT_org  = ncread(inDirFile, 'LANDFRAC_PFT'); % size 280x160
LANDFRAC_PFT_org(140,:) = (LANDFRAC_PFT_org(139,:) + LANDFRAC_PFT_org(141,:))/2;
LANDFRAC_PFT_smth = LANDFRAC_PFT_org;

PFTDATA_MASK_org  = ncread(inDirFile, 'PFTDATA_MASK'); % size 280x160
PFTDATA_MASK_org(140,:) = (PFTDATA_MASK_org(139,:) + PFTDATA_MASK_org(141,:))/2;
PFTDATA_MASK_smth = PFTDATA_MASK_org;
 
PCT_NATVEG_org  = ncread(inDirFile, 'PCT_NATVEG'); % size 280x160
PCT_NATVEG_org(140,:) = (PCT_NATVEG_org(139,:) + PCT_NATVEG_org(141,:))/2;
PCT_NATVEG_smth = PCT_NATVEG_org;

PCT_CROP_org     = ncread(inDirFile, 'PCT_CROP'); % size 280x160
PCT_CROP_org(140,:) = (PCT_CROP_org(139,:) + PCT_CROP_org(141,:))/2;
PCT_CROP_smth    = PCT_CROP_org;
  
PCT_NAT_PFT_org = ncread(inDirFile, 'PCT_NAT_PFT'); % size 280x160x15
for i = 1:15
    PCT_NAT_PFT_org(140,:,i) = (PCT_NAT_PFT_org(139,:,i) + PCT_NAT_PFT_org(141,:,i))/2;
end
PCT_NAT_PFT_smth = PCT_NAT_PFT_org;
 
PCT_CFT_org  = ncread(inDirFile, 'PCT_CFT'); % size 280x160x2
for i = 1:2
    PCT_CFT_org(140,:,i) = (PCT_CFT_org(139,:,i) + PCT_CFT_org(141,:,i))/2;
end
PCT_CFT_smth = PCT_CFT_org;

MONTHLY_LAI_org = ncread(inDirFile, 'MONTHLY_LAI'); % size 280x160x17x12
for i = 1:17
    for j = 1:12
        MONTHLY_LAI_org(140,:,i,j) = (MONTHLY_LAI_org(139,:,i,j) + MONTHLY_LAI_org(141,:,i,j))/2;
    end
end
MONTHLY_LAI_smth = MONTHLY_LAI_org; 

MONTHLY_SAI_org = ncread(inDirFile, 'MONTHLY_SAI'); % size 280x160x17x12
for i = 1:17
    for j = 1:12
        MONTHLY_SAI_org(140,:,i,j) = (MONTHLY_SAI_org(139,:,i,j) + MONTHLY_SAI_org(141,:,i,j))/2;
    end
end
MONTHLY_SAI_smth = MONTHLY_SAI_org;

MONTHLY_HEIGHT_TOP_org = ncread(inDirFile, 'MONTHLY_HEIGHT_TOP'); % size 280x160x17x12
for i = 1:17
    for j = 1:12
        MONTHLY_HEIGHT_TOP_org(140,:,i,j) = (MONTHLY_HEIGHT_TOP_org(139,:,i,j) + MONTHLY_HEIGHT_TOP_org(141,:,i,j))/2;
    end
end
MONTHLY_HEIGHT_TOP_smth = MONTHLY_HEIGHT_TOP_org;
 
MONTHLY_HEIGHT_BOT_org = ncread(inDirFile, 'MONTHLY_HEIGHT_BOT'); % size 280x160x17x12
for i = 1:17
    for j = 1:12
        MONTHLY_HEIGHT_BOT_org(140,:,i,j) = (MONTHLY_HEIGHT_BOT_org(139,:,i,j) + MONTHLY_HEIGHT_BOT_org(141,:,i,j))/2;
    end
end
MONTHLY_HEIGHT_BOT_smth = MONTHLY_HEIGHT_BOT_org;

time_org    = ncread(inDirFile, 'time'); % size 12x1
time_smth    = time_org;   
 
AREA_org    = ncread(inDirFile, 'AREA'); % size 280x160
AREA_org(140,:) = (AREA_org(139,:) + AREA_org(141,:))/2;
AREA_smth   = AREA_org;
 
LONGXY_org  = ncread(inDirFile, 'LONGXY'); % size 280x160
LONGXY_org(140,:) = (LONGXY_org(139,:) + LONGXY_org(141,:))/2;
LONGXY_smth = LONGXY_org;

LATIXY_org  = ncread(inDirFile, 'LATIXY'); % size 280x160
LATIXY_org(140,:) = (LATIXY_org(139,:) + LATIXY_org(141,:))/2;
LATIXY_smth = LATIXY_org;
 
EF1_BTR_org  = ncread(inDirFile, 'EF1_BTR'); % size 280x160
EF1_BTR_org(140,:) = (EF1_BTR_org(139,:) + EF1_BTR_org(141,:))/2;
EF1_BTR_smth = EF1_BTR_org;

EF1_FET_org  = ncread(inDirFile, 'EF1_FET'); % size 280x160
EF1_FET_org(140,:) = (EF1_FET_org(139,:) + EF1_FET_org(141,:))/2;
EF1_FET_smth = EF1_FET_org;

EF1_FDT_org  = ncread(inDirFile, 'EF1_FDT'); % size 280x160
EF1_FDT_org(140,:) = (EF1_FDT_org(139,:) + EF1_FDT_org(141,:))/2;
EF1_FDT_smth = EF1_FDT_org;

EF1_SHR_org  = ncread(inDirFile, 'EF1_SHR'); % size 280x160
EF1_SHR_org(140,:) = (EF1_SHR_org(139,:) + EF1_SHR_org(141,:))/2;
EF1_SHR_smth = EF1_SHR_org;
 
EF1_GRS_org  = ncread(inDirFile, 'EF1_GRS'); % size 280x160
EF1_GRS_org(140,:) = (EF1_GRS_org(139,:) + EF1_GRS_org(141,:))/2;
EF1_GRS_smth = EF1_GRS_org;
 
EF1_CRP_org  = ncread(inDirFile, 'EF1_CRP'); % size 280x160
EF1_CRP_org(140,:) = (EF1_CRP_org(139,:) + EF1_CRP_org(141,:))/2;
EF1_CRP_smth = EF1_CRP_org;

CANYON_HWR_org  = ncread(inDirFile, 'CANYON_HWR'); % size 280x160x3
for i = 1:3
    CANYON_HWR_org(140,:,i) = (CANYON_HWR_org(139,:,i) + CANYON_HWR_org(141,:,i))/2;
end
CANYON_HWR_smth = CANYON_HWR_org;
 
EM_IMPROAD_org  = ncread(inDirFile, 'EM_IMPROAD'); % size 280x160x3
for i = 1:3
    EM_IMPROAD_org(140,:,i) = (EM_IMPROAD_org(139,:,i) + EM_IMPROAD_org(141,:,i))/2;
end
EM_IMPROAD_smth = EM_IMPROAD_org;

EM_PERROAD_org  = ncread(inDirFile, 'EM_PERROAD'); % size 280x160x3
for i = 1:3
    EM_PERROAD_org(140,:,i) = (EM_PERROAD_org(139,:,i) + EM_PERROAD_org(141,:,i))/2;
end
EM_PERROAD_smth = EM_PERROAD_org;
 
EM_ROOF_org  = ncread(inDirFile, 'EM_ROOF'); % size 280x160x3
for i = 1:3
    EM_ROOF_org(140,:,i) = (EM_ROOF_org(139,:,i) + EM_ROOF_org(141,:,i))/2;
end
EM_ROOF_smth = EM_ROOF_org;

EM_WALL_org  = ncread(inDirFile, 'EM_WALL'); % size 280x160x3
for i = 1:3
    EM_WALL_org(140,:,i) = (EM_WALL_org(139,:,i) + EM_WALL_org(141,:,i))/2;
end
EM_WALL_smth = EM_WALL_org;
 
HT_ROOF_org  = ncread(inDirFile, 'HT_ROOF'); % size 280x160x3
for i = 1:3
    HT_ROOF_org(140,:,i) = (HT_ROOF_org(139,:,i) + HT_ROOF_org(141,:,i))/2;
end
HT_ROOF_smth = HT_ROOF_org;
 
THICK_ROOF_org  = ncread(inDirFile, 'THICK_ROOF'); % size 280x160x3
for i = 1:3
    THICK_ROOF_org(140,:,i) = (THICK_ROOF_org(139,:,i) + THICK_ROOF_org(141,:,i))/2;
end
THICK_ROOF_smth = THICK_ROOF_org;

THICK_WALL_org = ncread(inDirFile, 'THICK_WALL'); % size 280x160x3
for i = 1:3
    THICK_WALL_org(140,:,i) = (THICK_WALL_org(139,:,i) + THICK_WALL_org(141,:,i))/2;
end
THICK_WALL_smth = THICK_WALL_org;
 
T_BUILDING_MIN_org = ncread(inDirFile, 'T_BUILDING_MIN'); % size 280x160x3
for i = 1:3
    T_BUILDING_MIN_org(140,:,i) = (T_BUILDING_MIN_org(139,:,i) + T_BUILDING_MIN_org(141,:,i))/2;
end
T_BUILDING_MIN_smth = T_BUILDING_MIN_org;

WIND_HGT_CANYON_org = ncread(inDirFile, 'WIND_HGT_CANYON'); % size 280x160x3
for i = 1:3
    WIND_HGT_CANYON_org(140,:,i) = (WIND_HGT_CANYON_org(139,:,i) + WIND_HGT_CANYON_org(141,:,i))/2;
end
WIND_HGT_CANYON_smth = WIND_HGT_CANYON_org;
 
WTLUNIT_ROOF_org = ncread(inDirFile, 'WTLUNIT_ROOF'); % size 280x160x3
for i = 1:3
    WTLUNIT_ROOF_org(140,:,i) = (WTLUNIT_ROOF_org(139,:,i) + WTLUNIT_ROOF_org(141,:,i))/2;
end
WTLUNIT_ROOF_smth = WTLUNIT_ROOF_org;

WTROAD_PERV_org = ncread(inDirFile, 'WTROAD_PERV'); % size 280x160x3
for i = 1:3
    WTROAD_PERV_org(140,:,i) = (WTROAD_PERV_org(139,:,i) + WTROAD_PERV_org(141,:,i))/2;
end
WTROAD_PERV_smth = WTROAD_PERV_org;
 
ALB_IMPROAD_DIR_org = ncread(inDirFile, 'ALB_IMPROAD_DIR'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_IMPROAD_DIR_org(140,:,i,j) = (ALB_IMPROAD_DIR_org(139,:,i,j) + ALB_IMPROAD_DIR_org(141,:,i,j))/2;
    end
end
ALB_IMPROAD_DIR_smth = ALB_IMPROAD_DIR_org;

ALB_IMPROAD_DIF_org = ncread(inDirFile, 'ALB_IMPROAD_DIF'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_IMPROAD_DIF_org(140,:,i,j) = (ALB_IMPROAD_DIF_org(139,:,i,j) + ALB_IMPROAD_DIF_org(141,:,i,j))/2;
    end
end
ALB_IMPROAD_DIF_smth = ALB_IMPROAD_DIF_org;
 
ALB_PERROAD_DIR_org = ncread(inDirFile, 'ALB_PERROAD_DIR'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_PERROAD_DIR_org(140,:,i,j) = (ALB_PERROAD_DIR_org(139,:,i,j) + ALB_PERROAD_DIR_org(141,:,i,j))/2;
    end
end
ALB_PERROAD_DIR_smth = ALB_PERROAD_DIR_org;
 
ALB_PERROAD_DIF_org = ncread(inDirFile, 'ALB_PERROAD_DIF'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_PERROAD_DIF_org(140,:,i,j) = (ALB_PERROAD_DIF_org(139,:,i,j) + ALB_PERROAD_DIF_org(141,:,i,j))/2;
    end
end
ALB_PERROAD_DIF_smth = ALB_PERROAD_DIF_org;

ALB_ROOF_DIR_org = ncread(inDirFile, 'ALB_ROOF_DIR'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_ROOF_DIR_org(140,:,i,j) = (ALB_ROOF_DIR_org(139,:,i,j) + ALB_ROOF_DIR_org(141,:,i,j))/2;
    end
end
ALB_ROOF_DIR_smth = ALB_ROOF_DIR_org;
 
ALB_ROOF_DIF_org = ncread(inDirFile, 'ALB_ROOF_DIF'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_ROOF_DIF_org(140,:,i,j) = (ALB_ROOF_DIF_org(139,:,i,j) + ALB_ROOF_DIF_org(141,:,i,j))/2;
    end
end
ALB_ROOF_DIF_smth = ALB_ROOF_DIF_org;

ALB_WALL_DIR_org = ncread(inDirFile, 'ALB_WALL_DIR'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_WALL_DIR_org(140,:,i,j) = (ALB_WALL_DIR_org(139,:,i,j) + ALB_WALL_DIR_org(141,:,i,j))/2;
    end
end
ALB_WALL_DIR_smth = ALB_WALL_DIR_org;

ALB_WALL_DIF_org = ncread(inDirFile, 'ALB_WALL_DIF'); % size 280x160x3x2
for i = 1:3
    for j = 1:2
        ALB_WALL_DIF_org(140,:,i,j) = (ALB_WALL_DIF_org(139,:,i,j) + ALB_WALL_DIF_org(141,:,i,j))/2;
    end
end
ALB_WALL_DIF_smth = ALB_WALL_DIF_org;

TK_ROOF_org = ncread(inDirFile, 'TK_ROOF'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        TK_ROOF_org(140,:,i,j) = (TK_ROOF_org(139,:,i,j) + TK_ROOF_org(141,:,i,j))/2;
    end
end
TK_ROOF_smth = TK_ROOF_org;
 
TK_WALL_org = ncread(inDirFile, 'TK_WALL'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        TK_WALL_org(140,:,i,j) = (TK_WALL_org(139,:,i,j) + TK_WALL_org(141,:,i,j))/2;
    end
end
TK_WALL_smth = TK_WALL_org;

TK_IMPROAD_org = ncread(inDirFile, 'TK_IMPROAD'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        TK_IMPROAD_org(140,:,i,j) = (TK_IMPROAD_org(139,:,i,j) + TK_IMPROAD_org(141,:,i,j))/2;
    end
end
TK_IMPROAD_smth = TK_IMPROAD_org;
 
CV_ROOF_org = ncread(inDirFile, 'CV_ROOF'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        CV_ROOF_org(140,:,i,j) = (CV_ROOF_org(139,:,i,j) + CV_ROOF_org(141,:,i,j))/2;
    end
end
CV_ROOF_smth = CV_ROOF_org;

CV_WALL_org = ncread(inDirFile, 'CV_WALL'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        CV_WALL_org(140,:,i,j) = (CV_WALL_org(139,:,i,j) + CV_WALL_org(141,:,i,j))/2;
    end
end
CV_WALL_smth = CV_WALL_org;
 
CV_IMPROAD_org = ncread(inDirFile, 'CV_IMPROAD'); % size 280x160x3x5
for i = 1:3
    for j = 1:5
        CV_IMPROAD_org(140,:,i,j) = (CV_IMPROAD_org(139,:,i,j) + CV_IMPROAD_org(141,:,i,j))/2;
    end
end
CV_IMPROAD_smth = CV_IMPROAD_org;

NLEV_IMPROAD_org = ncread(inDirFile, 'NLEV_IMPROAD'); % size 280x160x3
for i = 1:3
    NLEV_IMPROAD_org(140,:,i) = (NLEV_IMPROAD_org(139,:,i) + NLEV_IMPROAD_org(141,:,i))/2;
end
NLEV_IMPROAD_smth = NLEV_IMPROAD_org;

peatf_org = ncread(inDirFile, 'peatf'); % size 280x160
peatf_org(140,:) = (peatf_org(139,:) + peatf_org(141,:))/2;
peatf_smth = peatf_org;

zbedrock_org = ncread(inDirFile, 'zbedrock'); % size 280x160
zbedrock_org(140,:) = (zbedrock_org(139,:) + zbedrock_org(141,:))/2;
zbedrock_smth = zbedrock_org;
 
abm_org = ncread(inDirFile, 'abm'); % size 280x160
abm_org(140,:) = (abm_org(139,:) + abm_org(141,:))/2;
abm_smth = abm_org;

gdp_org = ncread(inDirFile, 'gdp'); % size 280x160
gdp_org(140,:) = (gdp_org(139,:) + gdp_org(141,:))/2;
gdp_smth = gdp_org;

SLOPE_org = ncread(inDirFile, 'SLOPE'); % size 280x160
SLOPE_org(140,:) = (SLOPE_org(139,:) + SLOPE_org(141,:))/2;
SLOPE_smth = SLOPE_org;
 
STD_ELEV_org = ncread(inDirFile, 'STD_ELEV'); % size 280x160
STD_ELEV_org(140,:) = (STD_ELEV_org(139,:) + STD_ELEV_org(141,:))/2;
STD_ELEV_smth = STD_ELEV_org;

LAKEDEPTH_org = ncread(inDirFile, 'LAKEDEPTH'); % size 280x160
LAKEDEPTH_org(140,:) = (LAKEDEPTH_org(139,:) + LAKEDEPTH_org(141,:))/2;
LAKEDEPTH_smth = LAKEDEPTH_org;
 
PCT_WETLAND_org = ncread(inDirFile, 'PCT_WETLAND'); % size 280x160
PCT_WETLAND_org(140,:) = (PCT_WETLAND_org(139,:) + PCT_WETLAND_org(141,:))/2;
PCT_WETLAND_smth = PCT_WETLAND_org;
 
PCT_LAKE_org = ncread(inDirFile, 'PCT_LAKE'); % size 280x160
PCT_LAKE_org(140,:) = (PCT_LAKE_org(139,:) + PCT_LAKE_org(141,:))/2;
PCT_LAKE_smth = PCT_LAKE_org;
 
PCT_GLACIER_org = ncread(inDirFile, 'PCT_GLACIER'); % size 280x160
PCT_GLACIER_org(140,:) = (PCT_GLACIER_org(139,:) + PCT_GLACIER_org(141,:))/2;
PCT_GLACIER_smth = PCT_GLACIER_org;
 
GLACIER_REGION_org = ncread(inDirFile, 'GLACIER_REGION'); % size 280x160
GLACIER_REGION_org(140,:) = (GLACIER_REGION_org(139,:) + GLACIER_REGION_org(141,:))/2;
GLACIER_REGION_smth = GLACIER_REGION_org;
 
GLC_MEC_org = ncread(inDirFile, 'GLC_MEC'); % size 11x1
GLC_MEC_smth = GLC_MEC_org;   
 
PCT_GLC_MEC_org = ncread(inDirFile, 'PCT_GLC_MEC'); % size 280x160x10
for i = 1:10
    PCT_GLC_MEC_org(140,:,i) = (PCT_GLC_MEC_org(139,:,i) + PCT_GLC_MEC_org(141,:,i))/2;
end
PCT_GLC_MEC_smth = PCT_GLC_MEC_org;
 
TOPO_GLC_MEC_org = ncread(inDirFile, 'TOPO_GLC_MEC'); % size 280x160x10
for i = 1:10
    TOPO_GLC_MEC_org(140,:,i) = (TOPO_GLC_MEC_org(139,:,i) + TOPO_GLC_MEC_org(141,:,i))/2;
end
TOPO_GLC_MEC_smth = TOPO_GLC_MEC_org;
 
PCT_URBAN_org = ncread(inDirFile, 'PCT_URBAN'); % size 280x160x3
for i = 1:3
    PCT_URBAN_org(140,:,i) = (PCT_URBAN_org(139,:,i) + PCT_URBAN_org(141,:,i))/2;
end
PCT_URBAN_smth = PCT_URBAN_org; 

URBAN_REGION_ID_org = ncread(inDirFile, 'URBAN_REGION_ID');  % size 280x160
URBAN_REGION_ID_org(140,:) = (URBAN_REGION_ID_org(139,:) + URBAN_REGION_ID_org(141,:))/2;
URBAN_REGION_ID_smth = URBAN_REGION_ID_org;
 
CONST_HARVEST_VH1_org = ncread(inDirFile, 'CONST_HARVEST_VH1'); % size 280x160
CONST_HARVEST_VH1_org(140,:) = (CONST_HARVEST_VH1_org(139,:) + CONST_HARVEST_VH1_org(141,:))/2;
CONST_HARVEST_VH1_smth = CONST_HARVEST_VH1_org;
 
CONST_HARVEST_VH2_org = ncread(inDirFile, 'CONST_HARVEST_VH2'); % size 280x160
CONST_HARVEST_VH2_org(140,:) = (CONST_HARVEST_VH2_org(139,:) + CONST_HARVEST_VH2_org(141,:))/2;
CONST_HARVEST_VH2_smth = CONST_HARVEST_VH2_org;
 
CONST_HARVEST_SH1_org = ncread(inDirFile, 'CONST_HARVEST_SH1'); % size 280x160
CONST_HARVEST_SH1_org(140,:) = (CONST_HARVEST_SH1_org(139,:) + CONST_HARVEST_SH1_org(141,:))/2;
CONST_HARVEST_SH1_smth = CONST_HARVEST_SH1_org;
 
CONST_HARVEST_SH2_org = ncread(inDirFile, 'CONST_HARVEST_SH2'); % size 280x160
CONST_HARVEST_SH2_org(140,:) = (CONST_HARVEST_SH2_org(139,:) + CONST_HARVEST_SH2_org(141,:))/2;
CONST_HARVEST_SH2_smth = CONST_HARVEST_SH2_org;
 
CONST_HARVEST_SH3_org = ncread(inDirFile, 'CONST_HARVEST_SH3'); % size 280x160
CONST_HARVEST_SH3_org(140,:) = (CONST_HARVEST_SH3_org(139,:) + CONST_HARVEST_SH3_org(141,:))/2;
CONST_HARVEST_SH3_smth = CONST_HARVEST_SH3_org;
 
CONST_GRAZING_org = ncread(inDirFile, 'CONST_GRAZING'); % size 280x160
CONST_GRAZING_org(140,:) = (CONST_GRAZING_org(139,:) + CONST_GRAZING_org(141,:))/2;
CONST_GRAZING_smth = CONST_GRAZING_org;
 
CONST_FERTNITRO_CFT_org = ncread(inDirFile, 'CONST_FERTNITRO_CFT'); % size 280x160x2
for i = 1:2
    CONST_FERTNITRO_CFT_org(140,:,i) = (CONST_FERTNITRO_CFT_org(139,:,i) + CONST_FERTNITRO_CFT_org(141,:,i))/2;
end
CONST_FERTNITRO_CFT_smth = CONST_FERTNITRO_CFT_org;
 
UNREPRESENTED_PFT_LULCC_org = ncread(inDirFile, 'UNREPRESENTED_PFT_LULCC'); % size 280x160x15
for i = 1:15
    UNREPRESENTED_PFT_LULCC_org(140,:,i) = (UNREPRESENTED_PFT_LULCC_org(139,:,i) + UNREPRESENTED_PFT_LULCC_org(141,:,i))/2;
end
UNREPRESENTED_PFT_LULCC_smth = UNREPRESENTED_PFT_LULCC_org;
 
UNREPRESENTED_CFT_LULCC_org = ncread(inDirFile, 'UNREPRESENTED_CFT_LULCC'); % size 280x160x2
for i = 1:2
    UNREPRESENTED_CFT_LULCC_org(140,:,i) = (UNREPRESENTED_CFT_LULCC_org(139,:,i) + UNREPRESENTED_CFT_LULCC_org(141,:,i))/2;
end
UNREPRESENTED_CFT_LULCC_smth = UNREPRESENTED_CFT_LULCC_org;
 
% put variables into nc
netcdf.putVar(outid, mxsoil_color_id, mxsoil_color_smth);
netcdf.putVar(outid, SOIL_COLOR_id, SOIL_COLOR_smth);
netcdf.putVar(outid, PCT_SAND_id, PCT_SAND_smth);
netcdf.putVar(outid, PCT_CLAY_id, PCT_CLAY_smth);
netcdf.putVar(outid, ORGANIC_id, ORGANIC_smth);
netcdf.putVar(outid, FMAX_id, FMAX_smth);
netcdf.putVar(outid, natpft_id, natpft_smth);
netcdf.putVar(outid, cft_id, cft_smth);
netcdf.putVar(outid, LANDFRAC_PFT_id, LANDFRAC_PFT_smth);
netcdf.putVar(outid, PFTDATA_MASK_id, PFTDATA_MASK_smth);
netcdf.putVar(outid, PCT_NATVEG_id, PCT_NATVEG_smth);
netcdf.putVar(outid, PCT_CROP_id, PCT_CROP_smth);
netcdf.putVar(outid, PCT_NAT_PFT_id, PCT_NAT_PFT_smth);
netcdf.putVar(outid, PCT_CFT_id, PCT_CFT_smth);
netcdf.putVar(outid, MONTHLY_LAI_id, MONTHLY_LAI_smth);
netcdf.putVar(outid, MONTHLY_SAI_id, MONTHLY_SAI_smth);
netcdf.putVar(outid, MONTHLY_HEIGHT_TOP_id, MONTHLY_HEIGHT_TOP_smth);
netcdf.putVar(outid, MONTHLY_HEIGHT_BOT_id, MONTHLY_HEIGHT_BOT_smth);
netcdf.putVar(outid, time_id, time_smth);
netcdf.putVar(outid, AREA_id, AREA_smth);
netcdf.putVar(outid, LONGXY_id, LONGXY_smth);
netcdf.putVar(outid, LATIXY_id, LATIXY_smth);
netcdf.putVar(outid, EF1_BTR_id, EF1_BTR_smth);
netcdf.putVar(outid, EF1_FET_id, EF1_FET_smth);
netcdf.putVar(outid, EF1_FDT_id, EF1_FDT_smth);
netcdf.putVar(outid, EF1_SHR_id, EF1_SHR_smth);
netcdf.putVar(outid, EF1_GRS_id, EF1_GRS_smth);
netcdf.putVar(outid, EF1_CRP_id, EF1_CRP_smth);
netcdf.putVar(outid, CANYON_HWR_id, CANYON_HWR_smth);
netcdf.putVar(outid, EM_IMPROAD_id, EM_IMPROAD_smth);
netcdf.putVar(outid, EM_PERROAD_id, EM_PERROAD_smth);
netcdf.putVar(outid, EM_ROOF_id, EM_ROOF_smth);
netcdf.putVar(outid, EM_WALL_id, EM_WALL_smth);
netcdf.putVar(outid, HT_ROOF_id, HT_ROOF_smth);
netcdf.putVar(outid, THICK_ROOF_id, THICK_ROOF_smth);
netcdf.putVar(outid, THICK_WALL_id, THICK_WALL_smth);
netcdf.putVar(outid, T_BUILDING_MIN_id, T_BUILDING_MIN_smth);
netcdf.putVar(outid, WIND_HGT_CANYON_id, WIND_HGT_CANYON_smth);
netcdf.putVar(outid, WTLUNIT_ROOF_id, WTLUNIT_ROOF_smth);
netcdf.putVar(outid, WTROAD_PERV_id, WTROAD_PERV_smth);
netcdf.putVar(outid, ALB_IMPROAD_DIR_id, ALB_IMPROAD_DIR_smth);
netcdf.putVar(outid, ALB_IMPROAD_DIF_id, ALB_IMPROAD_DIF_smth);
netcdf.putVar(outid, ALB_PERROAD_DIR_id, ALB_PERROAD_DIR_smth);
netcdf.putVar(outid, ALB_PERROAD_DIF_id, ALB_PERROAD_DIF_smth);
netcdf.putVar(outid, ALB_ROOF_DIR_id, ALB_ROOF_DIR_smth);
netcdf.putVar(outid, ALB_ROOF_DIF_id, ALB_ROOF_DIF_smth);
netcdf.putVar(outid, ALB_WALL_DIR_id, ALB_WALL_DIR_smth);
netcdf.putVar(outid, ALB_WALL_DIF_id, ALB_WALL_DIF_smth);
netcdf.putVar(outid, TK_ROOF_id, TK_ROOF_smth);
netcdf.putVar(outid, TK_WALL_id, TK_WALL_smth);
netcdf.putVar(outid, TK_IMPROAD_id, TK_IMPROAD_smth);
netcdf.putVar(outid, CV_ROOF_id, CV_ROOF_smth);
netcdf.putVar(outid, CV_WALL_id, CV_WALL_smth);
netcdf.putVar(outid, CV_IMPROAD_id, CV_IMPROAD_smth);
netcdf.putVar(outid, NLEV_IMPROAD_id, NLEV_IMPROAD_smth);
netcdf.putVar(outid, peatf_id, peatf_smth);
netcdf.putVar(outid, zbedrock_id, zbedrock_smth);
netcdf.putVar(outid, abm_id, abm_smth);
netcdf.putVar(outid, gdp_id, gdp_smth);
netcdf.putVar(outid, SLOPE_id, SLOPE_smth);
netcdf.putVar(outid, STD_ELEV_id, STD_ELEV_smth);
netcdf.putVar(outid, LAKEDEPTH_id, LAKEDEPTH_smth);
netcdf.putVar(outid, PCT_WETLAND_id, PCT_WETLAND_smth);
netcdf.putVar(outid, PCT_LAKE_id, PCT_LAKE_smth);
netcdf.putVar(outid, PCT_GLACIER_id, PCT_GLACIER_smth);
netcdf.putVar(outid, GLACIER_REGION_id, GLACIER_REGION_smth);
netcdf.putVar(outid, GLC_MEC_id, GLC_MEC_smth);
netcdf.putVar(outid, PCT_GLC_MEC_id, PCT_GLC_MEC_smth);
netcdf.putVar(outid, TOPO_GLC_MEC_id, TOPO_GLC_MEC_smth);
netcdf.putVar(outid, PCT_URBAN_id, PCT_URBAN_smth);
netcdf.putVar(outid, URBAN_REGION_ID_id, URBAN_REGION_ID_smth);
netcdf.putVar(outid, CONST_HARVEST_VH1_id, CONST_HARVEST_VH1_smth);
netcdf.putVar(outid, CONST_HARVEST_VH2_id, CONST_HARVEST_VH2_smth);
netcdf.putVar(outid, CONST_HARVEST_SH1_id, CONST_HARVEST_SH1_smth);
netcdf.putVar(outid, CONST_HARVEST_SH2_id, CONST_HARVEST_SH2_smth);
netcdf.putVar(outid, CONST_HARVEST_SH3_id, CONST_HARVEST_SH3_smth);
netcdf.putVar(outid, CONST_GRAZING_id, CONST_GRAZING_smth);
netcdf.putVar(outid, CONST_FERTNITRO_CFT_id, CONST_FERTNITRO_CFT_smth);
netcdf.putVar(outid, UNREPRESENTED_PFT_LULCC_id, UNREPRESENTED_PFT_LULCC_smth);
netcdf.putVar(outid, UNREPRESENTED_CFT_LULCC_id, UNREPRESENTED_CFT_LULCC_smth);

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


