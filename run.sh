function test {
	gcc -Wall -Wextra -Werror -D BUFFER_SIZE=$1 -I. get_next_line.c get_next_line_utils.c test.c -o get_next_line
	./get_next_line < tests/simple > output

	DIFF=$(diff expected output)
	if [ "$DIFF" != "" ]
	then
		echo -e "\033[0mBUFFER_SIZE =\033[0;31m $1 KO"
		#exit
	else
		echo -e "\033[0mBUFFER_SIZE =\033[0;32m $1 OK"
	fi
}

for i in {1..128}
do
	test "$i"
done

for i in 256 512 1024 4096
do
	test "$i"
done

rm -f get_next_line
rm -f output
