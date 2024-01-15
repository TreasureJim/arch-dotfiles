function autocomplete_theme_files
    set autocomplete_dir "~/.config/alacritty/themes/"
    set autocomplete_dir (eval echo $autocomplete_dir)

    set current_word (commandline -t)
    ls -1 -- "$autocomplete_dir" 2> /dev/null | sed "s|.*|$autocomplete_dir&\t&|"
end

complete -c alacritty-switch-theme -a "(autocomplete_theme_files)"
