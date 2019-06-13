let g:template = "%s vs %s\n\n".
               \ "------\n".
               \ "Status\n".
               \ "------\n\n".
               \ "%s\n\n".
               \ "-----\n".
               \ "Score\n".
               \ "-----\n\n".
               \ "%s\n\n".
               \ "----------------------------\n".
               \ "Last 3 Overs (Right to Left)\n".
               \ "----------------------------\n\n".
               \ "%s\n\n".
               \ "----------\n".
               \ "Commentary\n".
               \ "----------\n\n".
               \ "%s"

" Fetches score of the match set as `g:match_id`
function! GetScore()
    let res = system(printf("curl -s https://www.cricbuzz.com/match-api/%s/commentary.json", g:match_id))
    let obj = json_decode(res)

    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified

    let commentary = []
    let count = 0
    if has_key(obj, "comm_lines")
        for line in obj["comm_lines"]
            if has_key(line, "comm")
                call add(commentary, line["comm"])
                let count = count + 1
                if count >= 5
                    break
                endif
            endif
        endfor
    endif

    let commentary_str = join(commentary, "\n\n")
    let commentary_str = substitute(commentary_str, "<[^>]*>", "", "g")

    let board=printf(g:template, obj["team1"]["name"], obj["team2"]["name"],
                               \ obj["status"], obj["score"]["batting"]["score"],
                               \ obj["score"]["prev_overs"], commentary_str)
    silent put=board
    :%!fold -w 120
endfunction

" Fetches a list of live matches
function! GetMatches()
    let res = system("curl -s https://www.cricbuzz.com/api/html/homepage-scag")
    let pattern = "\"/live-cricket-scores/.*/.*\""
    let result_list = map(split(res),"matchstr(v:val, pattern)")
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified

    for match_id in result_list
        if match_id != ""
            let idx = matchstr(match_id, "[0-9]{5}")
            silent put=match_id
        endif
    endfor
endfunction

" Fetches a list of live matches
function! GetMatchesFZF()
    let response = system("curl -s https://www.cricbuzz.com/api/html/homepage-scag")
    let pattern = "\"/live-cricket-scores/.*/.*\""
    let result_list = map(split(response),"matchstr(v:val, pattern)")
    let matches = []

    for match_url in result_list
        if match_url != ""
            let split_list = split(match_url, "/")
            let match_string = split_list[3][:-2]
            let match_id = split_list[2]
            let match_url_str = match_id . " " . join(split(match_string, "-"), " ")
            call add(matches, match_url_str)
        endif
    endfor
    let unduplist = filter(copy(matches), "index(matches, v:val, v:key+1)==-1")
    return unduplist
endfunction

" FZF sink function
function! GetScoreFZF(e)
    " TODO: Fix this regex pattern: `[0-9]{5}` not working
    let pattern = "[0-9][0-9][0-9][0-9][0-9]"
    let match_ = matchstr(a:e, pattern)
    let g:match_id = match_
    call GetScore()
endfunction

" Opens the match set as `g:match_id` in browser
function! ShowMatchInBrowser()
    let s:uri = printf("https://www.cricbuzz.com/live-cricket-scores/%s", g:match_id)
    silent exec "!open '".s:uri."'"
endfunction

command! -nargs=0 GetScore call GetScore()
command! -nargs=0 ShowMatchInBrowser call ShowMatchInBrowser()
command! -nargs=0 GetMatches call GetMatches()
command! -nargs=0 GetMatchesFZF call GetMatchesFZF()
