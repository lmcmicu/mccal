#!/bin/sh

# Copyright 2014-2016 Michael Cuffaro
# 
# This file is part of mccal.
# 
# mccal is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# mccal is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with mccal.  If not, see <http://www.gnu.org/licenses/>.


export PATH=/home/mike/bin:$PATH

for pid in $(ps -ef|grep findappointment |awk '{if ($8 == "python3") print $2}')
do
	kill $pid
done

findappointment --adm mike
