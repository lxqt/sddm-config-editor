# INI Parser which supports outputting comments
require 'parslet'

class INIParser < Parslet::Parser
  root :file

  rule(:file) { section.repeat.as(:sections) }

  rule(:section) {
    comment.as(:comment) >>
    open_bracket >> delimited(close_bracket, :name) >> linebreak.repeat >>
    entry.repeat.as(:entries)
  }

  rule(:entry) {
    comment.as(:comment) >>
    delimited(equal, :key, except(open_bracket | pound)) >>
    delimited(linebreak, :value) >>
    linebreak.repeat
  }

  rule(:comment) {
    (pound >> delimited(linebreak, :line)).repeat.as(:lines)
  }

  rule(:linebreak) {
    str("\n")
  }

  rule(:open_bracket) {
    str('[')
  }
  rule(:close_bracket) {
    str(']')
  }
  rule(:equal) {
    str('=')
  }
  rule(:pound) {
    str('#')
  }

  def except(not_element, element=any)
    not_element.absent? >> element
  end

  def delimited(delimiter, as, element=any)
    except(delimiter, element).repeat.as(as) >> delimiter
  end
end

