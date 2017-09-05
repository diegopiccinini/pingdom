module Pingdom

  class Check < Pingdom::Base

    class << self

      def path
        '/checks'
      end

    end

    attr_accessor :id, :created, :name, :hostname, :use_legacy_notifications,
      :resolution, :type, :ipv6, :lasterrortime, :lasttesttime, :lastresponsetime,
      :status, :alert_policy, :alert_policy_name, :acktimeout, :autoresolve, :tags,
      :sendtoemail, :sendtosms, :sendtoiphone, :sendtotwitter, :sendnotificationwhendown,
      :sendtoandroid, :notifyagainevery,:notifywhenbackup, :contactids, :integrationids,
      :probe_filters

    private

      def time_attributes
        %q{created lasttesttime lastresponsetime }
      end

  end
end
