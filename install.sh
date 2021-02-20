isNameDeclared=$(\grep "stash ()" $HOME/.bash_profile)

if [[ -n "$isNameDeclared" ]]; then # -n: nonzero length check
	echo "Your stash is ready to use. You can type stash to see usage and examples in a git folder.";
else
	./stash_function.sh # declares funciton
	cat $(pwd)/stash_function.sh >> $HOME/.bash_profile # add the function to profile for new sessions
	echo "Stash function is installed to your $HOME/.bash_profile";
	echo "Now, type: stash";
fi
unset isNameDeclared;
