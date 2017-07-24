import os
import sublime

class ResultParser():
    def parse(result):
        win = sublime.active_window()
        view = win.new_file()

        view.set_name("Find Results")
        view.set_scratch(True)
        win.focus_view(view)
