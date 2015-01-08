#!/bin/sh 
while read line
do
    echo $line | c++filt
        | sed 's/std::basic_string<char, std::char_traits<char>, std::allocator<char> >/string/g' \ 
        | sed 's/std::basic_string<wchar_t, std::char_traits<wchar_t>, std::allocator<wchar_t> >/wstring/g'  \
        | sed 's/std::vector<string, std::allocator<string > >/vector<string>/g' \
        | sed 's/std::vector<wstring, std::allocator<wstring > >/vector<wstring>/g' \
        | sed -r 's/, std::allocator<[^<>]*>//g' \
        | sed -r 's/, std::less<[^<>]*>//g' \ 
        | sed -r 's/std:://g'  \
        | sed -r 's/\\s\\s+/ /g'
done 