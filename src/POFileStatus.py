#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import popen
from Config import *
from FileStatus import *

class POFileStatus(FileStatus):
    
    def __init__(self, config, filename):
        FileStatus.__init__(self, config, filename)

    def run(self):
        command = None
        self.error = None
        if self.getConfig() is not None:
            command = self.getConfig().getStatsCommand(self.getFilename())
        else:
            return 0
        
        output = popen(command).read()
        self.setTranslated(self.__extract(output, " translated"))

        #if self.getTranslated() == None: self.error = output
        self.setFuzzy(self.__extract(output, " fuzzy"))
        self.setUntranslated(self.__extract(output, " untranslated"))
        return self.error == None
    
    def __extract(self, output, token):
        end = output.find(token)
        if end == -1: return None
        start = output.rfind(" ", 0, end) + 1
        return int(output[start:end])

    def fully_translated(self):
        return self.translated and not(self.fuzzy) and not(self.untranslated)

if __name__ == '__main__':
    from sys import argv
    if len(argv) > 2:
        config = Config(argv[1])
        
        for i in argv[2:]:
            x = POFileStatus(config, i)
            status = x.run()
            if status:
                if not x.isFullyTranslated():
                    print '%s: %.2f%%' % (i, x.getRatio() * 100)
            else:
                print '%s: error "%s"' % (i, x.error)
