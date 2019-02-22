# ------------------------------------------------------------------------------
#          FILE:  shopware.plugin.zsh
#   DESCRIPTION:  oh-my-zsh shopware plugin file.
#        AUTHOR:  Pavel Livinskiy (pavel.livinskiy@gmail.com)
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

# Shopware basic command completion
_shopware_get_command_list () {
    $_comp_command1 --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_shopware_get_required_list () {
    $_comp_command1 show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_shopware () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command'\
    '*: :->args'

  case $state in
    command)
      compadd $(_shopware_get_command_list)
      ;;
    *)
      compadd $(_shopware_get_required_list)
      ;;
  esac
}

compdef _shopware bin/console

# Aliases
alias swc='bin/console'
