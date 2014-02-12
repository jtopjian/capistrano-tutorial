include apache
create_resources(apache::vhost, hiera('sites'))

vcsrepo { '/var/www/example.com':
  ensure   => present,
  provider => git,
  source   => 'some.private.site.com',
}
