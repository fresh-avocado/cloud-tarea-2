from pyspark import SparkContext, SparkConf

conf = SparkConf().setAppName("Movies Word Count").setMaster("local")
sc = SparkContext(conf=conf)

words = sc.textFile(
    '/app/data/movies.csv').flatMap(lambda line: line.split(" "))
word_count = words.map(lambda word: (word.lower(), 1)
                       ).reduceByKey(lambda x, y: x + y)
sorted_word_count_desc = word_count.sortBy(lambda x: x[1], ascending=False)
sorted_word_count_desc.saveAsTextFile('/app/data/spark_output')
