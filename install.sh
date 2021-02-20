isNameDeclared=$(declare -F stash)

if [[ -n "$isNameDeclared" ]]; then # -n: nonzero length check
	echo "Your stash is ready to use. Now, type: stash";
else
	cat $(pwd)/stash_function.sh >> $HOME/.bash_profile
	echo "Stash function is installed to your $HOME/.bash_profile";
	echo "Now, type: stash";
fi
unset isNameDeclared;
