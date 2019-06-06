stash() {
    stash_cut(){
        git stash list | cut -d: -f2,3
    }
    if [[ ! -d '.git' ]]; then
        echo Not a git repository.
    elif [[ $1 = "+=" && ! -z $2 && ! -z $3 ]]; then
        git stash push -m $2 $3
    elif [[ $1 = "+=" && ! -z $2 ]]; then
        git stash push -m "$2"
    elif [[ $1 = "-=" && ! -z $2 ]]; then
        git stash pop $(git stash list | \grep "$2" | head -1 | cut -d: -f1 | tr -d ' ')
    elif [[ $1 = "list" && ! -z $2 ]]; then
        local stash_index=$(git stash list | \grep "$2" | head -1 | cut -d: -f1 | tr -d ' ')
        if [[ -z "$stash_index" ]]; then
            echo "No stash with key: $2"
            return 1
        fi
        stash_cut | head -1 | \grep "$2" --color=auto
        stash_cut | head -1 | \grep "$2" --color=auto | tr -C "*" "-"
        echo
        git stash show $stash_index
    elif [[ $1 = "list" ]]; then
        local list=$(stash_cut);
        if [[ -z "$list" ]]; then
            echo "Nothing is stashed. Your stash is empty!";
			return 1
        fi
		stash_cut;
    else
        echo "
        Git Stash with Keywords
        Description: Using git-stash with keywords instead of indexes.

        Usage: stash [+= <keyword> [-p <path/to/file>]] [-= <keyword>] [list [<part-of-the-keyword>]]

        stash += <keyword>
        To stash your all of your changes.

        stash += <keyword> [-p <path/to/file>]
        To stash spesific file(s) with stash.

        stash -= <keyword>
        Extract a stash and remove it from the list.

        stash list
        List the stash.

        stash list <part-of-the-keyword>
        List what changes extracting a stash will make.
        "
    fi
    unset -f stash_cut
}
