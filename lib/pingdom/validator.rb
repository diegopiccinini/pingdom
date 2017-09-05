module Pingdom
  class Validator

    attr :input, :permit, :params

    def validate input: , permit: , params:
      @input=input
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
        [key, value]
      end.to_h
    end

    def valid_time? time
      time.is_a? Time
    end

    def valid_order? order
      ['asc','desc'].include? order
    end

    def valid_resolution? resolution
      %q(hour day week).include? resolution
    end

    def valid_boolean_str? boolstring
      ['true','false'].include? boolstring
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

  end
end
