#!/bin/bash

clear

declare -i USER_ROW=1
declare -i PRO_ROW=0
declare -i USER_MAX=20
declare -i PRO_MAX=100
PID=0
USER_NOW=""

print_logo(){
    clear
	tput cup 0 0
	echo [0m "______"
    for ((i=1;i<5;i++))
    do
        tput cup $i 0
        echo "|"
    done
    tput cup 1 7
    echo "\                       |"
    tput cup 1 3
       echo "___                       |      (_)"
    tput cup 2 2
    echo "|__/ / ____   _____   ___  | |_   _    __   ___" 
    tput cup 3 2
    echo " ___/ |  __| /  _  | / __| | __| | | / __| / _ \ "
    tput cup 4 2
    echo "|     | |    | (_| || (__  | |_  | || (   |  __/"
  echo "|       |_|    \___,_| \___| \___| |_| \___| \___| "

    tput cup 5 0
    echo "\_|"
    tput cup 7 0
    echo "(_)"
    echo " _    _____"
    echo "| |  |  _  |"
    echo "| |  | | | |"
    echo "|_|  |_| |_|  LINUX"

    # task space
    tput cup 14 0
    echo "-NAME-----------------CMD----------------------PID---STIME------"
    for ((i=15;i<35;i++))
    do
    echo "|                    |                        |       |      |"
    done
    echo "-------------------------------------------------------------"
    echo "If you want to exit, Please Type 'q' or 'Q'"
}
print_task(){
    tput cup 15 1
    declare -i U=1
    declare -i C=1
    declare -i COUNT=$PRO_ROW-20
    declare -i CHECK



    for USER in `ps -ef | awk '{print $1}' | sed '1d' | sort | uniq`
    do
    
        if [ $U -le 20 ]
            then

            if [ ${USER_ROW} -eq $U ]
            then
            
            echo [41m "                   "
            tput cuu 1
            tput cuf 1
            echo [41m "${USER}"
            tput sc
            tput cup 15 0            
            USER_NOW=$USER

           
           ##for CMD in `ps -f -u ${USER} --sort=-pid | awk '{print $8}'| sed '1d'`
           ## for CMD in 
        while read line
           do
            

            if [ $PRO_ROW -le 20 ]
            then
            CHECK=3    
                ## less then 20
                if [ $C -le 20 ] 
                then
                    if [ $C -eq $PRO_ROW ]
                    then

                    tput cuf 22
                    echo [42m "                                 "
                    tput cuu 1
                    tput cuf 22 

                    PS=`echo ${line} | awk '{print $2}'`
                    F_B=`ps -f | awk '{print $2}' | grep -c $PS`
                    if [ $F_B -ne 0 ]
                    then
                    echo [42m "F "
                    else
                    echo [42m "B "
                    fi
                    tput cuu 1
                    tput cuf 24    
                    CMD=`echo ${line} | awk '{print $8}'`
                    echo [42m ${CMD:0:20}

                    tput cuu 1
                    tput cuf 45
                    echo [42m "|`echo ${line} | awk '{print $2}'`"
                    PID=`echo ${line} | awk '{print $2}'`
                    tput cuu 1
                    tput cuf 53
                    echo [42m "|`echo ${line} | awk '{print $5}'`"  
                    C=$((C+1))

                    else
                  
                    tput cuf 22
                    PS=`echo ${line} | awk '{print $2}'`
                    F_B=`ps -f | awk '{print $2}' | grep -c $PS`
                    if [ $F_B -ne 0 ]
                    then
                    echo [0m "F "
                    else
                    echo [0m "B "
                    fi
                    tput cuu 1
                    tput cuf 24  
                    CMD=`echo ${line} | awk '{print $8}'`
                    echo [0m ${CMD:0:20}

                    tput cuu 1
                    tput cuf 47
                    echo ${line} | awk '{print $2}'
                    tput cuu 1
                    tput cuf 55
                    echo ${line} | awk '{print $5}'
                    let "C+=1"
                    fi
                else
                PRO_MAX=100
                break
                fi 
                    PRO_MAX=$C-1

            ##more then 20
            #count: PRO_LOW -20
            else
                if [ $COUNT -ne 0 ]
                then
                    COUNT=COUNT-1
                else
                    if [ $C -le 20 ]
                    then
                        if [ $C -eq 20 ]
                        then
                         tput cuf 22
                        echo [42m "                                 "
                        tput cuu 1
                        tput cuf 22 

                        PS=`echo ${line} | awk '{print $2}'`
                        F_B=`ps -f | awk '{print $2}' | grep -c $PS`
                        if [ $F_B -ne 0 ]
                        then
                        echo [42m "F "
                        else
                        echo [42m "B "
                        fi
                        tput cuu 1
                        tput cuf 24    
                        CMD=`echo ${line} | awk '{print $8}'`
                        echo [42m ${CMD:0:20}

                        tput cuu 1
                        tput cuf 45
                        echo [42m "|`echo ${line} | awk '{print $2}'`"
                        tput cuu 1
                        tput cuf 53
                        echo [42m "|`echo ${line} | awk '{print $5}'`"  
                        C=$((C+1))

                         else
                  
                        tput cuf 22
                        PS=`echo ${line} | awk '{print $2}'`
                        F_B=`ps -f | awk '{print $2}' | grep -c $PS`
                        if [ $F_B -ne 0 ]
                        then
                        echo [0m "F "
                        else
                        echo [0m "B "
                        fi
                        tput cuu 1
                        tput cuf 24  
                        CMD=`echo ${line} | awk '{print $8}'`
                        echo [0m ${CMD:0:20}

                        tput cuu 1
                        tput cuf 47
                        echo ${line} | awk '{print $2}'
                        tput cuu 1
                        tput cuf 55
                        echo ${line} | awk '{print $5}'
                        let "C+=1"
                        CHECK=0 
                        fi
                    else ## more than 20 -> break
                    CHECK=1
                    break
                    fi 


                fi
           
            fi
          
            done <<<$(ps -ef --sort=-pid | awk -v user=${USER} '$1 == user')
    

            else
            
            #echo [0m "                   "
            #tput cuu 1
            #tput cuf 1
            echo [0m "${USER}"
            tput sc
            fi
            tput rc
            tput cuf 1
            U=U+1
        else
        break
        fi
        USER_MAX=U-1
    done
    if [ $CHECK == 0 ]
    then
    PRO_MAX=PRO_ROW
    fi
    echo [0m ""

   

}
key()
{
    tput cup 38 0
    while true
    do
        read -r -s -n1 key1
        if  [[ $key1 = "" ]]
        then
            if [ $PID -ne 0 ]
            then
                if [ $USER_NOW == `whoami` ]
                then
                kill -9 $PID
                
                else
                echo "NO PERMISSION!!!!!!!!!!!!!"
                fi
            fi
        elif [ $key1 = "u" ] || [ $key1 = "U" ]
        then
            if [ $PRO_ROW -gt 20 ]
            then
            PRO_ROW=PRO_ROW-20
            init
            elif [ $PRO_ROW -ne 0 ]
            then
            PRO_ROW=1
            init
            fi
        elif [ $key1 = "d" ] || [ $key1 = "D" ]
        then
            echo "AA"
            if [ $PRO_MAX -eq 100 ] && [ $PRO_ROW -ne 0 ]
            then
            PRO_ROW=PRO_ROW+20
            init
            
            fi
            
    	elif [ "${key1}" = "" ]
    	then
		read -N2 key
        tput cup 38 0
            # up
	    	if [ "${key}" = "[A" ]
		    then
                tput cup 38 0
                if [ $PRO_ROW -eq 0 ]
                then
                    if [ $USER_ROW -ne 1 ]
                    then
                        USER_ROW=USER_ROW-1
                    fi
                else
                    if [ $PRO_ROW -ne 1 ]
                    then 
                    PRO_ROW=PRO_ROW-1
                    fi
                fi
                init
            fi

            # down
	    	if [ "${key}" = "[B" ]
		    then

            if [ $PRO_ROW -eq 0 ]
                then
                if [ $USER_ROW -lt $USER_MAX ]
                then             
                USER_ROW=USER_ROW+1
                fi

            else
                if [ $PRO_ROW -lt $PRO_MAX ]
                then
                PRO_ROW=PRO_ROW+1
                fi
            fi
            init    
            fi

            #right
            if [ "${key}" = "[C" ]
            then
                if [ $PRO_ROW -eq 0 ]
                then
                PRO_ROW=1
                
                fi

            init    
            fi

            #left
            if [ "${key}" = "[D" ]
            then
            PRO_ROW=0
            init
            fi
            
            


        elif [ "${key1}" = "q" ] || [ "${key1}" = "Q" ]
    	then
            exit
        fi
        
    done


}

init(){
print_logo
print_task
key
}

init