%    Msh-ColourMap: An example of Kenneth Morland's classic diveriging colourmap
%    for use in MATLAB
%    Copyright (C) 2011 David Warne, Mark Barry, QUT
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <https://www.gnu.org/licenses/>.
%
%
% AUTHOR: David Warne (david.warne@qut.edu.au)
%         Mark Barry (m.barry@qut.edu.au)
% DEPT: HPC & Research Support (qut.itshpc@qut.edu.au),(http://www.itservices.qut.edu.au/hpc/)
%       Queensland University of Technology (http://www.qut.edu.au)
%
% NOTE TO USER!!!
%
% AS OF THIS MOMENT YOU HAVE NO EXCUSE WHATSOEVER FOR USING THE DEFAULT 
% RAINBOW COLOUR MAP!!!
%
% RAINBOWS BELONG IN THE SKY!!

addpath('msh-colourmap')

% red - (in MSH space = (80,1.08,0.5))
r1 = 0.456113231067048;
g1 =  0.001194261110163;
b1 =  0.019659873573119;

%white - (in MSH space = (88,0,1.061/-1.061))
r2 = 0.620559752873847;
g2 =  0.726297546027788;
b2 = 0.833423782034072;

% blue - (in MSH space = (80,1.08,-1.1))
r3 = 0.043151051997022;
g3 =0.072606109644023;
b3 = 0.528274904028404;

% get some data
[X,Y,Z] = peaks(30);

p = 0.0; % the point we want white to be mapped to 
		 %(try editing it and see the effect)

res = 200;
colmap = buildColourMap([r3,g3,b3;r2,r2,r2;r1,g1,b1],...
				[min(Z(:)),p,max(Z(:))],res);
				
figure;
colormap('jet');
% oh... this is gonna look crappy
surfc(X,Y,Z);
colorbar

% now watch the magic happen with Moreland's divering colour map!
figure;
colormap(colmap);
surfc(X,Y,Z);
colorbar
% NICE!!!!


