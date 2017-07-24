import collections
import queue
import sublime
import sublime_plugin
from .Components.KeywordSelector import KeywordSelector
#from .Components.ResultParser import ResultParser
from .Components.SearcheThread import SearcheThread

class FindUsage2Command(sublime_plugin.TextCommand):
    keyword = ''
    def run(self, edit):
        self.keyword = KeywordSelector.execute(self.view)
        self.keyword = 'ReviewRepository' #todo: remove me
        if not self.keyword:
            return

        project_dirs = []
        for folder in sublime.active_window().project_data()["folders"]:
            project_dirs.append(folder["path"])

        self.result_queue = queue.Queue()

        self.search_thread = SearcheThread(project_dirs, self.keyword, self.result_queue)
        self.search_thread.start()
        sublime.set_timeout_async(self.handle_search_results, 1)
    def handle_search_results(self):
        results = [];#collections.OrderedDict();
        while self.search_thread.isAlive() or (self.result_queue.empty() == False):
            sublime.active_window().status_message("Searching project to find " + self.keyword + " usage.")
            if not self.result_queue.empty():
                results.append(self.result_queue.get())
                self.result_queue.task_done()
        if len(results) > 0:
            self.resultParser = ResultParser(sublime.active_window(), self.keyword);
            self.resultParser.parse(results)
        sublime.active_window().status_message('')

class ResultParser():
    def __init__(self, win, keyword):
        self.win = win
        self.keyword = keyword

        view = win.new_file()
        view.set_name("Find Results")
        view.set_scratch(True)
        win.focus_view(view)
        view.settings().set("line_numbers", False)
        view.settings().set("auto_complete_commit_on_tab", False)
        view.settings().set("fade_fold_buttons", True)
        view.settings().set("gutter", True)
        view.settings().set("highlight_line", True)
        view.settings().set("draw_centered", False)
        view.settings().set("word_wrap", True)
        #view.settings().add_on_change("color_scheme", lambda: set_proper_scheme(view))
        #view.substr(view.find_by_selector("variable.matched_count.find-in-files")[0])
        view.set_syntax_file("Packages/Default/Find Results.hidden-tmLanguage")
        self.view = view

    def parse(self, results):
        print(results)
