use strict;
use warnings;
package MetaCPAN::API::Release;
# ABSTRACT: Distribution and releases information for MetaCPAN::API

use Carp;
use Any::Moose 'Role';

# /release/{distribution}
# /release/{author}/{release}
sub release {
    my $self        = shift;
    my %req_opts    = @_ ? @_ : ();
    my $base        = $self->base_url;
    my $url         = '';
    my $input_error = "Either provide 'distribution' or 'author and 'release'";

    %req_opts or croak $input_error;

    if ( defined ( my $dist = $req_opts{'distribution'} ) ) {
        $url = "$base/release/$dist";
    } elsif (
        defined ( my $author  = $req_opts{'author'}  ) &&
        defined ( my $release = $req_opts{'release'} )
      ) {
        $url = "$base/release/$author/$release";
    } else {
        croak $input_error;
    }

    $self->fetch($url);
}

1;

__END__

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching information about distribution
and releases.

=head1 METHODS

=head2 release

    my $result = $mcpan->release( distribution => 'Moose' );

    # or
    my $result = $mcpan->release( author => 'DOY', release => 'Moose-2.0001' );

Searches MetaCPAN for a dist.

