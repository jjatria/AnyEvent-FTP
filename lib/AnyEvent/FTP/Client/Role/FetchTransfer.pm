package AnyEvent::FTP::Client::Role::FetchTransfer;

use strict;
use warnings;
use v5.10;
use Role::Tiny;

# ABSTRACT: Fetch transfer interface for AnyEvent::FTP objects
# VERSION

sub xfer
{
  my($self, $fh, $local) = @_;
  
  my $handle = $self->handle($fh);

  return unless defined $local;
  
  $handle->on_read(sub {
    $handle->push_read(sub {
      $local->($_[0]{rbuf});
      $_[0]{rbuf} = '';
    });
  });
}

sub convert_local
{
  my($self, $local) = @_;
  
  return unless defined $local;
  return $local if ref($local) eq 'CODE';
  
  if(ref($local) eq 'SCALAR')
  {
    return sub {
      $$local .= shift;
    };
  }
  elsif(ref($local) eq 'GLOB')
  {
    return sub {
      print $local shift;
    };
  }
  elsif(ref($local) eq '')
  {
    open my $fh, '>', $local;
    $self->on_close(sub { close $fh });
    return sub {
      print $fh shift;
    };
  }
  else
  {
    die 'unimplemented: ' . ref $local;
  }
}

sub push_command
{
  my $self = shift;
  my $cv = $self->{client}->push_command(
    @_,
  );
  
  $self->on_eof(sub {
    $cv->cb(sub {
      my $res = eval { $cv->recv };
      my $err = $@;
      if($err) { $self->{cv}->croak($err) }
      else     { $self->{cv}->send($res) }
    });
  });
}

1;