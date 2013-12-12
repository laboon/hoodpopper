class HoodpopController < ApplicationController
  require 'ripper'

  # Make a node out of precursor dashes and actual element
  def nodeify(pre, elem)
    elem = "NIL" if elem.nil?
     "#{pre}#{elem}"
  end

  # Turn a nested array into a printed tree
  def treeify(arr, pre)
    arr.map { |elem| (elem.is_a? Array) ? treeify(elem, pre + "-") : nodeify(pre, elem) }
  end

  # Turn an array into a string, with line breaks between
  def stringify(arr)
    arr.map { |s| s.to_s }.join("<br>")
   end

  # Turn a string with line breaks into an array separated by said
  # line breaks
  def arrayify(str)
    str.split("\n")
  end

  # Main method of controller - set @op (operation) and @code
  # (displayed code) variables for corresponding view to use
  def index
    @op = params[:commit]
    orig_code = params[:code][:code].to_s
    case @op
    when 'Tokenize'
      @code = stringify(Ripper.lex(orig_code))
    when 'Parse'
      @code = stringify(Ripper.sexp(orig_code)) + "<p>" + stringify(treeify(Ripper.sexp(orig_code), "").flatten)
    when 'Compile'
      begin
        @code = arrayify(RubyVM::InstructionSequence.compile(orig_code).disasm)
      rescue SyntaxError => e
        @code = ["Could not compile code - Syntax error"]
      end
    end
  end

end
