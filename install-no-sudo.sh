#!/bin/sh

set -eu

NVIM_VERSION='0.11.5'
RIPGREP_VERSION='15.1.0'
FD_VERSION='10.4.2'

CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME:?HOME is not set}/.config}
CONFIG_DIR=$CONFIG_HOME/nvim
LOCAL_BIN=$HOME/.local/bin
LOCAL_LIB=$HOME/.local/lib/kickoff42
FONT_DIR=$HOME/.local/share/fonts/JetBrainsMonoNerdFont
WORK_DIR=''

info() {
  printf '%s\n' "[INFO] $*"
}

warn() {
  printf '%s\n' "[WARN] $*" >&2
}

die() {
  printf '%s\n' "[ERROR] $*" >&2
  exit 1
}

cleanup() {
  if [ -n "$WORK_DIR" ] && [ -d "$WORK_DIR" ]; then
    rm -rf -- "$WORK_DIR"
  fi
}

confirm() {
  printf '%s [y/N]: ' "$1"
  if ! read -r answer; then
    return 1
  fi

  case $answer in
    [Yy] | [Yy][Ee][Ss]) return 0 ;;
    *) return 1 ;;
  esac
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

require_commands() {
  missing=''
  for command_name in curl tar gzip git make cc unzip node npm python3 mktemp df awk; do
    if ! has_command "$command_name"; then
      missing="$missing $command_name"
    fi
  done

  if [ -n "$missing" ]; then
    die "Dependências obrigatórias ausentes:$missing"
  fi

  if ! has_command xz; then
    warn 'xz não foi encontrado; a instalação opcional da Nerd Font ficará indisponível.'
  fi
}

check_disk_space() {
  required_kb=1048576
  available_kb=$(df -Pk "$HOME" | awk 'NR == 2 { print $4 }')

  case $available_kb in
    '' | *[!0-9]*)
      die 'Não foi possível determinar o espaço livre em HOME.'
      ;;
  esac

  if [ "$available_kb" -lt "$required_kb" ]; then
    available_mb=$((available_kb / 1024))
    die "Espaço insuficiente em HOME: ${available_mb} MiB livres; pelo menos 1024 MiB são necessários."
  fi
}

detect_architecture() {
  machine=$(uname -m)
  case $machine in
    x86_64 | amd64)
      NVIM_ARCH='x86_64'
      RIPGREP_TARGET='x86_64-unknown-linux-musl'
      FD_TARGET='x86_64-unknown-linux-gnu'
      ;;
    aarch64 | arm64)
      NVIM_ARCH='arm64'
      RIPGREP_TARGET='aarch64-unknown-linux-gnu'
      FD_TARGET='aarch64-unknown-linux-gnu'
      ;;
    *)
      die "Arquitetura não suportada por este instalador Linux: $machine"
      ;;
  esac
}

prepare_directories() {
  mkdir -p "$LOCAL_BIN" "$LOCAL_LIB" "$HOME/.local/share/fonts"
  PATH=$LOCAL_BIN:$PATH
  export PATH

  WORK_DIR=$(mktemp -d "${TMPDIR:-/tmp}/kickoff42.XXXXXX") || die 'Não foi possível criar um diretório temporário.'
  trap cleanup 0
  trap 'exit 1' 1 2 3 15
}

resolve_url() {
  url=$1
  resolved_url=$(curl --fail --location --retry 3 --retry-delay 1 --retry-connrefused \
    --silent --show-error --head --output /dev/null --write-out '%{url_effective}' "$url") || return 1

  case $resolved_url in
    http://* | https://*) return 0 ;;
    *) return 1 ;;
  esac
}

download() {
  url=$1
  destination=$2

  info "Validando URL: $url"
  resolve_url "$url" || die "A URL de download não pôde ser resolvida: $url"
  curl --fail --location --retry 3 --retry-delay 1 --retry-connrefused \
    --show-error --progress-bar --output "$destination" "$url" || die "Falha ao baixar: $url"
}

install_binary() {
  source_file=$1
  target_name=$2
  staged_binary=$LOCAL_BIN/.$target_name.new.$$

  [ -f "$source_file" ] || die "Executável esperado não encontrado: $source_file"
  cp "$source_file" "$staged_binary"
  chmod 755 "$staged_binary"
  mv -f "$staged_binary" "$LOCAL_BIN/$target_name"
}

