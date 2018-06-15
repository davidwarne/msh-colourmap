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
function colours = buildColourMap(controlpoints,data,res)
% BUILDCOLOURMAP: creates a colour map with the given control points based on 
%					Kenneth Morlands diverging colour map.
%
% PARAMETERS: 
% 	CONTROLPOINTS - an N*3 matrix of colour controlpoints
% 	DATA - an N vector of data (assumed to be in ascending order), each point in 
%		 this vector will have the respective colour controlpoint mapped to it
% 	RES - the number of colours to return
%
% RETURNS:
%	COLOURS - a RES*3 colour table call colormap(COLOURS) to use the colour map
%			 in a matlab plot (search colormap in the matlab help) 
%
% AUTHOR: David Warne (david.warne@qut.edu.au)
%         Mark Barry (m.barry@qut.edu.au)
% DEPT: HPC & Research Support (qut.itshpc@qut.edu.au),(http://www.itservices.qut.edu.au/hpc/)
%       Queensland University of Technology (http://www.qut.edu.au)
% DATE CREATED - 19/03/2011
%
% Acknowledgements to Kenneth Morland (Sandia National Laboratories) and his work on
% Diverging Colour Maps for Scientific Visualisation
%
% KNOWN ISSUES: Kenneths algorthim will return colours outside the usual rgb in [0.0,1.0]
%				if any of the colour components are close to 0.0 or 1.0. I personally
%				recommend keeping the components within [0.001, 0.7] for stability.
%				either that or just clamp the results manually.

n = length(data)
normal = (data - data(1))/(data(n)-data(1));
d = linspace(0.0,1.0,res);
colours = zeros(res,3);
r = 0;
g = 0;
b = 0;


colours(1,:) = controlpoints(1,:);
colours(res,:) = controlpoints(n,:);
k=2;
for i=2:res
	if d(i) < normal(k)
		t = (d(i) - normal(k-1))/(normal(k)-normal(k-1));
		[r,g,b] = interpolateColour(controlpoints(k-1,:),controlpoints(k,:),t);
		colours(i,:) = [r,g,b];
	elseif d(i) == normal(k)
		colours(i,:) = controlpoints(k,:);
	else
		k = k+1;
		t = (d(i) - normal(k-1))/(normal(k)-normal(k-1));
		[r,g,b] = interpolateColour(controlpoints(k-1,:),controlpoints(k,:),t);
		colours(i,:) = [r,g,b];
	end
end
