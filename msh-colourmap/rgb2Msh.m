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
function [M s h] = rgb2Msh(r, g, b)
% RGB2MSH: converts a set of points is rgb colour space to Msh colour space
%
% AUTHOR: David Warne (david.warne@qut.edu.au)
%         Mark Barry (m.barry@qut.edu.au)
% DEPT: HPC & Research Support (qut.itshpc@qut.edu.au),(http://www.itservices.qut.edu.au/hpc/)
%       Queensland University of Technology (http://www.qut.edu.au)
% DATE CREATED - 19/03/2011
%
% Acknowledgements to Kenneth Morland (Sandia National Laboratories) and his work on
% Diverging Colour Maps for Scientific Visualisation

% transformation matrix from rgb to xyz
T = [0.4124,0.2126,0.0193;0.3576,0.7152,0.1192;0.1805,0.0722,0.9505];

%convert from rgb to xyz
K = [r,g,b]*T;

x = K(:,1);
y = K(:,2);
z = K(:,3);

% our reference white point
x_n = 0.9505;
y_n = 1.0;
z_n = 1.089;

% covert form xyz to CIELAB
rx = f(x./x_n);
ry = f(y./y_n);
rz = f(z./z_n);
L_star = 116.0*ry - 16.0;
a_star = 500.0*(rx - ry);
b_star = 200.0*(ry - rz);

% now convert from CIELAB to Msh colur space
M = (L_star.*L_star + a_star.*a_star + b_star.*b_star).^(1.0/2.0);
s = acos(L_star./M);
h = atan2(b_star,a_star);% need to use atan2 to accout for the ab quadrant

function y = f(x)
% F: our helper function
y = x;
ux = find(x > 0.008856); 
lx = find(x <= 0.008856);
y(ux) = x(ux).^(1.0/3.0);
y(lx) = 7.787*x(lx) + 0.137931034;
