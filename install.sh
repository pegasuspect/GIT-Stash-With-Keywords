isNameDeclared=$(declare -F stash)

if [[ -n "$isNameDeclared" ]]; then # -n: nonzero length check
	echo "Your stash is ready to use. Now, type: stash";
elif [[ -f $HOME/.bash_profile ]]; then
	cat $(pwd)/stash_function.sh >> $HOME/.bash_profile
	echo "Successfully installed stash function to your $HOME/.bash_profile";
else
	cat $(pwd)/stash_function.sh > $HOME/.bash_profile;
	echo "Successfully installed! Now, type: stash";
fi
unset isNameDeclared;