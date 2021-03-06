require "dotenv/load"
require "pingdom/version"
require "pingdom/client"
require "pingdom/base"
require 'pingdom/check'
require 'pingdom/summary_outage'
require 'pingdom/summary_performance'
require 'pingdom/summary_average'
require 'pingdom/validator'
require 'pingdom/server_time'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/time/acts_like'
require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/slice'
require 'active_support/inflector'

module Pingdom
  # Your code goes here...
end
