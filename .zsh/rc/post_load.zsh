#--------------------------------------------------------------#
##          Post Execution                                    ##
#--------------------------------------------------------------#

if ! builtin command -v compinit > /dev/null 2>&1; then
  autoload -Uz compinit && compinit -u
fi

