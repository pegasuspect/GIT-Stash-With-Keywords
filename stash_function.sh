stash() {
    if ! [[ -d '.git' ]]; then
        echo Not a git repository.
        return 1;
    fi
    
    local stash_index=""
    local operation=$1
    local key=$2
    shift; shift;
    
    setStashIndex(){
        stash_index=$(git stash list | \grep "$1" | head -1 | cut -d: -f1 | tr -d ' ')
    }
    print_header(){
        if [[ -n "$stash_index" ]]; then
            stash_cut $1
            stash_cut $1 | tr -C "*" "-"
            echo
            git stash show $stash_index $2
        else
            echo "No stash with key: $1(case sensitive)"
        fi
    }
    stash_cut(){
        if [[ -z "$1" ]]; then
            local branchName=$(git branch | awk -F' ' '/\*/ {print $2}')
            git stash list | awk -F': |On |WIP on ' '{sub(/'$branchName'/, g"&"n); $1=""; $2=""; print y $3 n ": "$4;}'
        else
            git stash list | awk -F': |On |WIP on ' '/'$1'/ {gsub(/'$1'/, r"&"n); print $3": "$4; exit}'
        fi
    }

    if [[ -n $key ]]; then
        setStashIndex $key
        
        if [[ $operation = "+=" && -n "$@" ]]; then
            git stash push -m "$key" $@
        elif [[ $operation = "+=" ]]; then
            git stash push -m "$key"
        elif [[ $operation = "-=" ]]; then
            git stash pop $stash_index
        elif [[ $operation = "list" ]]; then
            print_header $key
        elif [[ $operation = "drop" ]]; then
            git stash drop $stash_index
        elif [[ $operation = "show" ]]; then
            print_header $key '-p'
        fi
    elif [[ $operation = "list" ]]; then
        local list=$(stash_cut);
        if [[ -z $list ]]; then
            echo "Nothing is stashed. Your stash is empty!";
            return 1
        fi
        stash_cut;
    else
      echo 'NAME'
      echo '  stash - Use Git Stash with keywords instead of indexes!'
      echo ''
      echo 'SYNOPSIS'
      echo '  stash [+= <partOfTheKey> [<pathspec>...]]'
      echo '    [-= <partOfTheKey>]'
      echo '    [list [<partOfTheKey>]]'
      echo '    [drop [<partOfTheKey>]]'
      echo ''
      echo 'DESCRIPTION'
      echo '  Git stash is a commandline tool comes built in with git. This function builds on top of the functionality git-stash provides. With git stash, the changes that are stashed or shelved goes into indexes. I prefer naming my stashes hence this function exists.'
      echo ''
      echo 'OPTIONS'
      echo '  Square brackets around the option word means it is optional. If the option is in between <> it is required. Options can start with +=, -= or a word. Many of the options require an additional value next to them. +=, -= and drop oprions are used to manipulate stash. These can result in moving your working directory changes to/from stash or deleting stashed changes!'
      echo ''
      echo '  [help]'
      echo '    You are looking at it.'
      echo ''
      echo '  list'
      echo '    List the stash.'
      echo ''
      echo '  list|show <part-of-the-keyword>'
      echo '    List/Diff what changes extracting a stash will make.'
      echo ''
      echo '  += <partOfTheKey>'
      echo '    To stash your all of your changes (including unstaged).'
      echo ''
      echo '  += <partOfTheKey> [<pathspec>...]'
      echo '    To stash spesific file(s) with stash.'
      echo ''
      echo '  -= <partOfTheKey>'
      echo '    Extract a stash and remove it from the list.'
      echo ''
      echo '  drop <part-of-the-keyword>'
      echo '    Delete the stash with the matching keyword.'
      echo ''
      echo 'EXAMPLES'
      echo '$ stash list'
      echo 'master: style changes'
      echo '$ stash list style'
      echo 'master: style changes'
      echo '--------------------------'
      echo ' style.css | 147 ++++++++++++++++++++++++++++++++++++++++++++---------------'
      echo ' 1 file changed, 111 insertions(+), 36 deletions(-)'
      echo '$ stash -= style'
    fi
    
    unset -f stash_cut
    unset -f setStashIndex
    unset -f print_header
}
complete -W "-= += list drop show help" stash
export -f stash