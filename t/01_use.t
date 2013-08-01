use strict;
use warnings;
use Test::More tests => 33;

BEGIN { eval 'use EV' }

use_ok 'AnyEvent::FTP';
use_ok 'AnyEvent::FTP::Client';
use_ok 'AnyEvent::FTP::Client::Site';
use_ok 'AnyEvent::FTP::Client::Site::Base';
use_ok 'AnyEvent::FTP::Client::Site::Proftpd';
use_ok 'AnyEvent::FTP::Client::Site::Microsoft';
use_ok 'AnyEvent::FTP::Client::Site::NetFtpServer';
use_ok 'AnyEvent::FTP::Client::Role::FetchTransfer';
use_ok 'AnyEvent::FTP::Client::Role::StoreTransfer';
use_ok 'AnyEvent::FTP::Client::Role::ListTransfer';
use_ok 'AnyEvent::FTP::Client::Role::RequestBuffer';
use_ok 'AnyEvent::FTP::Client::Role::ResponseBuffer';
use_ok 'AnyEvent::FTP::Client::Transfer';
use_ok 'AnyEvent::FTP::Client::Transfer::Passive';
use_ok 'AnyEvent::FTP::Client::Transfer::Active';
use_ok 'AnyEvent::FTP::Client::Response';
use_ok 'AnyEvent::FTP::Role::Event';
use_ok 'AnyEvent::FTP::Response';
use_ok 'AnyEvent::FTP::Request';
use_ok 'AnyEvent::FTP::Server';
use_ok 'AnyEvent::FTP::Server::Role::Auth';
use_ok 'AnyEvent::FTP::Server::Role::Context';
use_ok 'AnyEvent::FTP::Server::Role::Help';
use_ok 'AnyEvent::FTP::Server::Role::Old';
use_ok 'AnyEvent::FTP::Server::Role::Type';
use_ok 'AnyEvent::FTP::Server::Role::ResponseEncoder';
use_ok 'AnyEvent::FTP::Server::UnambiguousResponseEncoder';
use_ok 'AnyEvent::FTP::Server::Connection';
use_ok 'AnyEvent::FTP::Server::Context';
use_ok 'AnyEvent::FTP::Server::Context::Full';
use_ok 'AnyEvent::FTP::Server::Context::Memory';
use_ok 'AnyEvent::FTP::Server::OS::UNIX';
use_ok 'Test::AnyEventFTPServer';