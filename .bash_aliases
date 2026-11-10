#!/usr/bin/env bash

# 	Custom sys/bash commands
alias ..='cd ..'
alias df='df -h'
alias lah='ls -lah'
alias memd='du -sh'
alias cl="clear"
alias mkdir='mkdir -p'
alias rm='rm -i'
alias s.insta='sudo apt install'
alias os_version='lsb_release -a'
alias os_v='lsb_release -a'
alias penv='printenv | less'
alias pzombie='ps -ef | grep defunct'

alias type="type -a"
alias typ="type -a"
alias py3='python3'

# coloring less & manpages
alias less='less --use-color'
export MANPAGER="less --use-color"

# git aliases
alias g='git'
alias gnm='git diff-tree --name-only --pretty -r'
alias gsts='git status'
alias glog='git log --oneline'
alias gal='git log'
alias gslog='glog && gsts'
alias ggra='git log --decorate --graph --oneline'

# Git tags 
alias gstag='git tag -n'
alias grt='git ls-remote --tags origin'

# Git commits
alias ga='git add'
alias gco='git commit'
alias gca="git add . && git commit"
alias gcam='git commit --amend'

# Git push & pulls
alias pu='git pull'
alias ppu='git pull && git push'
alias gpust='git push --tags'

# Git branches
alias gb='git branch -vv'
alias gbc='git switch -c'
alias grso='git remote show origin'

# Git switch
alias gsw='git switch'
alias gswm='git switch main || git switch master'
alias gswl='git switch -' 

alias gbm='git switch main || git switch master && git pull'
alias gmm='git switch main || git switch master && git pull && git switch - && git merge main || git merge master'

# Open own things 
alias gcmnd='nano ~/my_linux/git_commands.txt'
alias lnxs='nano ~/my_linux/usefull_comands.txt'

#run my own programs
alias svs='~/my_linux/backupp_all.sh'
alias chs='~/qlf/C/build_h_source.sh'
alias cphs='~/qlf/CPP/build_h_source.sh'
alias vcpp='cmpl ~/qlf/CPP/cpp_version.cpp && ~/qlf/CPP/cpp_version'
alias pygen='python3 ~/libs/py/gen_py.py'

my_sys_info(){ # print desired sys info
	printf "Date: "
	date +%F
	printf "Week: "
	date +%V
	printf '\n'
	# Sys info
	lsb_release -a
	uname -r
	printf '\n'
}

# print on startupp every terminal
my_sys_info

my_sep(){ #Prints seperator
		sep="_" 
		ldiv=""
		width=$(tput cols) # or width=$(tput cols) to always adapt to screen width growing
		# OBS ternary opp just for intergers!
		# (( $(tput cols) < $stdwidth  ? ( width = $(tput cols) ) : (width = $stdwidth))) 
		
		if [[ "$#" -gt 0 && "${#1}" -eq 1 ]]; then
			sep="$1"
		fi
		
		while [ "${#ldiv}" -lt "$width" ];
		do
			ldiv+="$sep"
		done

		printf "%q\n" "$ldiv"
}

ASCII(){ # Prints ASCII characters, special characters excluded E.g \n
	my_sep

	seq 32 126 | awk 'BEGIN{print "\n\tOCT\tHEX\tDEC\tCHAR\n\t---\t---\t---\t-"}; 
	{printf("\t%o\t%x\t%d\t%c\n"),$1,$1,$1,$1}; 
	END{printf "\t---\t---\t---\t-\n\tOCT\tHEX\tDEC\tCHAR\n\t---\t---\t---\t---\n"}'
	
	my_sep
}

bk(){ # Going backwards 1 or moore steps, popd to get back to dir

	backing="../"

	if [[ "$(($# + 0))" -gt 0 ]]; then
		if [[ " $((0 + $1))" -gt 1 ]]; then
			i=1
			while [[ $i -lt "$1" ]]; do
				backing="../$backing" #echo $backing
				((i++))
			done
		fi
    fi
	
	pushd "$backing"
}

my_pre_pend(){ # Add's prefix to files
	if [[ "$#" -gt 1 ]]; then
		ls $1 | while read -r file; do mv -- "$file" "$2$file"; done
	else
		printf "%s\n" "\nArg1 [what files], Arg2 [What to pre pend]"
	fi

}

