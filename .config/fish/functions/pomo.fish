function pomo -a 'event' 
    if test "$event" = 'start'
        echo 'Worktimeee 💻💻' | lolcat && timer 45m
    else if test "$event" = 'break'
        echo 'Breaktime =)' | lolcat && timer 15m
    else
        echo "Invalid operation -> '$event' is not valid for pomo"
    end
end

