package Lingua::Han::PinYin;

use strict;
use vars qw($VERSION);
$VERSION = '0.01';

sub new {
	my $class = shift;
	my $dir = __FILE__; $dir =~ s/\.pm//o;
	-d $dir or die "Directory $dir nonexistent!";
	my $self = { '_dir_' => $dir, @_ };
	unless ($self->{'format'}) { $self->{'format'} = 'gb2312'; }
	my %py;
	my $file = $self->{'_dir_'} . "/PinYin_" . $self->{'format'} . ".txt";
	open(FH, $file)	or die "$file: $!";
	while(<FH>) {
		my ($uni, $py) = split(/\s+/);
		$py{$uni} = $py;
	}
	close(FH);
	$self->{'py'} = \%py;
	return bless $self => $class;
}

sub han2pinyin {
	my ($self, $hanzi) = @_;
	my $uni = unpack("H*",$hanzi);
	if (exists $self->{'py'}->{$uni}) {
		return $self->{'py'}->{$uni};
	} else {
		return 'XX';
	}
}

1;
__END__

=head1 NAME

Lingua::Han::PinYin - Retrieve the PinYin of Chinese character.

=head1 SYNOPSIS

  use Lingua::Han::PinYin;
  
  # if the format of your script is gb2312, default
  my $h2p = new Lingua::Han::PinYin();
  print $h2p->han2pinyin("我");
  
  # if the format of your script is utf-8
  my $h2p = new Lingua::Han::PinYin(format => 'utf8');
  print $h2p->han2pinyin("我");

=head1 DESCRIPTION

There is a Chinese document @ L<http://www.fayland.org/journal/Han2PinYin.html>. It tells why and how I write this module.

=head1 RESTRICTIONS

if the character is polyphone(DuoYinZi), we can B<NOT> point out the correct one.

=head1 OPTION

=head1 RETURN VALUE

if it's a common character, it returns its pinyin/spell.

if not, it returns 'XX';

=head1 SEE ALSO

L<Unicode::Unihan>

=head1 AUTHOR

Fayland, fayland@gmail.com

=head1 COPYRIGHT

Copyright (c) 2005 Fayland All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>