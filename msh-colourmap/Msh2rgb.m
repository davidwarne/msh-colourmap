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
function [r g b] = Msh2rgb(M, s, h)
% MSH2RGB: converts a set of points is Msh colour space to rgb colour space
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
% [1] K. Moreland (2009). Diverging Color Maps for Scientific Visualization. In ISVC 2009.

% transformation matrix from xyz to rgb
T_inv = [3.240625477320053,-0.968930714729320,0.055710120445511;...
-1.537207972210319,1.875756060885241,-0.204021050598487;...
-0.498628598698248,  0.041517523842954,1.056995942254388];
% convert from Msh to CIELAB colour space
L_star = M.*cos(s);
a_star = M.*sin(s).*cos(h);
b_star = M.*sin(s).*sin(h);

% convert from CIELAB to xyz colour space
ry = (L_star + 16.0)/116.0;
rx = (a_star/500.0) + ry;
rz = (-b_star/200.0) + ry;

% our reference white point
x_n = 0.9505;
y_n = 1.0;
z_n = 1.089;

x = f_inv(rx)*x_n;
y = f_inv(ry)*y_n;
z = f_inv(rz)*z_n;

% convert from xyz to rgb colour space
J = [x,y,z]*T_inv;
r = J(:,1);
g = J(:,2);
b = J(:,3);

function x = f_inv(y)
x = y;
uy = find(y>0.206893034422964);
ly = find(y<=0.206893034422964);
x(uy) = y(uy).*y(uy).*y(uy);
x(ly) = (y(ly) - 0.137931034)*0.12841916;
