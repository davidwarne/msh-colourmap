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
function [r_mid g_mid b_mid,M_mid,s_mid,h_mid] = interpolateColour(rgb1,rgb2,interp)
% INTERPOLATECOLOUR: colour interpolation function for creating continuous 
%					diverging colour maps 
%
% AUTHOR: David Warne (david.warne@qut.edu.au)
%         Mark Barry (m.barry@qut.edu.au)
% DEPT: HPC & Research Support (qut.itshpc@qut.edu.au),(http://www.itservices.qut.edu.au/hpc/)
%       Queensland University of Technology (http://www.qut.edu.au)
%       
% DATE CREATED - 19/03/2011
%
% Acknowledgements to Kenneth Morland (Sandia National Laboratories) and his work on
% Diverging Colour Maps for Scientific Visualisation

sthresh = 0.05;
radthresh = pi/3.0;

[M1,s1,h1] = rgb2Msh(rgb1(1),rgb1(2),rgb1(3));
[M2,s2,h2] = rgb2Msh(rgb2(1),rgb2(2),rgb2(3));

M_mid = 0.0;
s_mid = 0.0;
h_mid = 0.0;

% if the points are both saturated and distinct then place white in the middle
if (s1 >= sthresh) && (s2 >= sthresh) && (abs(h1-h2) > radthresh)
	M_mid = max([M1,M2,88.0])
	if interp <= 0.5
		M2 = M_mid;
		s2 = 0.0;
		h2 = 0.0;
		interp = 2.0*interp;
	else
		M1 = M_mid;
		s1 = 0.0;
		h1 = 0.0;
		interp = 2.0*interp - 1.0;
	end
end

% adjust the hue of unsaturated colours
if (s1 <= sthresh) && (s2 >= sthresh)
	h1 = adjusthue(M2,s2,h2,M1);
elseif (s1 >= sthresh) && (s2 <= sthresh)
	h2 = adjusthue(M1,s1,h1,M2);
end

%Linear interpolation on adjusted control points
M_mid = (1.0-interp)*M1+interp*M2;
s_mid = (1.0-interp)*s1+interp*s2;
h_mid = (1.0-interp)*h1+interp*h2;

[r_mid,g_mid,b_mid] = Msh2rgb(M_mid,s_mid,h_mid);

