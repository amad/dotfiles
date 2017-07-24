import collections
import os
import re
import threading

class SearcheThread(threading.Thread):
    def __init__(self, paths, keyword, result_queue):
        super().__init__()
        self._stop_thread = threading.Event()
        self._paths = paths
        self._keyword = keyword
        self._result_queue = result_queue
        pattern = "(new|use|extends|implements|class).*(\\\\|\s|\()KEYWORD(\(|\)|;|$)|KEYWORD(::| \$)|(:|>)KEYWORD\("
        self._query = pattern.replace("KEYWORD", keyword);

    def run(self):
        for path in self._paths:
            for root, dirs, files in os.walk(path, followlinks=True):
                dirs[:] = [d for d in dirs if d.lower() not in []]
                for file in files:
                    if self._stop_thread.wait(0):
                        return
                    result = collections.OrderedDict()
                    file_ext = os.path.splitext(file)[1][1:]
                    if file_ext.lower() not in ["php"]:
                        continue
                    filepath = os.path.join(root, file)
                    with open(filepath, "r", encoding="latin-1") as fo:
                        for line_num, line_content in enumerate(fo, start=1):
                            if re.search(self._query, line_content):
                                result[line_num] = line_content
                    if len(result) > 0:
                        self._result_queue.put({"filepath": filepath, "result": result, "files_searched": files})
        self._result_queue.join()
        self.stop()

    def stop(self):
        self._stop_thread.set()

    # def _should_continue(self):
    #     return not self._stop_thread.wait(0)
