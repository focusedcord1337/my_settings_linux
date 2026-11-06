#testar, _bash_profile verkar va den s. startar varje gång m. boota terminalen

# Filen .bashrc verkar ist va = när starta non logg in elr 
#promta bash f. komma in i/skapa subshell

#Lägger in printen f. att se när de är från .bash_profile elr .bashrc
printf '_FROM_BASH_PROFILE_'

printf "\n\nWeek: " 
date +%V
printf '\n'

#calling .bashrc i denna för att få custimazation till båda! 

#Om .bashrc fil finns = execute that files code, drf kmr custimazation finnas
#i båda typerna av shells
[ -f ~/.bashrc ] && source ~/.bashrc
