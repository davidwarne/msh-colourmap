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
function newh = adjusthue(M_sat,s_sat,h_sat,M_unsat)
% ADJUSTHUE: function to provide a continuos hues transistion when interpolating 
%			to an unsaturated colour in Msh space.
%
% AUTHOR: David Warne (david.warne@qut.edu.au)
%         Mark Barry (m.barry@qut.edu.au)
% DEPT: HPC & Research Support (qut.itshpc@qut.edu.au),(http://www.itservices.qut.edu.au/hpc/)
%       Queensland University of Technology (http://www.qut.edu.au)
% DATE CREATED - 19/03/2011
%
% Acknowledgements to Kenneth Morland (Sandia National Laboratories) and his work on
% Diverging Colour Maps for Scientific Visualisation
if M_sat >= M_unsat
	newh = h_sat;
else
	hSpin = (s_sat*sqrt(M_unsat*M_unsat - M_sat*M_sat))/(M_sat*sin(s_sat));
	if h_sat > -pi/3.0
		newh = h_sat + hSpin;
	else
		newh = h_sat - hSpin;
	end
end
