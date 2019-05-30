# GIT Stash with Keywords
Using git-stash with keywords instead of indexes.

### Installation:
Just run 
```bash
git clone https://github.com/pegasuspect/GIT-Stash-With-Keywords.git # clone the repo
cd GIT-Stash-With-Keywords # change directory
./install.sh # declare the function
# This line is just a comment will do nothing :D
```

### Usage: 
stash [**+=** &lt;keyword&gt; [-p &lt;path/to/file&gt;]] [**-=** &lt;keyword&gt;] [**list** [&lt;part-of-the-keyword&gt;]]

1. To stash your all of your changes:

**Command:** stash **+=** &lt;keyword&gt;

2. To stash spesific file(s) with stash:

**Command:** stash **+=** &lt;keyword&gt; [-p &lt;path/to/file&gt;]

3. Extract a stash and remove it from the list:

**Command:** stash **-=** &lt;keyword&gt;

4. List the stash:

**Command:** stash **list**

5. List what changes extracting a stash will make:

**Command:** stash **list** _&lt;part-of-the-keyword&gt;_
