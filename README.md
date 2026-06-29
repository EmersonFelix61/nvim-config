# kickoff42.nvim

Configuração pessoal e modular de Neovim, baseada no [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) e voltada principalmente ao ambiente da 42 School.

Este projeto não é associado ao kickstart.nvim. Os arquivos originais usados como referência estão em `kickstart_files/`.

## Compatibilidade

- Neovim **0.11.x**; o instalador usa a versão 0.11.5.
- Linux x86_64 ou arm64 para as ferramentas portáteis instaladas por `install.sh`.
- Windows com PowerShell e dependências instaladas pelo usuário/winget.

Neovim 0.12 ainda não é o alvo desta configuração porque a branch `master` do `nvim-treesitter` usada aqui suporta Neovim 0.10/0.11, enquanto o conjunto atual de Mason/LSP exige pelo menos 0.11.

## Estrutura

- `init.lua`: inicialização do lazy.nvim e importação dos módulos.
- `lua/vim-options.lua`: opções e atalhos globais.
- `lua/plugins/`: configurações de plugins por categoria.
- `lua/kickoff42/health.lua`: healthcheck nativo da configuração.
- `kickstart_files/`: documentação de referência do kickstart.nvim.
- `install.sh`: instala ferramentas locais; não clona a configuração.
- `install-linux.sh`: instala a configuração completa no Linux, com backup.
- `install-windows.ps1`: instala a configuração completa no Windows, com backup.

## Dependências

As dependências básicas são:

- `git`, `curl`, `tar`, `gzip`, `xz` e `unzip`;
- `make` e um compilador C;
- `node` e `npm`;
- `python3`;
- `ripgrep` (`rg`);
- `fd` ou `fdfind`;
- Neovim 0.11.x.

Reserve pelo menos 1 GiB livre em `$HOME` para o Neovim, plugins, parsers e ferramentas do Mason. O instalador interrompe antes dos downloads se não houver esse espaço.

Dependências específicas da 42:

```sh
python3 -m pip install --user c-formatter-42
python3 -m pip install --user norminette
```

Em distribuições com PEP 668 pode ser necessário usar um ambiente virtual/pipx ou seguir a orientação do gerenciador Python da distribuição. A ausência dessas duas ferramentas não impede o boot, mas desativa a formatação C pela norma e os diagnósticos da Norminette.

O `codelldb` usado pelo DAP é solicitado automaticamente ao Mason. Se ele não puder ser instalado, o Neovim continua funcionando e mostra um aviso somente ao carregar o debugger.

## Instalação Linux completa

O instalador Linux clona a branch `configs-casa`, move uma configuração existente para um diretório `nvim.backup.<timestamp>` e chama o instalador de ferramentas com versões compatíveis.

```sh
git clone --branch configs-casa https://github.com/EmersonFelix61/nvim-config /tmp/nvim-config
sh /tmp/nvim-config/install-linux.sh
```

Ele pode sugerir a instalação de dependências por `apt`, `dnf`, `pacman` ou `zypper`. Se dependências obrigatórias continuarem ausentes, a instalação é interrompida antes de substituir a configuração atual.

## Instalação sem sudo / ambiente 42

Clone primeiro a configuração no local esperado pelo Neovim:

```sh
git clone --branch configs-casa https://github.com/EmersonFelix61/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
cd "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
./install.sh
```

O `install.sh`:

- instala localmente Neovim 0.11.5, ripgrep, fd e opcionalmente JetBrainsMono Nerd Font;
- usa `~/.local` e não usa `sudo` nem gerenciador de pacotes;
- aceita `fd` ou `fdfind` já instalado;
- usa diretório temporário e limpa somente artefatos criados por ele;
- valida URLs antes dos downloads;
- sincroniza os plugins pelo `lazy-lock.json` e valida o boot;
- não clona, move ou substitui a configuração.

Todos os prompts `[y/N]` usam “não” como padrão. Se uma ferramenta obrigatória estiver ausente e sua instalação for recusada, o script encerra com erro claro.

## Instalação Windows

Execute o script em PowerShell a partir de um clone temporário:

```powershell
git clone --branch configs-casa https://github.com/EmersonFelix61/nvim-config "$env:TEMP\nvim-config"
& "$env:TEMP\nvim-config\install-windows.ps1"
```

O script verifica as dependências, mostra comandos winget para o que estiver ausente e interrompe antes do clone definitivo até que tudo esteja disponível. A configuração é instalada em `$env:LOCALAPPDATA\nvim`, com backup da configuração anterior.

## Pós-instalação

Inicie o Neovim:

```sh
nvim
```

Comandos úteis:

- `:Lazy` para verificar plugins;
- `:checkhealth kickoff42` para validar esta configuração e suas ferramentas;
- `:Mason` para verificar LSPs, formatadores e `codelldb`;
- `<space>sk` para pesquisar os atalhos;
- `:Idioma toggle` para alternar as descrições entre PT-BR e inglês.

Configure `user` e `mail` em `lua/plugins/42/42-header.lua` se esta configuração for usada por outra pessoa. Se não houver Nerd Font, altere `vim.g.have_nerd_font` para `false` em `init.lua`.

## Temas e arquivos experimentais

Tokyonight continua sendo o tema padrão. Alguns arquivos em `lua/plugins/themes/` são presets pessoais mantidos como referência e não são importados automaticamente; somente os módulos declarados em `init.lua` fazem parte da configuração ativa.

## Limitações conhecidas

- O instalador portátil é específico para Linux x86_64/arm64.
- O instalador Windows não instala dependências automaticamente; ele fornece comandos e pede uma nova execução.
- `c_formatter_42` e Norminette são opcionais porque dependem do ambiente Python do usuário.
