function which-os {
  local uname_result="$(uname -a)"

  if [[ "${uname_result}" =~ "Darwin" ]]; then
    echo "darwin"
  elif [[ "${uname_result}" =~ "Linux" ]]; then
    echo "linux"
  else
    echo "windows"
  fi
}

function guess-docker-ipaddr {
  if [ -n "${HOST_IPADDR:-}" ]; then
    echo ${HOST_IPADDR}
    return 0
  fi

  case $(which-os) in
    darwin)
      boot2docker config | grep "HostIP" | cut -d = -f 2 | xargs
      ;;
    linux)
      ifconfig docker0 | grep 'inet ' | awk '{print $2}' | sed 's/addr://'
      ;;
  esac
}

function guess-registry-ipaddr {
  if [ -n "${HOST_IPADDR:-}" ]; then
    echo ${HOST_IPADDR}
    return 0
  fi

  case $(which-os) in
    darwin)
      if command -v boot2docker &> /dev/null; then
        # xargs trims leading/trailing whitespace
        boot2docker config | grep "LowerIP" | cut -d = -f 2 | xargs
      else
        rerun_die "Could not determine registry ip address."
      fi
      ;;
    linux)
      ifconfig eth0 | grep 'inet ' | awk '{print $2}' | sed 's/addr://'
      ;;
  esac
}

function guess-registry {
  echo "$(guess-registry-ipaddr):5000"
}
