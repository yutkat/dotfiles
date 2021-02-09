
GIT_STATUS=$(git_super_status_wrapper)

PROMPT='[%n@%m:%.${GIT_STATUS}]${WINDOW:+"[$WINDOW]"}$(__show_status)%# '

function set_async() {
  async_init
  async_start_worker git_prompt_worker -n
  function git_prompt_callback() {
    GIT_STATUS=$(git_super_status_wrapper)
    zle reset-prompt
  }
  function kick_git_prompt_worker() {
    async_job git_prompt_worker true
  }
  async_register_callback git_prompt_worker git_prompt_callback
  add-zsh-hook precmd kick_git_prompt_worker
  kick_git_prompt_worker
}
