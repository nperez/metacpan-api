use strict;
use warnings;
package MetaCPAN::API::CPANRatings;
# ABSTRACT: CPAN Ratings information for MetaCPAN::API

use Any::Moose 'Role';

requires '_http_req';

has cpanratings_prefix => (
    is      => 'ro',
    isa     => 'Str',
    default => 'cpanratings',
);

# http://api.metacpan.org/cpanratings/Moose
sub search_cpanratings_exact {
    my $self    = shift;
    my $dist    = shift;
    my $base    = $self->base_url;
    my $prefix  = $self->cpanratings_prefix;
    my $url     = "$base/$prefix/$dist";
    my $result  = $self->_http_req($url);

    return $result;
}

# http://api.metacpan.org/cpanratings/_search?q=dist:Moose
sub search_cpanratings_like {
    my $self   = shift;
    my $dist   = shift;
    my $base   = $self->base_url;
    my $prefix = $self->cpanratings_prefix;
    my $url    = "$base/$prefix/_search?q=dist:$dist";
    my $result = $self->_http_req($url);

    return $result;
}

1;