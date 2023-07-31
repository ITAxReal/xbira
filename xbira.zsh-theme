#XBira ZSH theme
#Based on original 'bira' theme
#GitHub: ITAxReal

local _xbira_liner=" "    #Left-Right prompt connector: you can change this
local _xbira_enrprmpt=false    #Enable right prompt (time)
local _xbira_enwrtchk=true    #Enable directory writable check
local _xbira_nonwrtsym="×"    #Non-writable symbol: you can change this
local _xbira_nonwrtmod=true    #true - change dir color; false - add nonwrt symbol

function _xbira_get_space() {
    local str=$1$2
    local zero='%([BSUbfksu]|([FB]|){*})'
    local size=$(( $COLUMNS - ${#${(S%%)str//$~zero/}} - 1 ))
    echo "${(pl:$size::$_xbira_liner:)}"
}

local _xbira_dirsymbl='$(if [ -w `pwd` ]; then echo ""; else echo "$_xbira_nonwrtsym"; fi)'
local _xbira_dircolor='$(if [ -w `pwd` ]; then echo "$fg[blue]"; else echo "$fg[yellow]"; fi)'

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
if $_xbira_enwrtchk; then
    if $_xbira_nonwrtmod; then
        local current_dir="%B%{$_xbira_dircolor%}%~ %{$reset_color%}"
    else
        local current_dir="%B%{$fg[yellow]%}$_xbira_dirsymbl%{$fg[blue]%}%~ %{$reset_color%}"
    fi
else
    local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
fi

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
local _xbira_rprmpt=' $(date +%X)'
local _xbira_lprmpt="╭─${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}"
local _xbira_bprmpt="╰─%B${user_symbol}%b "
local _xbira_spaces='$(_xbira_get_space $_xbira_lprmpt $_xbira_rprmpt)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

if $_xbira_enrprmpt; then
    PROMPT="${_xbira_lprmpt}${_xbira_spaces}${_xbira_rprmpt}
${_xbira_bprmpt}"
else
    PROMPT="${_xbira_lprmpt}
${_xbira_bprmpt}"
fi
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
