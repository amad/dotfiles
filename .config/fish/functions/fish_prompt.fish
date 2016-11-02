function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal
  echo -n '@'
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  set_color red
  echo -n ' ➔ '

  # PWD
  set_color normal
  set_color $fish_color_cwd
  echo -n (pwd)
  set_color normal

  echo -n ' '
  #__fish_git_prompt
  #__fish_hg_prompt
  my_git_prompt
  set_color normal
  echo

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '
  set_color normal
end
