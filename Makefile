output.txt : output
	hadoop dfs -cat output/part-* > output.txt
	echo 'Result of script ran on input:'
	cat output.txt

output : wordcount.jar input
	hadoop jar wordcount.jar org.myorg.WordCount ./input output

wordcount.jar : wordcount_classes
	jar -cvf wordcount.jar -C wordcount_classes/ .

wordcount_classes : WordCount.java
	mkdir wordcount_classes
	javac -classpath /usr/lib/hadoop/client/hadoop-common-2.6.0-cdh5.7.0.jar:/usr/lib/hadoop/client/hadoop-mapreduce-client-core.jar -d wordcount_classes WordCount.java

clean:
	rm -R wordcount_classes
	rm wordcount.jar
	rm output.txt
	#hdfs dfs -rm -r hdfs://fladoop/user/yikeliu/output
	hadoop fs -rm -r output
