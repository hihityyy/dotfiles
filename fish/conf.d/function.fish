function y
    set -l query (string join '+' $argv)
    xdg-open "https://www.youtube.com/results?search_query=$query" && exit
end
