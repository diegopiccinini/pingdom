module Pingdom
  class Validator

    attr :input, :permit, :params

    def validate input: , permit: , params:
      @input= input.first || {}
      @permit=permit
      @params=params

      params.merge(format)
    end

    private

    def filter
      input.select do |k,v|
        permit.keys.include?k and !v.nil?
      end
    end

    def validate_all
      filter.each_pair do |key, value|
        raise "'#{key}' param with value: '#{value}', cannot pass the '#{permit[key]}' validation" unless send(permit[key], value)
      end
    end

    def format
      validate_all.each_pair.map do |key, value|
        value=value.to_i if permit[key]==:valid_time?
        value=value.to_s if permit[key]==:valid_boolean?
        [key, value]
      end.to_h
    end

    def valid_time? time
      time.is_a? Time
    end

    def valid_positive_int? value
      value.is_a? Integer and value>=0
    end

    def valid_order? order
      ['asc','desc'].include? order
    end

    def valid_resolution? resolution
      %q(hour day week).include? resolution
    end

    def valid_boolean? bool
      bool.is_a?(TrueClass) || bool.is_a?(FalseClass)
    end

    def valid_int_list? int_list

      list=int_list.split(',')
      raise 'Not valid list' if list.empty?

      list.each do |i|
        raise "Not valid Integer" if Integer(i)!=i.to_i
      end

      true
    rescue
      false
    end

    def valid_str_list? str_list

      list=str_list.split(',')
      raise 'Not valid list' if list.empty? || str_list.count(' ')>0

      true
    rescue
      false
    end

  end
end
