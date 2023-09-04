alias in="task add +in"

tp () {
  task s project:$1
}

webpage_title (){
    curl "$1" -so - | grep -iPo '(?<=<title>)(.*)(?=</title>)'
}

read_and_review (){
    link="$1"
    title=$(webpage_title $link)
    echo $title
    descr="\"Review: $title\""
    id=$(task add +next +rnr "$descr" | sed -n 's/Created task \(.*\)./\1/p')
    task "$id" annotate "$link"
}

alias rnr=read_and_review

alias tsync="cd ~/.task && ./git-sync"
