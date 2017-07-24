class KeywordSelector:
    def execute(view):
        keyword = ''
        for region in view.sel():
            word = view.word(region) if region.begin() == region.end() else region
            if not word.empty():
                keyword = view.substr(word)
        return keyword if keyword.isalnum() else ''
