function e --wraps=emacsclient\ -c\ -a\ \'emacs\' --wraps=emacsclient\ -cnqua\ \'\' --description alias\ e=emacsclient\ -cnqua\ \'\'
  emacsclient -cnqua '' $argv; 
end
