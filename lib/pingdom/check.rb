require 'json'

module Pingdom

  class Check < Pingdom::Base

    class << self

      def path
        '/checks'
      end

    end

  end
end
