#!/bin/sh

set -eu

REPOSITORY_URL='https://github.com/EmersonFelix61/nvim-config'
REPOSITORY_BRANCH='configs-casa'
CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME:?HOME is not set}/.config}
CONFIG_DIR=$CONFIG_HOME/nvim
STAGING_DIR=$CONFIG_DIR.installing.$$
BACKUP_DIR=''
MISSING_DEPENDENCIES=''
STAGING_CREATED=0
INSTALL_COMPLETE=0

cleanup() {
  if [ "$STAGING_CREATED" -eq 1 ] && { [ -e "$STAGING_DIR" ] || [ -L "$STAGING_DIR" ]; }; then
    rm -rf -- "$STAGING_DIR"
  fi

  if [ -n "$BACKUP_DIR" ] && [ ! -e "$CONFIG_DIR" ] && [ ! -L "$CONFIG_DIR" ]; then
    if mv "$BACKUP_DIR" "$CONFIG_DIR"; then
      warn 'A configuração anterior foi restaurada durante o cleanup.'
    else
      warn "Restaure manualmente o backup: $BACKUP_DIR"
    fi
  fi

  if [ "$INSTALL_COMPLETE" -eq 0 ] && [ -n "$BACKUP_DIR" ] && { [ -e "$BACKUP_DIR" ] || [ -L "$BACKUP_DIR" ]; }; then
    failed_dir=$CONFIG_DIR.failed.$$
    if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
      mv "$CONFIG_DIR" "$failed_dir"
      warn "A instalação incompleta foi preservada em: $failed_dir"
    fi
    if mv "$BACKUP_DIR" "$CONFIG_DIR"; then
      warn 'A configuração anterior foi restaurada porque a instalação não foi concluída.'
    else
      warn "Restaure manualmente o backup: $BACKUP_DIR"
    fi
  fi
}

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

check_dependencies() {
  MISSING_DEPENDENCIES=''
  for dependency in git curl tar gzip xz unzip node npm make cc python3 mktemp; do
    if has_command "$dependency"; then
      info "Dependência encontrada: $dependency"
    else
      warn "Dependência ausente: $dependency"
      MISSING_DEPENDENCIES="$MISSING_DEPENDENCIES $dependency"
    fi
  done

}

detect_package_manager() {
  if has_command apt-get; then
    PACKAGE_MANAGER='apt'
  elif has_command dnf; then
    PACKAGE_MANAGER='dnf'
  elif has_command pacman; then
    PACKAGE_MANAGER='pacman'
  elif has_command zypper; then
    PACKAGE_MANAGER='zypper'
  else
    PACKAGE_MANAGER=''
  fi
}

show_install_offer() {
  [ -n "$MISSING_DEPENDENCIES" ] || return 0

  detect_package_manager
  if [ -z "$PACKAGE_MANAGER" ]; then
    warn 'Nenhum gerenciador suportado foi encontrado (apt, dnf, pacman ou zypper).'
    return 0
  fi

  if ! has_command sudo; then
    warn "sudo não está disponível. Instale manualmente:$MISSING_DEPENDENCIES"
    return 0
  fi

  case $PACKAGE_MANAGER in
    apt)
      info 'Comando sugerido: sudo apt-get install -y git curl tar gzip xz-utils unzip nodejs npm make build-essential python3'
      if confirm 'Executar a instalação sugerida agora?'; then
        if sudo apt-get update && sudo apt-get install -y git curl tar gzip xz-utils unzip nodejs npm make build-essential python3; then
          info 'Instalação via apt concluída.'
        else
          warn 'A instalação via apt falhou. Continue instalando as dependências manualmente.'
        fi
      fi
      ;;
    dnf)
      info 'Comando sugerido: sudo dnf install -y git curl tar gzip xz unzip nodejs npm make gcc python3'
      if confirm 'Executar a instalação sugerida agora?'; then
        if sudo dnf install -y git curl tar gzip xz unzip nodejs npm make gcc python3; then
          info 'Instalação via dnf concluída.'
        else
          warn 'A instalação via dnf falhou. Continue instalando as dependências manualmente.'
        fi
      fi
      ;;
    pacman)
      info 'Comando sugerido: sudo pacman -S --needed git curl tar gzip xz unzip nodejs npm make base-devel python'
      if confirm 'Executar a instalação sugerida agora?'; then
        if sudo pacman -S --needed git curl tar gzip xz unzip nodejs npm make base-devel python; then
          info 'Instalação via pacman concluída.'
        else
          warn 'A instalação via pacman falhou. Continue instalando as dependências manualmente.'
        fi
      fi
      ;;
    zypper)
      info 'Comando sugerido: sudo zypper install -y git curl tar gzip xz unzip nodejs npm make gcc python3'
      if confirm 'Executar a instalação sugerida agora?'; then
        if sudo zypper install -y git curl tar gzip xz unzip nodejs npm make gcc python3; then
          info 'Instalação via zypper concluída.'
        else
          warn 'A instalação via zypper falhou. Continue instalando as dependências manualmente.'
        fi
      fi
      ;;
  esac
}

backup_existing_config() {
  if [ ! -e "$CONFIG_DIR" ] && [ ! -L "$CONFIG_DIR" ]; then
    return 0
  fi

  timestamp=$(date '+%Y%m%d-%H%M%S')
  BACKUP_DIR=$CONFIG_DIR.backup.$timestamp
  if [ -e "$BACKUP_DIR" ] || [ -L "$BACKUP_DIR" ]; then
    BACKUP_DIR=$BACKUP_DIR.$$
  fi

  mv "$CONFIG_DIR" "$BACKUP_DIR"
  info "Configuração existente movida para: $BACKUP_DIR"
}

install_config() {
  has_command git || die 'git é necessário para clonar a configuração.'
  mkdir -p "$CONFIG_HOME"

  if [ -e "$STAGING_DIR" ] || [ -L "$STAGING_DIR" ]; then
    die "O diretório temporário já existe: $STAGING_DIR"
  fi

  info "Clonando $REPOSITORY_URL, branch $REPOSITORY_BRANCH..."
  STAGING_CREATED=1
  if ! git clone --branch "$REPOSITORY_BRANCH" --single-branch "$REPOSITORY_URL" "$STAGING_DIR"; then
    warn 'O clone falhou; o diretório parcial será removido.'
    die 'A configuração atual não foi alterada.'
  fi

  backup_existing_config
  if ! mv "$STAGING_DIR" "$CONFIG_DIR"; then
    warn 'Não foi possível ativar a nova configuração.'
    if [ -n "$BACKUP_DIR" ] && [ ! -e "$CONFIG_DIR" ]; then
      if mv "$BACKUP_DIR" "$CONFIG_DIR"; then
        warn 'A configuração anterior foi restaurada.'
      else
        warn "Restaure manualmente o backup: $BACKUP_DIR"
      fi
    fi
    die 'Instalação interrompida.'
  fi

  info "Configuração instalada em: $CONFIG_DIR"
}

install_tools() {
  [ -x "$CONFIG_DIR/install.sh" ] || die "Instalador de ferramentas não encontrado: $CONFIG_DIR/install.sh"
  info 'Executando o instalador de ferramentas com versões compatíveis...'
  "$CONFIG_DIR/install.sh"
}

trap cleanup 0
trap 'exit 1' 1 2 3 15

check_dependencies
show_install_offer
check_dependencies
[ -z "$MISSING_DEPENDENCIES" ] || die "Dependências obrigatórias continuam ausentes:$MISSING_DEPENDENCIES"
install_config
install_tools
INSTALL_COMPLETE=1
