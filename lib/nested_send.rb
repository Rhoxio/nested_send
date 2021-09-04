module NestedSend
  class Checker
    def self.kind_of_collection(attribute)
      return :sym_hash if is_symbolized_hash?(attribute)
      return :str_hash if is_complete_string?(attribute)
      return :array if is_stringified_array?(attribute)
      return false
    end

    def self.kind_of_attribute(kind)
      return :method if kind == '.'
      return :collection if kind == '['
    end

    def self.is_symbolized_hash?(attribute)
      return attribute[0] == ':'
    end

    def self.is_string_hash?(attribute)
      strings = ["'", '"']
      strings.include?(attribute[0]) && strings.include?(attribute[-1])
    end

    def self.is_stringified_array?(attribute)
      return attribute.to_i.to_s == attribute
    end

    def self.is_complete_string?(attribute)
      start_char = attribute[0]
      end_char = attribute[-1]
      does_match = (start_char == end_char)
      return does_match if is_string_hash?(attribute)
      return false
    end
  end
end

Object.class_eval do 

  def nested_send(attribute, with_indifferent_access: false)

    checker = NestedSend::Checker

    matches = /([^\.\[\]]+)(.*)/.match(attribute)
    attribute = matches.captures[0]
    object = send(attribute)

    until matches.captures[1].empty?

      next_part = matches.captures[1]
      kind = checker.kind_of_attribute(next_part.slice!(0))

      if kind == :method

        matches = /([^\.\[\]]+)(.*)/.match(next_part)
        attribute = matches.captures[0]
        object = object.send(attribute)

      elsif kind == :collection

        matches = /(['|"|:]*[^\]]+['|"]*)\](.*)/.match(next_part)
        attribute = matches.captures[0]

        type = checker.kind_of_collection(attribute)
        raise ArgumentError, "Provided attribute was unable to be parsed: #{attribute}" unless type

        if type == :sym_hash
          attribute.slice!(0)
          attribute = attribute.to_sym
        elsif type == :str_hash
          attribute.slice!(0)
          attribute.chop!
        elsif type == :array
          attribute = attribute.to_i
        end

        if with_indifferent_access && object.is_a?(Hash)
          object = object.with_indifferent_access
        end

        object = object[attribute]

      else
        raise ArgumentError, "Could not parse attribute: #{attribute}"
      end

    end

    object
  end
end