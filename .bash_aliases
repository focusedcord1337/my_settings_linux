#!/usr/bin/env bash

# Custom sys/bash commands
	alias ..='cd ..'
	alias lah='ls -lah'
	alias cl="clear"
	alias mkdir='mkdir -p'
	alias rm='rm -i'
	alias s.insta='sudo apt install'
# Env things
	alias os_version='lsb_release -a'
	alias os_v='lsb_release -a'
	alias penv='printenv | less'
	alias pzombie='ps -ef | grep defunct'
	alias pfuncs='declare -F'

# MEMORY aliases
	alias df='df -h'
	# Get memory total of specified path
	alias memd='du -sh'

# Type aliases
	alias type="type -a"
	alias typ="type -a"

# Python
	alias py3='python3'

# coloring less & manpages
	alias less='less --use-color'
	export MANPAGER="less --use-color"

# GIT aliases
	alias g='git'
	# See files in a commit
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
		# pulls repo 
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
	alias vs="nano ~/my_vscode_backupps/vs_code_cheat_sheet.md"

#run my own programs
	alias svs='~/my_linux/backupp_all.sh'
	
	alias chs='~/qlf/C/build_h_source.sh'
	alias cphs='~/qlf/CPP/build_h_source.sh'
	alias vcpp='cmpl ~/qlf/CPP/cpp_version.cpp && ~/qlf/CPP/cpp_version'
	alias pygen='python3 ~/libs/py/gen_py.py'