my_de_pre_pend(){ # Function to remove prefix
	if [[ "$#" -gt 1 ]]; then
		ls $1* | while read -r file; do mv -- "$file" "${file#$2}"; done
	else
		printf "%s\n" "\nArg1 [what files], Arg2 [What to de pre pend]"
	fi
}

cmpl(){ # Compiling c or c++ file using gcc | g++ can take in includes aswell
	my_sep
	cmpler=""
	printf "Arg1 = main.CXX, Arg [...] is include paths\n\n"

	if [[ "$#" -gt 0 ]]; then
		bin="${1%.*}"
		
		if [[ "$bin" != "$1" ]]; then
			exstension=".${1##*.}"
		
			if [[ "$exstension" = ".c" ]]; then
				cmpler="gcc"
			elif [[ "$exstension" = ".cpp" ]]; then
				cmpler="g++"
			fi
			
			if [[ "${#cmpler}" -gt 0 ]]; then
					cmpl_flags="-Wall -Wextra -Wpedantic -Werror -g"
					h_exstension=".h"
					spath="./"
					objct=""
					inp=""
					in="2"
				declare -a o_files
				
				while [[ "$in" -le "$#" ]]; do

					if [[ "${!in:0:2}" != "$spath" ]]; then 
						tmp="${!in%*.}"
						echo "tmp % = $tmp"	
					else
						tmp="${!in##*.}"
						echo "tmp ## = $tmp"
					fi
					
					if [[ "$exstension" = ".$tmp" ]]; then
						
						objct+="${!in%.$tmp}.o "
						o_files+=("${!in}")

					elif [[ "$h_exstension" = ".$tmp" ]]; then
						inp+="-I ${!in%/*} "
					else 
						inp+="-I ${!in} "
					fi
					((in++))
				done

				for i in $o_files; do
					compile="$cmpler -c $i $cmpl_flags $inp -o ${i%.*}.o"
					printf "%s\nObject compiled: %s\n\n" "$compile" "${i%.*}.o"
					$compile
				done

				compile="$cmpler $1 $objct $cmpl_flags $inp -o $bin"
				printf "%s\n" "$compile"
				$compile
			fi
			else
			printf "%s\n" "Arg 1 need to have an exstension"
		fi
	else
		printf "%s\n" "Need to send in atleast 1 arg.\narg 1 = file, [...] include path or file"
    fi
	my_sep
}

# File functions
my_f_find(){ # Finds a file recursivly 

	if [[ "$#" -lt 1 ]]; then
	    printf "Need too send in [path | file] [...]\n\n"
		printf "OBS Using wildcards inside args [\"\$n\"] or no \"\"'s for list of [\$n's]\n"
	else
		spath="./"
		j=1
		pretty=0
		#Check for flags
		while [[ "$j" -le "$#" ]]; do
			# If --pretty option is found		
			[[ "${!j}" == "--pretty" ]] && my_sep && pretty=1 && break
			((j++))
		done
		j=1

		if [[ "$#" -gt 1 ]]; then

			if [[ "${1:0:2}" != "$spath" ]]; then 
				tmp="$spath$1"
			else
				tmp="$1"
			fi
			readarray -d '' is_path < <(find -type d -wholename "${tmp%/}" -print0)
			
			#Check if 1st arg is a path
			if [[ "${#is_path[@]}" -gt 0 ]]; then
				spath=$1
				j=2
				in="$j"
			fi
		fi

		while [[ "$j" -le "$#" ]] 
		do
			readarray -d '' files < <(find $spath -type f -iwholename "${!j}" -print0)

			if [ "${#files[@]}" -gt 0 ]; then
				# If --pretty option
				[[ "$pretty" -gt "0" ]] && printf "\nSearch [$j]: \"${!j}\"\n%s\n\n" "Count: ${#files[@]}"

				for f in "${files[@]}"; do
					printf "%q\n" "$f"
				done
				# If --pretty option
				[[ "$pretty" -gt "0" ]] && my_sep
			fi
			((j++))
		done
	fi
}

