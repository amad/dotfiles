import collections
import glob
import os
import queue
import re
import time
import sublime
import sublime_plugin

class FindUsageCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        win = sublime.active_window()
        view = win.active_view()

        keyword = ''
        for region in self.view.sel():
            if region.begin() == region.end():
                word = self.view.word(region)
            else:
                word = region
            if not word.empty():
                keyword = self.view.substr(word)

        if keyword == '' or re.search("\w", keyword) == None:
            return

        self._target_string = keyword
        pattern = '(new|use|extends|class).*(\\'+'\\|\s|\()'+keyword+'(\(|\)|;|$)|'+keyword+'(::| \$)';

        project_data = win.project_data()

        project_dirs = []
        for folder in project_data["folders"]:
            project_dirs.append(folder["path"])

        self.result_queue = queue.Queue()

        for path in project_dirs:
            for root, dirs, files in os.walk(path, followlinks=True):
                dirs[:] = [d for d in dirs if d.lower() not in []]
                for file in files:
                    ret = collections.OrderedDict()
                    file_ext = os.path.splitext(file)[1][1:]
                    if file_ext.lower() not in ['php', 'js']:
                        continue
                    filepath = os.path.join(root, file)
                    file_size = os.path.getsize(filepath)
                    #with open(filepath, 'r', encoding='utf-8') as fo:
                    with open(filepath, 'r', encoding='latin-1') as fo:
                        for line_num, line_content in enumerate(fo, start=1):
                            if re.search(pattern, line_content):
                                ret[line_num] = self._limit_line(line_content)
                    if len(ret) > 0:
                        self.result_queue.put({"filepath": filepath, "result": ret, "files_searched": files})
                                #ret[filepath.replace(path+'/', '')] = line_num
        # Init member vars for new search
        # self.result_queue = queue.Queue()
        self.num_hits = 0
        self.num_file_hits = 0
        self.last_status_update = 0
        self.search_cancelled = False
        self.files_searched = 0
        self.search_start_time = time.time()

        # Search all project dirs
        project_dirs = []
        for folder in project_data["folders"]:
            project_dirs.append(folder["path"])

        # Initialize result buffer/view
        self.result_buffer = ResultBuffer(win, keyword)
        self.handle_search_results()
        # class Address
        return

    def handle_search_results(self):
        while (self.result_queue.empty() == False):
            if not self.result_queue.empty():
                result = self.result_queue.get()

                if "result" in result and len(result["result"]):
                    if 0 not in result["result"]:
                        self.num_hits = self.num_hits + len(result["result"])
                        self.num_file_hits = self.num_file_hits + 1

                # Update number of files searched
                if "files_searched" in result:
                    self.files_searched = result["files_searched"]

                # If we reach excessive limit start dropping results and stop search thread
                # if (self.excessive_hits_count != 0) and (self.num_hits > self.excessive_hits_count):
                #     self.search_thread.stop()
                #     self.search_cancelled = True
                #     break

                # Update result view
                if "result" in result:
                    self.result_buffer.insert_result(result)

                self.result_queue.task_done()

    def _limit_line(self, line):
        single_side_len = int(80/2)
        loc = line.lower().find(self._target_string)

        start = loc - single_side_len
        if start < 0:
            start = 0

        end = loc + len(self._target_string)
        end = end + single_side_len
        if (end >= len(line)):
            end = len(line)-1

        limited_line = ""
        if start != 0:
            limited_line = limited_line + "[…]"

        limited_line = limited_line + line[start:end]
        if end != len(line)-1:
            limited_line = limited_line + "[…]"

        return limited_line

