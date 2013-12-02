class HoodpopController < ApplicationController
  require 'ripper'

  def add_html_crs(str)
    str.gsub(/\n/, "<p>")
  end

  def stringify(arr)
     to_return = ""
     arr.each do |elem|
       to_return += elem.to_s + "<p>"
     end
     to_return
   end

  def index
    @op = params[:commit]
    orig_code = params[:code][:code].to_s
    case @op
    when 'Tokenize'
      @code = stringify(Ripper.lex(orig_code))
    when 'Parse'
      @code = Ripper.sexp(orig_code)
    when 'Compile'
      @code = add_html_crs(RubyVM::InstructionSequence.compile(orig_code).disasm)
    end
    puts ">>>> "
    puts @code
  end

end
