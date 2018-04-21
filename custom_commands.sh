#!/bin/bash

parse_git_branch()
{
    var=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    if [[ -z "${var}" ]]
        then
        echo ""
    else
        echo " ${var}"
    fi
}
#Default:
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$ (parse_git_branch) \$ '
#Retracted:
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '

#if [ "$color_prompt" = yes ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '
#else
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$ (parse_git_branch) \$ '
#fi

generate_pdf()
{
    should_open=false
    if [[ $# -lt 2 ]]
        then
        tex_file=$1
    else
        tex_file=$2

        if [[ $1 =~ "-O" ]]
            then
            should_open=true
        fi
    fi

    x=$tex_file
    y=${x%.tex}

    process_number=$(ps aux | grep -v "grep" | grep "evince build/${y}.pdf" | awk '{print $2}')
    if ! [[ -z "${process_number}" ]]
        then
        kill ${process_number}
    fi

    rm *.aux > /dev/null 2>&1;
    rm *.bbl > /dev/null 2>&1;
    rm *.blg > /dev/null 2>&1;
    rm *.dvi > /dev/null 2>&1;
    rm *.log > /dev/null 2>&1;
    rm *.out > /dev/null 2>&1;
    rm *.toc > /dev/null 2>&1;
    rm *.lot > /dev/null 2>&1;
    rm *.lof > /dev/null 2>&1;


    "pdflatex" ${tex_file};
    find . | grep -E "\.gnuplot$" | xargs gnuplot;
    "bibtex" ${tex_file};
    "pdflatex" ${tex_file};
    "pdflatex" ${tex_file};
    "pdflatex" ${tex_file};

    rm *.aux > /dev/null 2>&1;
    rm *.bbl > /dev/null 2>&1;
    rm *.blg > /dev/null 2>&1;
    rm *.dvi > /dev/null 2>&1;
    rm *.log > /dev/null 2>&1;
    rm *.out > /dev/null 2>&1;
    rm *.toc > /dev/null 2>&1;
    rm *.lot > /dev/null 2>&1;
    rm *.lof > /dev/null 2>&1;
    #rm $(find . | grep -E "thesis-gnuplottex-fig");

    if [ ! -d "./build" ]; then
        mkdir build;
    fi

    mv *.pdf ./build/

    if [[ ${should_open} = true ]]
        then
        evince ./build/"${y}.pdf" > /dev/null 2>&1 &
    fi
}

# Function for fast starting up thesis environment.
start_thesis_work()
{
    nohup discord > /dev/null 2>&1 &
    nohup google-chrome-stable "https://www.youtube.com/watch?v=WHoGFB6tsXI&list=PL4k1vdIPLQXcbIJul5DEmVDa9uLwq-pG7&index=26&t=01" facebook.com toggl.com https://github.com/Per-Morten/imt3912_thesis https://github.com/Per-Morten/imt3912_dev > /dev/null 2>&1 &
    cd /home/per-morten/School/ntnu/6th_semester/imt3912_thesis/
    pushd imt3912_thesis/daily_scrum > /dev/null
}

start_gpu_work()
{
    nohup discord > /dev/null 2>&1 &
    nohup google-chrome-stable "https://www.youtube.com/watch?v=WHoGFB6tsXI&list=PL4k1vdIPLQXcbIJul5DEmVDa9uLwq-pG7&index=26&t=01" facebook.com toggl.com https://github.com/Perrern/IMT3612-GPU/issues > /dev/null 2>&1 &
    cd /home/per-morten/School/ntnu/6th_semester/imt3612_gpu_programming
    evince opencl20-quick-reference-card.pdf > /dev/null 2>&1 &
    cd imt3612_gpu/data/projects/
}

# Remap caps to escape:
/usr/bin/setxkbmap -option "caps:escape"
# If wrongly turning on capslock, comment out the line above, and comment in this.
# And source ~/.bashrc
#/usr/bin/setxkbmap -option

# Ensure that vim is the preferred editor for Git and others.
export VISUAL=vim
export EDITOR="$VISUAL"

# Ensure that passwords are asked for without gui prompt.
unset SSH_ASKPASS

# Copy to clipboard
alias clipboard='xclip -sel clip'

# Fix oversensitive razer mouse
xset m 1 0
xinput --set-prop "Razer Razer DeathAdder" "Device Accel Constant Deceleration" 2
xinput --set-prop "Razer Razer DeathAdder" "Device Accel Velocity Scaling" 1
xinput --set-prop "Razer Razer DeathAdder" "Device Accel Profile" -1

# Hastebin command
hastebin()
{
    result=$(curl -sf --data-binary @${1:--} https://hastebin.com/documents) || {
        echo "ERROR: failed to post document" >&2
        exit 1
    }

    key=$(jq -r .key <<< $result)

    echo "https://hastebin.com/${key}"
}
alias sl="ls"

# Sublime font name
# "font_face": "Anonymous Pro",

# Open folder command
open_current_folder()
{
    nautilus $(pwd) > /dev/null 2>&1;
}

fix_mouse_click()
{
    unity;
}
 
export TERM=screen-256color

