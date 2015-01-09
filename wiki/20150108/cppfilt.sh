#!/bin/sh

while read line
do
	line=` echo $line | c++filt \
	    | sed 's/std::basic_string<char, std::char_traits<char>, std::allocator<char> >/string/g' \
	    | sed 's/std::basic_string<wchar_t, std::char_traits<wchar_t>, std::allocator<wchar_t> >/wstring/g' \
	    | sed 's/std::vector<string, std::allocator<string > >/vector<string>/g' \
	    | sed 's/std::vector<wstring, std::allocator<wstring > >/vector<wstring>/g' \
	    | sed -r 's/, std::allocator<[^<>]*>//g' \
	    | sed -r 's/, std::allocator<std::pair<[^<>]*> >//g' \
	    | sed -r 's/, std::less<[^<>]*>//g'  \
	    | sed -r 's/std:://g'   \
	    | sed -r 's/_Rb_tree<[^<>]*, (pair<[^<>]*>), _Select1st<pair<[^<>]*> > >/_Rb_tree<\1 >/g' \
	    | sed -r 's/(_Rb_tree<pair<.*> >::_[a-zA-Z_]*)\([^)]+\)/\1\(\.\.\.\)/g' \
	    | sed -r 's/\s\s+/ /g' `
	if [ -z $1 ] ; then
		t1=`echo $line | sed -r 's/([^(]*\().*/\1/' `
		t2=`echo $line | sed -r 's/[^(]*\((.*)\).*/\1/' `
		t3=`echo $line | sed -r 's/.*(\).*)/\1/' `
		echo -e "$t1\E[32m$t2\E[m$t3"	
	else
		echo $line
	fi
	

done