class ResultBuffer:
    """
    A result buffer for search results.
    """
    def __init__(self, win, target_string):
        self.win = win
        self.target_string = target_string

        # Get new view
        view = self.win.new_file()

        # Configure view
        view.set_name("Found in project")
        view.set_scratch(True)
        self.win.focus_view(view)

        view.settings().set('line_numbers', False)
        view.settings().set("auto_complete_commit_on_tab", False)
        view.settings().set("fade_fold_buttons", True)
        view.settings().set("gutter", True)
        view.settings().set("highlight_line", True)
        view.settings().set("draw_centered", False)
        view.settings().set("word_wrap", False)
        view.settings().add_on_change('color_scheme', lambda: set_proper_scheme(view))
        view.set_syntax_file('Packages/User/FindInProject.sublime-syntax')

        # Save view for later
        self.view = view

    def insert_result(self, result):
        """
        Insert results for a file into the buffer.
        """
        if len(result) == 0:
            return

        # Add file name to start of result block
        no_results = str(len(result["result"]))
        result_str = ("\n" + result["filepath"] + " (" + no_results + ")\n")

        # For each result in file add an indented line
        for line in result["result"].keys():
            result_str += (str(line).rjust(6) + ": " + result["result"][line])
            if result_str[-1] != "\n":
                result_str += "\n"

        self.view.run_command("find_in_project_insert_text",
                                     {"args": {'text': result_str, 'target_string': self.target_string}})

    def is_closed(self):
        """
        Check if the result buffer was closed by the user.
        """
        open_views = self.win.views()
        for view in open_views:
            if view.id() == self.view.id():
                return False
        return True


def set_proper_scheme(view):
    """
    Set color scheme for result view
    """
    # Check if user color scheme exists
    color_scheme = "Packages/User/FindInProject.hidden-tmTheme"
    try:
        sublime.load_resource("Packages/User/FindInProject.hidden-tmTheme")
        color_scheme = "Packages/User/FindInProject.hidden-tmTheme"
    except:
        pass

    if view.settings().get('color_scheme') != color_scheme:
        view.settings().set('color_scheme', color_scheme)


class FindInProjectCommand:
    """
    Utility functions for find in project commands. Intended to be used with
    sublime_plugin.TextCommand class.
    """
    def selection_is_empty_line(self):
        """
        Check if selection is an empty line
        """
        scope = self.view.scope_name(self.view.sel()[0].begin())
        if "findinproject.emptyline" in scope:
            return True
        return False

    def get_point_at_start_of_selection(self):
        """
        Get the point at the start of the line
        """
        (row, col) = self.view.rowcol(self.view.sel()[0].begin())
        return self.view.text_point(row, 0)

    def point_is_file(self, point):
        """
        Check if provided point is on a filename
        """
        scope = self.view.scope_name(point)
        if "findinproject.filename" in scope:
            return True
        return False

    def get_filename_from_point(self, point):
        if self.point_is_file(point) == False:
            return ""

        fileline = self.view.line(point)
        filenameraw = self.view.substr(fileline)
        filenameend = filenameraw.rfind('(')
        return filenameraw[:filenameend].rstrip()


    def point_is_empty_line(self, point):
        """
        Check if provided point is on an empty line
        """
        scope = self.view.scope_name(point)
        if "findinproject.emptyline" in scope:
            return True
        return False


class FindInProjectInsertText(FindInProjectCommand, sublime_plugin.TextCommand):
    """
    Insert a blob of text in the view and add regions for all occurences of the
    target string using the 'findinproject.targetstring' scope.
    """
    def __init__(self, args):
        super().__init__(args)
        self.region_key_postfix_counter = 1

    def run(self, edit, args):
        start_view_size = self.view.size()
        moveCursor = False
        if start_view_size == 0:
            moveCursor = True

        self.view.set_read_only(False)
        self.view.insert(edit, start_view_size, args['text'])
        self.view.set_read_only(True)

        if moveCursor:
            self.view.run_command("goto_line", {"line": 2})

        self._highlight_target_string(args['target_string'], start_view_size)

    def _highlight_target_string(self, target_string, start_point):
        """
        High target string
        """
        # Start by going down two rows so we do not highlight target strings
        # in filenames
        (row, col) = self.view.rowcol(start_point)
        start_point = self.view.text_point(row+2, 0)

        target_regions = []
        while True:
            target_region = self.view.find(target_string, start_point, sublime.LITERAL | sublime.IGNORECASE)
            if target_region is None or target_region.empty():
                break

            target_regions.append(target_region)
            start_point = target_region.end()

        key = "FindInProjectHighlight%i" % (self.region_key_postfix_counter, )
        self.region_key_postfix_counter = self.region_key_postfix_counter + 1
        # flags = sublime.DRAW_NO_OUTLINE
        flags = sublime.DRAW_NO_FILL
        self.view.add_regions(key, target_regions, "findinproject.targetstring", flags=flags)


