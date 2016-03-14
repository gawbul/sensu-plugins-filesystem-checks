#!/usr/bin/env ruby
#
#   check-symlink
#
# DESCRIPTION:
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux, BSD
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright 2013 Mike Skovgaard <mikesk@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/check/cli'

class CheckFileExists < Sensu::Plugin::Check::CLI
  option :target,
         short: '-t TARGET',
         required: true

  option :linkname,
         short: '-l LINK_NAME',
         required: true

  def run
    critical "Linkname #{config[:linkname]} doesn't exist" unless File.exist?(config[:linkname])
    critical "Linkname #{config[:linkname]} isn't a symlink" unless File.symlink?(config[:linkname])
    critical "Linkname #{config[:linkname]} doesn't match #{config[:target]} (#{File.readlink(config[:linkname])})" unless File.readlink(config[:linkname]) == config[:target]
    ok "Linkname #{config[:linkname]} matches #{config[:target]}"
  end
end
