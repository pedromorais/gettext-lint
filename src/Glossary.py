#!/usr/bin/python
# -*- coding: UTF-8 -*-

from xml.dom.ext.reader import Sax2
from xml import xpath

class Glossary:
    def __init__(self, filename):
        f = open(filename,'r')
        self.dict = {}
        
        # create Reader object
        reader = Sax2.Reader()

        # parse the document
        doc = reader.fromStream(f)

        nodes = xpath.Evaluate('word', doc.documentElement)
        for node in nodes:
            key = xpath.Evaluate('original/child::text()',node)
            values = xpath.Evaluate('translation/term/child::text()',node)
            key = key[0].nodeValue
            try:
                a = self.dict[key]
            except KeyError:
                self.dict[key] = []
            for value in values:
                self.dict[key].append(value.nodeValue)

    def __getitem__(self, k):
        return self.dict[k]

    def __setitem__(self, k, x):
        self.dict[k] = x

    def __delitem__(self,k):
        del self.dict[k]

    def __len__(self):
        return len(self.dict)