class FindInProjectNextLine(FindInProjectCommand, sublime_plugin.TextCommand):
    """
    Go up or down a line in the result view but skip empty lines.
    """
    def run(self, edit, forward=True):
        self.view.run_command("move", {"by": "lines", "forward": forward})
        if self.selection_is_empty_line():
            self.view.run_command("move", {"by": "lines", "forward": forward})

        # Always set cursor to col 0 to avoid highlighting issues with folding
        (row, col) = self.view.rowcol(self.view.sel()[0].begin())
        target = self.view.text_point(row, 0)
        reg = sublime.Region(target)
        self.view.sel().clear()
        self.view.sel().add(reg)
        self.view.show(target)


class FindInProjectNextFile(FindInProjectCommand, sublime_plugin.TextCommand):
    """
    Go up/down to next/previous file.
    """
    def run(self, edit, forward=True):
        # Move a step in requested direction
        self.view.run_command("move", {"by": "lines", "forward": forward})
        point = self.get_point_at_start_of_selection()

        while self.point_is_file(point) == False:
            prev_point = point
            self.view.run_command("move", {"by": "lines", "forward": forward})
            point = self.get_point_at_start_of_selection()
            if point == prev_point:
                # We are stuck at BOF or EOF
                return


class FindInProjectOpenResult(FindInProjectCommand, sublime_plugin.TextCommand):
    """
    Open search result marked by the cursor.
    """
    def run(self, edit):
        (row, col) = self.view.rowcol(self.view.sel()[0].begin())

        # If cursor is standing on a filename line
        point = self.view.text_point(row, 0)
        if self.point_is_file(point):
            filename = self.get_filename_from_point(point)
            self.view.window().open_file(filename)
            return

        # Go upwards and find filename
        while row is not 0:
            filepoint = self.view.text_point(row, 0)
            if self.point_is_file(filepoint):
                break
            row = row - 1

        if row is 0:
            return

        filename = self.get_filename_from_point(filepoint)
        linecontent = self.view.substr(self.view.line(point))
        lineNo = linecontent.split(':')[0]
        lineNo = lineNo.strip()

        self.view.window().open_file(filename+":"+lineNo, sublime.ENCODED_POSITION)


class FindInProjectFold(FindInProjectCommand, sublime_plugin.TextCommand):
    """
    Fold/Unfold results for currently selected file.
    """
    def run(self, edit, fold=True):
        # Get active line
        (row, col) = self.view.rowcol(self.view.sel()[0].begin())
        if row < 1:
            return

        # Go upwards and find filename
        point = self.view.text_point(row, 0)
        while self.point_is_file(point) == False:
            row = row - 1
            if row is 0:
                # Could not find filename - buffer must be corrupt or something
                return
            point = self.view.text_point(row, 0)

        file_row = row
        file_line_region = self.view.line(point)
        file_line_end = file_line_region.end()

        # Go downwards and find end of file results
        while self.point_is_empty_line(point) == False:
            prev_point = point
            row = row + 1
            point = self.view.text_point(row, 0)
            if point == prev_point:
                # We reached EOF - fold until here
                break

        # Get region starting from the end of the filename line and ending at
        # the end of the last result line for that file
        folding_region = sublime.Region(file_line_end, point-1)
        if fold:
            self.view.fold(folding_region)
        else:
            self.view.unfold(folding_region)

        # Move selection to filename if we folded
        if fold:
            reg = sublime.Region(self.view.text_point(file_row, 0))
            self.view.sel().clear()
        self.view.sel().add(reg)
