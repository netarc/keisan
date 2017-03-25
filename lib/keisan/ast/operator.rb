module Keisan
  module AST
    class Operator < Parent
      def initialize(children = [], parsing_operators = [])
        unless children.count == parsing_operators.count + 1
          raise Keisan::Exceptions::ASTError.new("Mismatch of children and operators")
        end

        unless arity.include?(children.count)
          raise Keisan::Exceptions::ASTError.new("Invalid number of arguments")
        end

        children = Array.wrap(children)
        super(children)

        @parsing_operators = parsing_operators
      end


      def arity
        raise Keisan::Exceptions::NotImplementedError.new
      end

      def associativity
        raise Keisan::Exceptions::NotImplementedError.new
      end

      def symbol
        raise Keisan::Exceptions::NotImplementedError.new
      end

      def blank_value
        raise Keisan::Exceptions::NotImplementedError.new
      end

      def value(context = nil)
        args = children
        args = args.reverse if associativity == :right

        args.inject(blank_value) do |result, child|
          if associativity == :left
            result.send(symbol, child.value(context))
          else
            child.value(context).send(symbol, result)
          end
        end
      end
    end
  end
end