# Functions
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

	my_ascii(){ # Prints ASCII characters, special characters excluded E.g \n
		my_sep

		seq 32 126 | awk 'BEGIN{print "\n\tOCT\tHEX\tDEC\tCHAR\n\t---\t---\t---\t-"}; 
		{printf("\t%o\t%x\t%d\t%c\n"),$1,$1,$1,$1}; 
		END{printf "\t---\t---\t---\t-\n\tOCT\tHEX\tDEC\tCHAR\n\t---\t---\t---\t---\n"}'
		
		my_sep
	}

	my_unit(){ # Function that prints out unit or convert a number based in unit
		
		if [[ $# -eq 0 ]]; then
			printf "%s\n" \
				"Usage: unit <value> <prefix>" \
				"       unit <value><prefix>" \
				"" \
				"Examples:" \
				"  unit 500 milli    -> 0.5" \
				"  unit 500m         -> 0.5" \
				"  unit 500T         -> 500 000 000 000 000" \
				"  unit 4 Gi         -> 4 294 967 296" \
				"" \
				"=== SI Decimal Prefixes (Base 10) ===" \
				"Name       Symbol   Value (based on 1)" \
				"----------------------------------------" \
				"quetta     Q        1e+30" \
				"ronna      R        1e+27" \
				"yotta      Y        1e+24" \
				"zetta      Z        1e+21" \
				"exa        E        1 000 000 000 000 000 000" \
				"peta       P        1 000 000 000 000 000" \
				"tera       T        1 000 000 000 000" \
				"giga       G        1 000 000 000" \
				"mega       M        1 000 000" \
				"kilo       k        1 000" \
				"hecto      h        100" \
				"deca       da       10" \
				"deci       d        0.1" \
				"centi      c        0.01" \
				"milli      m        0.001" \
				"micro      u / µ    0.000001" \
				"nano       n        0.000000001" \
				"pico       p        0.000000000001" \
				"femto      f        0.000000000000001" \
				"atto       a        1e-18" \
				"zepto      z        1e-21" \
				"yocto      y        1e-24" \
				"ronto      r        1e-27" \
				"quecto     q        1e-30" \
				"" \
				"=== Binary Computing Prefixes (Base 2) ===" \
				"Name       Symbol   Value (based on 1)" \
				"----------------------------------------" \
				"quebi      Qi       1 267 650 600 228 229 401 496 703 205 376" \
				"robi       Ri       1 237 940 039 285 380 274 899 124 224" \
				"yobi       Yi       1 208 925 819 614 629 174 706 176" \
				"zebi       Zi       1 180 591 620 717 411 303 424" \
				"exbi       Ei       1 152 921 504 606 846 976" \
				"pebi       Pi       1 125 899 906 842 624" \
				"tebi       Ti       1 099 511 627 776" \
				"gibi       Gi       1 073 741 824" \
				"mebi       Mi       1 048 576" \
				"kibi       Ki       1 024"
			return 0
		fi

		local val=""
		local prefix=""

		# Support both "unit 500 m" and "unit 500m"
		if [[ $# -eq 1 && "$1" =~ ^([+-]?[0-9]*\.?[0-9]+([eE][+-]?[0-9]+)?)([a-zA-Zµ]+)$ ]]; then
			val="${BASH_REMATCH[1]}"
			prefix="${BASH_REMATCH[3]}"

		elif [[ $# -eq 2 ]]; then
			val="$1"
			prefix="$2"
		
		else
			echo "Error: Invalid arguments. Run 'unit' with no arguments for help." >&2
			return 1
		fi

		awk -v val="$val" -v p="$prefix" 'BEGIN {
			# SI Large prefixes
			map["da"] = 1e1;  map["deca"]   = 1e1;  map["deka"] = 1e1;
			map["h"]  = 1e2;  map["hecto"]  = 1e2;
			map["k"]  = 1e3;  map["kilo"]   = 1e3;
			map["M"]  = 1e6;  map["mega"]   = 1e6;
			map["G"]  = 1e9;  map["giga"]   = 1e9;
			map["T"]  = 1e12; map["tera"]   = 1e12;
			map["P"]  = 1e15; map["peta"]   = 1e15;
			map["E"]  = 1e18; map["exa"]    = 1e18;
			map["Z"]  = 1e21; map["zetta"]  = 1e21;
			map["Y"]  = 1e24; map["yotta"]  = 1e24;
			map["R"]  = 1e27; map["ronna"]  = 1e27;
			map["Q"]  = 1e30; map["quetta"] = 1e30;

			# SI Small prefixes
			map["d"]  = 1e-1;  map["deci"]   = 1e-1;
			map["c"]  = 1e-2;  map["centi"]  = 1e-2;
			map["m"]  = 1e-3;  map["milli"]  = 1e-3;
			map["u"]  = 1e-6;  map["µ"]      = 1e-6; map["micro"] = 1e-6;
			map["n"]  = 1e-9;  map["nano"]   = 1e-9;
			map["p"]  = 1e-12; map["pico"]   = 1e-12;
			map["f"]  = 1e-15; map["femto"]  = 1e-15;
			map["a"]  = 1e-18; map["atto"]   = 1e-18;
			map["z"]  = 1e-21; map["zepto"]  = 1e-21;
			map["y"]  = 1e-24; map["yocto"]  = 1e-24;
			map["r"]  = 1e-27; map["ronto"]  = 1e-27;
			map["q"]  = 1e-30; map["quecto"] = 1e-30;

			# Binary Computing prefixes (IEC)
			map["Ki"] = 1024^1; map["kibi"] = 1024^1;
			map["Mi"] = 1024^2; map["mebi"] = 1024^2;
			map["Gi"] = 1024^3; map["gibi"] = 1024^3;
			map["Ti"] = 1024^4; map["tebi"] = 1024^4;
			map["Pi"] = 1024^5; map["pebi"] = 1024^5;
			map["Ei"] = 1024^6; map["exbi"] = 1024^6;
			map["Zi"] = 1024^7; map["zebi"] = 1024^7;
			map["Yi"] = 1024^8; map["yobi"] = 1024^8;
			map["Ri"] = 1024^9; map["robi"] = 1024^9;
			map["Qi"] = 1024^10; map["quebi"] = 1024^10;

			if (!(p in map)) {
				print "Error: Unknown prefix \x27" p "\x27. Run \x27unit\x27 for valid prefixes." > "/dev/stderr"
				exit 1
			}

			res = val * map[p]
			abs_res = (res < 0) ? -res : res

			# Expand numbers >= 1000 fully with space separators; keep small decimals clean
			if (abs_res >= 1000 && abs_res < 1e35) {
				str = sprintf("%.15f", res)
				sub(/\.?0+$/, "", str)
			} else {
				str = sprintf("%.18g", res)
			}

			# Insert spaces every 3 digits in the integer part (if not scientific notation)
			if (str !~ /[eE]/) {
				split(str, parts, ".")
				int_part = parts[1]
				dec_part = (length(parts) > 1) ? "." parts[2] : ""

				sign = ""
				if (substr(int_part, 1, 1) == "-") {
					sign = "-"
					int_part = substr(int_part, 2)
				}

				formatted = ""
				len = length(int_part)
				for (i = 1; i <= len; i++) {
					formatted = formatted substr(int_part, i, 1)
					rem = len - i
					if (rem > 0 && rem % 3 == 0) {
						formatted = formatted " "
					}
				}
				str = sign formatted dec_part
			}

			print str
		}'
	}

	my_lsmem(){ # Get a list file contents size sorted
		[[ "$#" -lt "1" ]] && printf "Need to sen in a path as arg\n" && return
		du -sh $1 | sort -h
	}

	my_cmpl(){ # Compiling c or c++ file using gcc | g++ can take in includes aswell
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

	my_cxx_asm_cmpl(){ # Comiles cxx files and put out asmbly code for it, if c++

		cmpler=""
		v_standard="17"

		if [[ "$#" -eq 0 ]]; then
			printf "Arg1 = main.CXX, Arg2 = cxx standard (optinal, the default is 17)\n"
			printf "OBS. If Arg1 = *.cpp file then it will also generate a demangeled file\n\n"
		else
			bin="${1%.*}"
			
			if [[ "$#" -gt 1 ]]; then
				v_standard="$2"
			fi
			
			if [[ "$bin" != "$1" ]]; then
				exstension=".${1##*.}"
			
				if [[ "$exstension" = ".c" ]]; then
					cmpler="gcc "
					v_standard="-std=c$v_standard"
				
				elif [[ "$exstension" = ".cpp" ]]; then
					cmpler="g++ "
					v_standard="-std=c++$v_standard"
                    post_fix_demangeled="_demangeled.s"
                fi
			fi

            echo "$cmpler $1 $v_standard -S -fverbose-asm -o $bin.s"
            $cmpler "$1" "$v_standard" -S -fverbose-asm -o "$bin.s" 
            
            if [[ "$exstension" = ".cpp" ]]; then
                echo "c++filt < $bin.s > $bin$post_fix_demangeled"
			    c++filt < "$bin.s" > "$bin$post_fix_demangeled"
            fi
		fi
	}

	# Find funcs functions
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

	my_aliases_grep(){ # Function to grep aliases and get their doc if any
		
		if [[ "$#" -eq 0 ]]; then
				printf "Need atleast 1 thing to search for\n\n"
		else
			for e in "$@"; do
				tmp="$(alias | grep -A1 "$e")"
				echo "$tmp"
			done
		fi
	}

	my_pre_pend(){ # Add's prefix to files
		if [[ "$#" -gt 1 ]]; then
			ls $1 | while read -r file; do mv -- "$1/$file" "$1/$2$file"; done
		else
			printf "%s\n" "\nArg1 [what files], Arg2 [What to pre pend]"
		fi

	}

	my_de_pre_pend(){ # Function to remove prefix
		if [[ "$#" -gt 1 ]]; then
			ls $1 | while read -r file; do mv -- "$1/$file" "$1/${file#$2}"; done
		else
			printf "%s\n" "\nArg1 [what files], Arg2 [What to de pre pend]"
		fi
	}

	# Regex files
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

	my_mv_w_regx(){ # Function that moves dirs/files from . if having regex inside it E.g moving all prodjecta that has #include <Arduino.h> in it  

		if [[ "$#" -lt "2" ]]; then
			my_sep "="
			printf "Need too send in [regex, dest] Optinal is [field | -flags ]\n"
			printf "\nOBS if argcount == 2 only files will be moved if > 2 it depends on your field value\n"
			printf "\nOBS field default = 1 else if n found in <= arg3 will be largest number\n"
			printf "\nOBS -n flag defined for dry run (if args == 3 only files with regex else if args > 3 => dry run dirs/files)!\n"
			my_sep "="
		elif [[ "$#" -eq "2" ]];then
			grep -rl "$1" |  xargs -I {} mv {} -t "$2"
		else

			flg_dry_run="-n"
			field="1"
			is_dry=0
			j=3

			# Check for flags
			while [[ "$j" -le "$#" ]]; do
				
				if [[ "${!j}" -gt "0" ]]; then
					field="${!j}"
					
				elif [[ "${!j}" = "$flg_dry_run" ]]; then
					is_dry=1
				fi

				((j++))
			done
			
			# If dry run option is found
			if [[ "$is_dry" -gt "0" ]]; then
				printf "Would move:\n"

				if [[ "$#" -eq "3" ]]; then
					grep -rl "$1" | xargs -I {} echo {} && return
				else
					grep -rl "$1" | cut -d '/' -f"$field" | uniq |  xargs -I {} echo {} && return
				fi
			fi

			grep -rl "$1" | cut -d '/' -f"$field" | uniq |  xargs -I {} mv {} -t "$2"
					
		fi
	}

	my_rm_empty_tmps(){ # Rm empty files and shows word count of non empty once matching a pattern
		find ~/ -type f -name ".*.tmp" -exec sh -c 'for f; do [ ! -s "$f" ] && echo "0 $f (Deleted)" && rm -i "$f" || wc -w "$f"; done' _ {} +
	}

	# Git branch funcs
	my_git_sync_remote_branches(){ # Removes all branches that has been deleted on remote
		branches="git branch -d"

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

		git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r $branches
	}

	my_parse_git_branch() { # Function that only generate branch name if inside Git-repo
		if git rev-parse --is-inside-work-tree &>/dev/null; then
		echo " ($(git branch --show-current 2>/dev/null))"
		fi
	}

# Uppdate PS1 to include git branch if inside repo
	export PS1="${PS1%\\\$*}\[\033[38;5;14m\]\$(my_parse_git_branch)\[\033[00m\]\$ "