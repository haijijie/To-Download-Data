pat='';
varname='par';
start_year=2012;
end_year=2022;
start_day=1;
date0='20220817';
t=datevec(datenum(date0,'yyyymmdd'));
end_day=datenum(date0,'yyyymmdd')-datenum(t(1)-1,12,31);


for year=start_year:end_year
    if  year==end_year
        day_list=1:end_day;
    elseif(mod(year,4)==0 && mod(year,100)~=0 || mod(year,400)==0)
        if year==start_year
            day_list=start_day:366;
        else
            day_list=1:366;
        end
    else
        if year==start_year
            day_list=start_day:365;
        else
            day_list=1:365;
        end
    end
    for di=1:length(day_list)
        day=day_list(di);
        doy2date=datestr(datetime(year, 1, day),'yyyymmdd');
        if day<10
            file1=['A',num2str(year),'00',num2str(day),'.L3m_DAY_PAR_',varname,'_4km.nc'];
        elseif day<100
            file1=['A',num2str(year),'0',num2str(day),'.L3m_DAY_PAR_',varname,'_4km.nc'];
        else
            file1=['A',num2str(year),num2str(day),'.L3m_DAY_PAR_',varname,'_4km.nc'];
        end
        file2=['AQUA_MODIS.',doy2date,'.L3m.DAY.PAR.',varname,'.4km.nc'];
        find_file_no_exist(varname,pat,file1,file2);

    end
end

% file_1:A2002203.L3m_DAY_PAR_par_4km.nc
% file_2:AQUA_MODIS.20220303.L3m.DAY.PAR.par.4km.nc

function find_file_no_exist(varname,pat,file1,file2)
try
    lat=ncread([pat,file1],'lat');
catch
    fid = fopen([varname,'_to_download_',datestr(date,'yyyymmdd'),'.txt'], 'a');
    fprintf(fid,['https://oceandata.sci.gsfc.nasa.gov/cgi/getfile/',file2,'\r\n']);
    fclose(fid);
end
end
