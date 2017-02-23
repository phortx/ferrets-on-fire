# Enable `require '_'`

require 'ferrets_on_fire'
require 'ferrets_on_fire/option'
require 'ferrets_on_fire/switch'
require 'ferrets_on_fire/argument'
require 'ferrets_on_fire/command'
require 'ferrets_on_fire/gli_wrapper'

module FoF
  include FerretsOnFire
end

include FoF
