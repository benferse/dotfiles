# Agency managed PATH
if [ -d "$HOME/.config/agency/CurrentVersion" ]; then
  case ":${PATH}:" in
    *":$HOME/.config/agency/CurrentVersion:"*) ;;
    *) export PATH="$HOME/.config/agency/CurrentVersion:${PATH}" ;;
  esac
fi
