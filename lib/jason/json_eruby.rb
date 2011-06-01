require 'erubis'

module Jason
  class JSONEruby < Erubis::Eruby
    def add_expr(src, code, indicator)
      case indicator
      when '='
        add_expr_literal(src, "(#{code}).to_json")
      when '=='
        add_expr_literal(src, code)
      end
    end
  end
end