my_dir_find(){ #Finds dirs containg args recursivly

	if [[ "$#" -lt 1 ]]; then
	    printf "Need too send in [path | dir] [...]\n\n"
		printf "OBS --pretty flag defined!\nUsing wildcards inside args [\"\$n\"] or no \"\"'s for list of [\$n's]\n"
	else
		spath="." #Default path
		pretty=0 #Bolean for --pretty option
		j=1
		in="$j"
		# Check for flags
		while [[ "$j" -le "$#" ]]; do
			# If --pretty option is found
			[[ "${!j}" == "--pretty" ]] && my_sep && pretty=1 && break
			((j++))
		done
		j=1	
			
		if [[ "$#" -gt 1 ]]; then
			tmp="$1"
			readarray -d '' is_path < <(find -type d -wholename "${tmp%/}" -print0)
			
			if [[ "${#is_path[@]}" -eq 1 ]]; then
				spath="$1"
			fi
		fi

		while [[ "$j" -le "$#" ]]; do
			readarray -d '' dirs < <(find $spath -type d -iwholename "${!in}" -print0)

			if [[ "${#dirs[@]}" -gt 0 ]]; then
				# If --pretty option
				[[ "$pretty" -gt "0" ]] && printf "\nSearch [$in]: \"${!in}\"\n%s\n\n" "Count: ${#dirs[@]}"

				for dir in "${dirs[@]}"; do
					printf "%q\n" "$dir"
				done
				# If --pretty option
				[[ "$pretty" -gt "0" ]] && my_sep
			fi

			((j++))
			in="$j"
		done
	fi
}

my_rm_empty_tmps(){ # Rm empty files and shows word count of non empty once matching a pattern
	find ~/ -type f -name ".*.tmp" -exec sh -c 'for f; do [ ! -s "$f" ] && echo "0 $f (Deleted)" && rm -i "$f" || wc -w "$f"; done' _ {} +
}

my_regex_ls(){ # Function that gives a dir with files containing $1 can customize depth in $2

	if [[ "$#" -lt "1" ]]; then
	    printf "Need too send in atleast 1 arg in order [regex, feilds, ...]\n\n"
		printf "OBS --pretty flag defined to make clearer output only usabel as arg 3!\n"
	elif [[ "$#" -lt "2" ]]; then
	    grep -rl "$1" | cut -d '/' -f1 | uniq |  xargs -I {} echo {}
	else

		j=1
		pretty=0
		# Check for flags
		while [[ "$j" -le "$#" ]]; do
			# If --pretty option is found
			[[ "${!j}" == "--pretty" ]] && my_sep && pretty=1 && break
			((j++))
		done

		# Error checking for $2
		[[ "$2" == "--pretty" ]] && printf "%s\n" "The --pretty flag cant be arg 2!" && my_sep && return 
		[[ "$2" -eq "0" ]] && printf "%s\n" "The field arg need to be a number > 0!" && my_sep && return 

		[[ "$pretty" -gt "0" ]] && printf "Found regex \"$1\" in:\n\n"

	    grep -rl "$1" | cut -d '/' -f"$2" | uniq |  xargs -I {} echo {}

		[[ "$pretty" -gt "0" ]] && my_sep
	fi
}

my_git_sync_remote_branches(){ # Removes all branches that has been deleted on remote
	branches="git branch -D"

	if [[ "$#" -gt "0" ]]; then
		flg_dry_run="-n"
		j=0
		# Check for flags
		while [[ "$j" -le "$#" ]]; do
			# If dry run option is found
			if [[ "${!j}" = "$flg_dry_run" ]]; then
			 	branches="printf "%s\n""
				break
			fi
			((j++))
		done
	fi

	git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r "$branches"
		
}
parse_git_branch() { # Function that only generate branch name if inside Git-repo
	if git rev-parse --is-inside-work-tree &>/dev/null; then
	echo " ($(git branch --show-current 2>/dev/null))"
	fi
}

# Uppdate PS1 to include git branch if inside repo
export PS1="${PS1%\\\$*}\[\033[38;5;14m\]\$(parse_git_branch)\[\033[00m\]\$  "
