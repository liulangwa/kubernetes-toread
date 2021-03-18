# krew

Krew helps you discover and install kubectl plugins on your machine.


## install 
1. 确认安装了git
2. 执行下面命令安装krew

```
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
)

---

 -x; cd >   set -x; cd "$(mktemp -d)" &&
>   OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
 ARCH>   ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
>   curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
>   tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
)>   KREW=./krew-"${OS}_${ARCH}" &&
>   "$KREW" install krew
> )
++ mktemp -d
+ cd /tmp/tmp.brOrJ0vsqG
++ uname
++ tr '[:upper:]' '[:lower:]'
+ OS=linux
++ uname -m
++ sed -e s/x86_64/amd64/ -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/'
+ ARCH=amd64
+ curl -fsSLO https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz
+ tar zxvf krew.tar.gz
./LICENSE
./krew-darwin_amd64
./krew-darwin_arm64
./krew-linux_amd64
./krew-linux_arm
./krew-linux_arm64
./krew-windows_amd64.exe
+ KREW=./krew-linux_amd64
+ ./krew-linux_amd64 install krew
Adding "default" plugin index from https://github.com/kubernetes-sigs/krew-index.git.
Updated the local copy of plugin index.
Installing plugin: krew
Installed plugin: krew
\
 | Use this plugin:
 |      kubectl krew
 | Documentation:
 |      https://krew.sigs.k8s.io/
 | Caveats:
 | \
 |  | krew is now installed! To start using kubectl plugins, you need to add
 |  | krew's installation directory to your PATH:
 |  |
 |  |   * macOS/Linux:
 |  |     - Add the following to your ~/.bashrc or ~/.zshrc:
 |  |         export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
 |  |     - Restart your shell.
 |  |
 |  |   * Windows: Add %USERPROFILE%\.krew\bin to your PATH environment variable
 |  |
 |  | To list krew commands and to get help, run:
 |  |   $ kubectl krew
 |  | For a full list of available plugins, run:
 |  |   $ kubectl krew search
 |  |
 |  | You can find documentation at
 |  |   https://krew.sigs.k8s.io/docs/user-guide/quickstart/.
 | /
/

```

3. 设置环境变量

.bashrc 或 .zshrc 文件中添加下面命令

```
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

4. 测试

```
$ kubectl krew version

--- 
OPTION            VALUE
GitTag            v0.4.1
GitCommit         ffa2933
IndexURI          https://github.com/kubernetes-sigs/krew-index.git
BasePath          /home/codebee/.krew
IndexPath         /home/codebee/.krew/index/default
InstallPath       /home/codebee/.krew/store
BinPath           /home/codebee/.krew/bin
DetectedPlatform  linux/amd64

```


## ref
>https://krew.sigs.k8s.io/docs/user-guide/setup/install/