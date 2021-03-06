function reverse {
  IFS=$'\n'
  if [[ $1 = "interactive" ]] #интерактивный режим
  then
    if [[ -n $4 || -z $2 || -z $3 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. Введите названия двух файлов\033[0m"
      argumentError_int
      return $?
    fi
    if ! [[ -e $2 ]]
    then
      echo -e "\033[31mОшибка - нет файла $2\033[0m"
      noFileError_int
      return $?
    fi
    if ! [[ -r $2 ]]
    then
      echo -e "\033[31mОшибка - недостаточно прав для запуска $2\033[0m"
      accessError
    fi
    if [[ -f $3 ]] && ! [[ -w $3 ]]
    then
      echo -e "\033[31mОшибка - нет доступа к файлу $3\033[0m"
      accessError_int
      return $?
    fi
    if ! [[ -r "$(dirname $3)" ]]
    then
      echo -e "\033[31mОшибка - нет доступа к директории файла $3\033[0m"
      accessError_int
      return $?
    fi
    if ! [[ -w "$(dirname $3)" ]] && ! [[ -f "$3" ]]
    then
      echo -e "\033[31mОшибка - нет доступа к директории, чтобы создать файл\033[0m"
      accessError_int
      return $?
    fi
    echo -n > $3
    tac $2 >> a.txt
    rev a.txt >> $3
    rm a.txt
  else # неинтерактивный режим
    if [[ $3 -ne 3 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После reverse введите названия двух файлов\033[0m"
      argumentError
    fi
    if ! [[ -e $1 ]]
    then
      echo -e "\033[31mОшибка - нет файла $1\033[0m"
      noFileError
    fi
    if ! [[ -r $1 ]]
    then
      echo -e "\033[31mОшибка - недостаточно прав для запуска $1\033[0m"
      accessError
    fi
    if ! [[ -r "$(dirname $2)" ]]
    then
      echo -e "\033[31mОшибка - нет доступа к директории файла $2\033[0m"
      accessError
    fi
    if ! [[ -w "$(dirname $2)" ]] && ! [[ -f "$2" ]]
    then
      echo -e "\033[31mОшибка - нет доступа к директории, чтобы создать файл\033[0m"
      accessError
    fi
    if [[ -f $2 ]] && ! [[ -w $2 ]]
    then
      echo -e "\033[31mОшибка - нет доступа к файлу $2\033[0m"
      accessError
    fi
    echo -n > $2
    tac $1 >> a.txt
    rev a.txt >> $2
    rm a.txt
  fi
}