configure_path() {
  case ${SHELL:-} in
    */zsh) shellrc=$HOME/.zshrc ;;
    */bash) shellrc=$HOME/.bashrc ;;
    *)
      warn "Shell não suportado para alteração automática de PATH: ${SHELL:-não definido}"
      warn 'Adicione manualmente: export PATH="$HOME/.local/bin:$PATH"'
      return 0
      ;;
  esac

  if grep -Fqx 'export PATH="$HOME/.local/bin:$PATH"' "$shellrc" 2>/dev/null; then
    info "$LOCAL_BIN já está configurado em $shellrc"
    return 0
  fi

  if confirm "Adicionar $LOCAL_BIN ao PATH em $shellrc?"; then
    printf '%s\n' 'export PATH="$HOME/.local/bin:$PATH"' >> "$shellrc"
    info "PATH atualizado em $shellrc"
  else
    warn "PATH não foi alterado. $LOCAL_BIN está ativo apenas durante esta execução."
  fi
}

install_ripgrep() {
  archive=$WORK_DIR/ripgrep.tar.gz
  archive_root=ripgrep-$RIPGREP_VERSION-$RIPGREP_TARGET
  url=https://github.com/BurntSushi/ripgrep/releases/download/$RIPGREP_VERSION/$archive_root.tar.gz

  download "$url" "$archive"
  tar -xzf "$archive" -C "$WORK_DIR"
  install_binary "$WORK_DIR/$archive_root/rg" rg
  info "ripgrep $RIPGREP_VERSION instalado."
}

install_fd() {
  archive=$WORK_DIR/fd.tar.gz
  archive_root=fd-v$FD_VERSION-$FD_TARGET
  url=https://github.com/sharkdp/fd/releases/download/v$FD_VERSION/$archive_root.tar.gz

  download "$url" "$archive"
  tar -xzf "$archive" -C "$WORK_DIR"
  install_binary "$WORK_DIR/$archive_root/fd" fd
  info "fd $FD_VERSION instalado."
}

install_neovim() {
  archive=$WORK_DIR/neovim.tar.gz
  archive_root=nvim-linux-$NVIM_ARCH
  url=https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/$archive_root.tar.gz
  install_prefix=$LOCAL_LIB/nvim-$NVIM_VERSION-$NVIM_ARCH
  staged_prefix=$LOCAL_LIB/.nvim-$NVIM_VERSION-$NVIM_ARCH.new.$$
  previous_prefix=''

  download "$url" "$archive"
  tar -xzf "$archive" -C "$WORK_DIR"
  [ -x "$WORK_DIR/$archive_root/bin/nvim" ] || die 'O arquivo do Neovim não contém o executável esperado.'

  cp -R "$WORK_DIR/$archive_root" "$staged_prefix"
  if [ -e "$install_prefix" ]; then
    previous_prefix=$install_prefix.previous.$$
    mv "$install_prefix" "$previous_prefix"
  fi

  if ! mv "$staged_prefix" "$install_prefix"; then
    if [ -n "$previous_prefix" ] && [ ! -e "$install_prefix" ]; then
      mv "$previous_prefix" "$install_prefix" || true
    fi
    die 'Não foi possível ativar a instalação do Neovim.'
  fi

  link_stage=$LOCAL_BIN/.nvim-link.$$
  ln -s "$install_prefix/bin/nvim" "$link_stage"
  mv -f "$link_stage" "$LOCAL_BIN/nvim"

  if [ -n "$previous_prefix" ]; then
    rm -rf -- "$previous_prefix"
  fi

  info "Neovim $NVIM_VERSION instalado em $install_prefix"
}

install_font() {
  has_command xz || die 'xz é necessário para extrair a Nerd Font.'
  archive=$WORK_DIR/JetBrainsMono.tar.xz
  extracted_font_dir=$WORK_DIR/JetBrainsMonoNerdFont
  url=https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz

  mkdir -p "$extracted_font_dir" "$FONT_DIR"
  download "$url" "$archive"
  tar -xJf "$archive" -C "$extracted_font_dir"
  cp -R "$extracted_font_dir/." "$FONT_DIR/"

  if has_command fc-cache; then
    fc-cache -f "$HOME/.local/share/fonts"
    info 'Cache de fontes atualizado.'
  else
    warn 'fc-cache não foi encontrado; atualize o cache de fontes manualmente.'
  fi
}

