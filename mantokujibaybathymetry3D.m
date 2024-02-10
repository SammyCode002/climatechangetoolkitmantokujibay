ncei_data = load('C:\Users\LazyB\Downloads\ClimateChangeToolKit\Larger domain_cudem_WGS84 MSL Feet.xyz');
noaa_data = load('C:\Users\LazyB\Downloads\ClimateChangeToolKit\Bay Gap_cudem_WGS84 MSL Feet.xyz');

% Extract longitude, latitude, and elevation from each dataset
ncei_longitude = ncei_data(:, 1);
ncei_latitude = ncei_data(:, 2);
ncei_elevation = ncei_data(:, 3);

noaa_longitude = noaa_data(:, 1);
noaa_latitude = noaa_data(:, 2);
noaa_elevation = noaa_data(:, 3);

% grid based on the combined data
xmin = min([min(ncei_longitude), min(noaa_longitude)]);
xmax = max([max(ncei_longitude), max(noaa_longitude)]);
ymin = min([min(ncei_latitude), min(noaa_latitude)]);
ymax = max([max(ncei_latitude), max(noaa_latitude)]);

% grid for interpolation
dx = 3 / 60 / 60;
dy = 3 / 60 / 60;
[x, y] = meshgrid(xmin:dx:xmax, ymin:dy:ymax);

% Interpolate elevation values for the combined domain
ncei_interp = griddata(ncei_longitude, ncei_latitude, ncei_elevation, x, y, 'linear');
noaa_interp = griddata(noaa_longitude, noaa_latitude, noaa_elevation, x, y, 'linear');

% Merge the elevation data
merged_elevation = max(ncei_interp, noaa_interp);

% Visualizing the data
figure;
h = surf(x, y, merged_elevation); % Create surface plot
xlabel('Longitude');
ylabel('Latitude');
zlabel('Elevation (feet)');
title('3D Mantokuji Bay Bathymetry Map');

% Add lighting and enhance the appearance
lightHandle = light('Position', [xmax, ymax, max(merged_elevation(:))], 'Style', 'infinite');
lighting gouraud;  % Use Gouraud lighting
shading interp;    % Interpolated shading for smooth appearance
material dull;     % Apply a dull material to avoid overly shiny effects

