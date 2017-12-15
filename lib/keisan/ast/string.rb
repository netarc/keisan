module Keisan
  module AST
    class String < ConstantLiteral
      attr_reader :content

      def initialize(content)
        @content = content
      end

      def value(context = nil)
        content
      end

      def +(other)
        case other
        when String
          String.new(value + other.value)
        else
          raise Exceptions::TypeError.new("#{other}'s type is invalid, #{other.class}")
        end
      end

      def to_s
        if value =~ /\"/
          "\"#{value.gsub("\"", "\\\"")}\""
        else
          "\"#{value}\""
        end
      end
    end
  end
end
