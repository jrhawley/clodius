import sys

sys.path.append("scripts")

import fpark as fp

def test_map():
    a = fp.FakeSparkContext.parallelize([1,2,3,4])

    b = a.map(lambda x: x+1)
    assert(b.collect()[0] == 2)

def test_group_by_key():
    a = fp.FakeSparkContext.parallelize([(1,2),(1,3),(1,4),(2,5),(2,6)])

    b = a.groupByKey()

    print "b.data:", b.data

def test_textFile():
    a = fp.FakeSparkContext.textFile('test/data/piecewise-file/part-00000')
    parts = a.collect()
    assert(len(parts) == 2)
    print "parts:", parts

    a = fp.FakeSparkContext.textFile('test/data/piecewise-file/')
    parts = a.collect()
    assert(len(parts) == 4)
    print "parts:", parts
