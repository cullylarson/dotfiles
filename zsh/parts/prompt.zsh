gray="$fg_bold[black]"


prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR
%{%k%F{cyan}%}(%{%k%F{white}%}$%{%k%F{cyan}%})"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_hg
  prompt_newline
  prompt_end
}

cjl_rprompt() {
    echo "%{%k%F{$gray}%}$(cjl_prompt_time)"
}

cjl_prompt_time() {
    echo `date +"%T"`
}

RPROMPT='$(cjl_rprompt)'
