function! GetScore()
    let res = system(printf('curl -s https://www.cricbuzz.com/match-api/%s/commentary.json', g:match_id))
    let obj = json_decode(res)

    echo obj['status']
    echo obj['score']['batting']['score']
endfunction


function! ShowMatch()
    let s:uri = printf("https://www.cricbuzz.com/live-cricket-scores/%s", g:match_id)
    silent exec "!open '".s:uri."'"
endfunction

command! -nargs=0 GetScore call GetScore()
command! -nargs=0 ShowMatch call ShowMatch()
