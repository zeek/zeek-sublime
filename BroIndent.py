import re
import sublime, sublime_plugin

indent_matcher = re.compile("^[\t]*")
def current_indent(s):
        return len(indent_matcher.match(s).group(0))

def insert_newline_and_indent(edit, view):
	total = len(view.sel())
	for i in range(total):
		idx = view.sel()[i].begin()
		line = view.substr(view.line(view.sel()[i]))
		print line
		indent = current_indent(line)
		indents = "\t" * (indent == 0 and 0 or indent+1)
		view.insert(edit, idx,
			"\n" + indents + "{\n" + indents + "\n" + indents + "}")
		end = view.sel()[i].end()
		winning_region = sublime.Region(end-(indent+3), end-(indent+3))
		sel = view.sel()
		sel.clear()
		sel.add(winning_region)
		view.show(winning_region)

def unindent(edit, view):
	line = view.substr(view.line(view.sel()[0]))
	indent = current_indent(line)
	indent_str = "\t" * (indent == 0 and 0 or indent-1)
	view.insert(edit, view.sel()[0].begin(),"\n" + indent_str)

class BroIndentCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		insert_newline_and_indent(edit, self.view)

class BroUnindentCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		unindent(edit, self.view)

