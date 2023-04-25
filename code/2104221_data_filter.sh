a=$1 #storing positional argument 
file="${a:0:2}_$2_$3.csv" #file name to be saved in
a=`head -n 1 us_500.csv | tr "," " " | grep "city"` #splitting the first line to create a list
j=1 #initializing pointer to find positional argument
c=\"${2}\" #escaping quotes for comparison
d=\"${3}\"

#finding position of argument 2 in first header
for i in $a
do
	if [ $i == $c  ]; then 
		break
	fi
	((j=j+1))
done

#adding regex according to position
fd=""
for ((i=0; i<j; i++))
do
	fd="${fd}.*,"
done

#final regex
fd="${fd}$d,.*"

#storing the number of lines
b=`cat $1 | grep -w  "$fd" | wc -l`

#adding the first line to csv
echo "$1,$2,$3,$b" > $file

#adding headers of columns
cat $1 | head -n 1 >> $file

#using regex to find exact lines
cat $1 | grep -w $fd >> $file

