#!/usr/bin/perl

# Copyright 2014-2024 Michael Cuffaro
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


package commonfuncs;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(MailError);

use strict;

sub MailError {
    my ($text) = @_;

    my $user = `whoami`;
    my $body = "";
    system("echo $body|mutt -s \"$text\" $user");
}

1;
