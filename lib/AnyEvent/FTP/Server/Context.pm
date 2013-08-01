package AnyEvent::FTP::Server::Context;

use strict;
use warnings;
use v5.10;
use Moo;
use warnings NONFATAL => 'all';

# ABSTRACT: FTP Server client context class
# VERSION

with 'AnyEvent::FTP::Role::Event';
with 'AnyEvent::FTP::Server::Role::Context';

__PACKAGE__->define_events(qw( auth ));

has ready => (
  is      => 'rw',
  default => sub { 1 },
);

sub push_request
{
  my($self, $con, $req) = @_;
  
  push @{ $self->{request_queue} }, [ $con, $req ];
  
  $self->process_queue if $self->ready;
  
  $self;
}

sub process_queue
{
  my($self) = @_;
  
  return $self unless @{ $self->{request_queue} } > 0;
  
  $self->ready(0);

  my($con, $req) = @{ shift @{ $self->{request_queue} } };

  my $command = lc $req->command;

  if($self->can('auth_command_check_hook'))
  {
    return unless $self->auth_command_check_hook($con, $command);
  }

  my $method = join '_', 'cmd', $command;
  
  if($self->can($method))
  {
    $self->$method($con, $req);
  }
  else
  {
    $self->invalid_command($con, $req);
  }
  
  $self;
}

sub invalid_command
{
  my($self, $con, $req) = @_;
  $con->send_response(500 => $req->command . ' not understood');
  $self->done;
}

sub invalid_syntax
{
  my($self, $con, $raw) = @_;
  $con->send_response(500 => 'Command not understood');
  $self->done;
}

sub help_quit { "QUIT" }

sub cmd_quit
{
  my($self, $con, $req) = @_;
  $con->send_response(221 => 'Goodbye');
  $con->close;
  $self;
}

sub done
{
  my($self) = @_;
  $self->ready(1);
  $self->process_queue;
  $self;
}

1;
