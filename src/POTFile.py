# POT file class
# -*- coding: utf-8 -*-
#
# Pedro Morais <morais@kde.org>
# José Nuno Pires <jncp@netcabo.pt>
# (c) Copyright 2003, 2004
# Distributable under the terms of the GPL - see COPYING

import POFile
import capitalization

class POTFile(POFile.POFile):

    def __init__(self, filename):
        POFile.POFile.__init__(self, filename)
    
    def check(self):
        self.errors = []
        for l, m, i, s, fuzzy in self.data:
            if len(i) == 0: continue
            req = capitalization.requiredCapitalization(i)
            cap = capitalization.capitalization(i)
            if req != capitalization.CAP_UNKNOWN and req != cap:
                self.errors.append((l, 'wrong capitalization - %s' % i))