ensure_runtime_tools() {
  missing=''
  has_command nvim || missing="$missing nvim"
  has_command rg || missing="$missing rg"
  if ! has_command fd && ! has_command fdfind; then
    missing="$missing fd/fdfind"
  fi

  [ -z "$missing" ] || die "Ferramentas necessárias continuam ausentes:$missing"
}

check_nvim_output() {
  output_file=$1
  verbose_file=$2

  if grep -E 'Error detected|Error in .*(init\.lua|lua/)|(^|[[:space:]])E[0-9]+:|stack traceback' "$output_file" "$verbose_file" >/dev/null 2>&1; then
    warn 'O Neovim registrou erros durante a validação:'
    grep -E 'Error detected|Error in .*(init\.lua|lua/)|(^|[[:space:]])E[0-9]+:|stack traceback' "$output_file" "$verbose_file" >&2 || true
    return 1
  fi
}

validate_config() {
  if [ ! -f "$CONFIG_DIR/init.lua" ]; then
    warn "A configuração não está instalada em $CONFIG_DIR; o teste de boot foi ignorado."
    warn 'Este script instala ferramentas locais. Use install-linux.sh ou clone o repositório para instalar a configuração.'
    return 0
  fi

  state_home=$WORK_DIR/state
  cache_home=$WORK_DIR/cache
  output_file=$WORK_DIR/nvim-boot.out
  verbose_file=$WORK_DIR/nvim-verbose.log
  mkdir -p "$state_home" "$cache_home"

  info 'Instalando/sincronizando plugins conforme o lazy-lock.json...'
  if ! NVIM_LOG_FILE=$WORK_DIR/nvim.log XDG_STATE_HOME=$state_home XDG_CACHE_HOME=$cache_home \
    nvim --headless -i NONE -V1"$verbose_file" -u "$CONFIG_DIR/init.lua" '+Lazy! sync' +qa >"$output_file" 2>&1; then
    sed -n '1,200p' "$output_file" >&2
    die 'A sincronização dos plugins falhou.'
  fi
  check_nvim_output "$output_file" "$verbose_file" || die 'A sincronização dos plugins produziu erros.'

  : > "$output_file"
  : > "$verbose_file"
  info 'Validando o boot do Neovim...'
  if ! NVIM_LOG_FILE=$WORK_DIR/nvim.log XDG_STATE_HOME=$state_home XDG_CACHE_HOME=$cache_home \
    nvim --headless -i NONE -V1"$verbose_file" -u "$CONFIG_DIR/init.lua" \
      '+lua if vim.v.errmsg ~= "" then vim.cmd("cquit 1") end' +qa >"$output_file" 2>&1; then
    sed -n '1,200p' "$output_file" >&2
    die 'O teste de boot do Neovim falhou.'
  fi
  check_nvim_output "$output_file" "$verbose_file" || die 'O teste de boot encontrou erros de inicialização.'
  info 'Boot validado sem erros.'
}

info 'Instalador no-sudo de ferramentas locais para kickoff42.nvim'
info "Este script não clona a configuração; ele instala ferramentas em $HOME/.local."
info "Versão alvo do Neovim: $NVIM_VERSION"

require_commands
check_disk_space
detect_architecture
prepare_directories
configure_path

if has_command rg; then
  info 'ripgrep já está disponível; mantendo a instalação atual.'
elif confirm "Instalar ripgrep $RIPGREP_VERSION?"; then
  install_ripgrep
else
  die 'ripgrep é necessário para as buscas da configuração.'
fi

if has_command fd || has_command fdfind; then
  info 'fd/fdfind já está disponível; mantendo a instalação atual.'
elif confirm "Instalar fd $FD_VERSION?"; then
  install_fd
else
  die 'fd ou fdfind é necessário para a busca de arquivos.'
fi

if has_command nvim && nvim --version 2>/dev/null | grep -q "NVIM v$NVIM_VERSION"; then
  info "Neovim $NVIM_VERSION já está disponível; mantendo a instalação atual."
elif confirm "Instalar Neovim $NVIM_VERSION?"; then
  install_neovim
else
  die "Neovim $NVIM_VERSION é a versão suportada por esta configuração."
fi

if confirm 'Instalar JetBrainsMono Nerd Font?'; then
  install_font
else
  info 'Instalação da Nerd Font ignorada.'
fi

ensure_runtime_tools
validate_config

info 'Instalação de ferramentas concluída.'
info "Configuração esperada em: $CONFIG_DIR"
info "Execute 'nvim' para iniciar."
