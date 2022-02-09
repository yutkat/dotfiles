aug i3config#ft_detect
    au!
    au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config,*i3/*.config,*i3/*.conf,*i3/config.d/*.conf,*sway/*.config,*sway/*.conf,*sway/config.d/*.conf,*sway/config,*.swayconfig,*.sway.config,sway.config,*sway/config set filetype=i3config
aug end
