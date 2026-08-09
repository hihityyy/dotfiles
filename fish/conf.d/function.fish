function y
    set -l query (string join '+' $argv)
    xdg-open "https://www.youtube.com/results?search_query=$query"
end

function s
    set -l query (string join '+' $argv)
    xdg-open "https://duckduckgo.com/h_&q=$query"
end
