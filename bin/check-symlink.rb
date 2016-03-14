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
    if config[:critical] && File.exist?(config[:critical])
      critical "#{config[:critical]} exists!"
    elsif config[:warning] && File.exist?(config[:warning])
      warning "#{config[:warning]} exists!"
    elsif config[:unknown] && File.exist?(config[:unknown])
      unknown "#{config[:unknown]} exists!"
    else
      ok 'No test files exist'
    end
  end
end
