#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rigger -p os [--answers <>]
#

[[ -f ./functions.sh ]] && . ./functions.sh

source ../lib/os.sh

describe "os"

it_identifies_os() {
  function uname {
    echo "Darwin my-mac 14.5.0 Darwin Kernel Version 14.5.0: Wed Jul 29 02:26:53 PDT 2015; root:xnu-2782.40.9~1/RELEASE_X86_64 x86_64'"
  }

  [ $(which-os) == "darwin" ]

  function uname {
    echo "Linux"
  }

  [ $(which-os) == "linux" ]
}

it_guesses_darwin_docker() {
  function which-os {
    echo "darwin"
  }

  function boot2docker {
    if [ ${1} == config ]; then
      echo "HostIP = 192.168.59.3"
    fi
  }

  [ "$(guess-docker-ipaddr)" == "192.168.59.3" ]
}

it_guesses_linux_docker() {
  function which-os {
    echo "linux"
  }

  function ifconfig {
    case ${1} in
      docker0)
        cat <<EOF
docker0   Link encap:Ethernet  HWaddr 56:84:7a:fe:97:99
          inet addr:172.17.42.1  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::5484:7aff:fefe:9799/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
          RX packets:13502568 errors:0 dropped:0 overruns:0 frame:0
          TX packets:25243986 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:29325768023 (29.3 GB)  TX bytes:63109509841 (63.1 GB)
EOF
        ;;
      eth0)
        cat <<EOF
eth0      Link encap:Ethernet  HWaddr 0a:f6:36:c9:17:3b
          inet addr:172.31.12.102  Bcast:172.31.15.255  Mask:255.255.240.0
          inet6 addr: fe80::8f6:36ff:fec9:173b/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
          RX packets:45364696 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14414411 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:61693271101 (61.6 GB)  TX bytes:4421116289 (4.4 GB)
EOF
        ;;
    esac
  }

  [ "$(guess-docker-ipaddr)" == "172.17.42.1" ]
}

it_guesses_registry_boot2docker() {
  function which-os {
    echo "darwin"
  }

  function boot2docker {
    if [ ${1} == config ]; then
      echo "LowerIP = 192.168.59.103"
    fi
  }

  [ "$(guess-registry)" == "192.168.59.103:5000" ]
}

it_guesses_registry_linux() {
  function which-os {
    echo "linux"
  }

  function ifconfig {
    case ${1} in
      docker0)
        cat <<EOF
docker0   Link encap:Ethernet  HWaddr 56:84:7a:fe:97:99
          inet addr:172.17.42.1  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::5484:7aff:fefe:9799/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
          RX packets:13502568 errors:0 dropped:0 overruns:0 frame:0
          TX packets:25243986 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:29325768023 (29.3 GB)  TX bytes:63109509841 (63.1 GB)
EOF
        ;;
      eth0)
        cat <<EOF
eth0      Link encap:Ethernet  HWaddr 0a:f6:36:c9:17:3b
          inet addr:172.31.12.102  Bcast:172.31.15.255  Mask:255.255.240.0
          inet6 addr: fe80::8f6:36ff:fec9:173b/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
          RX packets:45364696 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14414411 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:61693271101 (61.6 GB)  TX bytes:4421116289 (4.4 GB)
EOF
        ;;
    esac
  }

  [ "$(guess-registry)" == "172.31.12.102:5000" ]
}
