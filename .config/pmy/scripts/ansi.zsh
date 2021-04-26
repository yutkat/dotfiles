#!/usr/bin/env zsh
typeset -A ansi
ansi[reset]="$(print "\x1b[m")"
ansi[bold]="$(print "\x1b[1m")"
ansi[dim]="$(print "\x1b[2m")"

ansi[red]="$(print "\x1b[31m")"
ansi[green]="$(print "\x1b[32m")"
ansi[yellow]="$(print "\x1b[33m")"
ansi[blue]="$(print "\x1b[34m")"
ansi[magenta]="$(print "\x1b[35m")"
ansi[cyan]="$(print "\x1b[36m")"

ansi[gray]="$(print "\x1b[38;5;250m")"
ansi[dark_green]="$(print "\x1b[38;5;65m")"
ansi[dark_blue]="$ansi[dim]$ansi[blue]"
