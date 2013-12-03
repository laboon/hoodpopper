class HoodpopController < ApplicationController
  require 'ripper'

  def nodeify(pre, elem)
    elem = "NIL" if elem.nil?
     "#{pre}#{elem}"
  end

  def treeify(arr, pre)
    arr.map { |elem| (elem.is_a? Array) ? treeify(elem, pre + "-") : nodeify(pre, elem) }
  end

  def add_html_crs(str)
    str.gsub(/\n/, "<br>")
  end

  def stringify(arr)
     to_return = ""
     arr.each do |elem|
       to_return += elem.to_s + "<br>"
     end
     to_return
   end

  def arrayify(str)
    str.split("\n")
  end

  def index
    @op = params[:commit]
    orig_code = params[:code][:code].to_s
    case @op
    when 'Tokenize'
      @code = stringify(Ripper.lex(orig_code))
    when 'Parse'
      @code = stringify(Ripper.sexp(orig_code)) + "<p>" + stringify(treeify(Ripper.sexp(orig_code), "").flatten)
    when 'Compile'
      @code = arrayify(RubyVM::InstructionSequence.compile(orig_code).disasm)
    end
  end

end
