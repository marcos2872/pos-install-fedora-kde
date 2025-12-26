# pos-install-fedora-kde

Coleção modular de scripts de pós-instalação para Fedora (KDE Plasma). O orquestrador principal é `install_apps.sh`, que executa scripts em `scripts/` na ordem definida.

Resumo rápido
- Instala ferramentas de desenvolvimento, editores, navegadores e personalizações do KDE.
- Projetado para ser modular: adicione/remoção de módulos via `scripts/` + `install_apps.sh`.

Pré-requisitos
- Rode o `sudo dnf upgrade` e reinicie o sistema
- Fedora Linux (KDE Plasma recomendado para módulos visuais)
- Acesso a `sudo`
- Conexão com a internet

Quickstart
```pos-install-fedora-kde/README.md#L1-6
git clone https://github.com/marcos2872/pos-install-fedora-kde.git
cd pos-install-fedora-kde
chmod +x install_apps.sh
./install_apps.sh
```

Módulos (ordem definida em `install_apps.sh`)
- `dev_tools.sh`, `rust.sh`, `node.sh`, `git_gh.sh`, `fonts.sh`, `starship.sh`, `alacritty.sh`
- `linux_toys.sh`, `zed.sh`, `antigravity.sh`, `podman.sh`, `brave.sh`, `chrome.sh`
- `claude.sh`, `mcp.sh`, `kde_tahoe.sh`, `config.sh`

Instalador remoto (sem clonar)
- Há uma versão standalone que baixa os scripts diretamente do GitHub raw e executa a sequência:
- Raw URL do instalador remoto:
  https://raw.githubusercontent.com/marcos2872/pos-install-fedora-kde/main/install_apps_remote.sh

Baixar, inspecionar e executar (recomendado)
```pos-install-fedora-kde/README.md#L1-3
curl -fsSL https://raw.githubusercontent.com/marcos2872/pos-install-fedora-kde/main/install_apps_remote.sh -o install_apps_remote.sh
chmod +x install_apps_remote.sh
./install_apps_remote.sh --fetch-only --keep-temp
```

Executar direto (use com cautela)
```pos-install-fedora-kde/README.md#L1-1
curl -fsSL https://raw.githubusercontent.com/marcos2872/pos-install-fedora-kde/main/install_apps_remote.sh | bash -s -- --no-upgrade
```

Executar apenas alguns módulos (`--modules`)
- O instalador remoto (`install_apps_remote.sh`) aceita o argumento `--modules` para executar apenas os scripts especificados (lista separada por vírgulas, incluindo `.sh`).
- Exemplo: executar apenas `dev_tools.sh` e `fonts.sh` (localmente, após baixar o remote script):
```pos-install-fedora-kde/README.md#L1-1
./install_apps_remote.sh --modules dev_tools.sh,fonts.sh
```
- Exemplo one-liner (pipe) usando `--modules` — usar com cuidado e, preferencialmente, inspecionar antes:
```pos-install-fedora-kde/README.md#L1-1
curl -fsSL https://raw.githubusercontent.com/marcos2872/pos-install-fedora-kde/main/install_apps_remote.sh | bash -s -- --modules dev_tools.sh,fonts.sh --no-upgrade
```
- Observação: a versão local `install_apps.sh` do repositório não suporta `--modules`; essa opção está disponível no instalador remoto criado para execução sem clone.

Opções úteis do instalador remoto
- `--no-upgrade` — pular `sudo dnf upgrade -y`
- `--branch BRANCH` — usar outro branch (default `main`)
- `--modules` — executar apenas módulos listados (comma-separated)
- `--fetch-only` — apenas baixar scripts para inspeção
- `--keep-temp` — manter arquivos baixados

Estrutura do repositório
- `install_apps.sh` — orquestrador (fonte da verdade)
- `scripts/` — módulos individuais (cada script deve ser executável)
- `install_apps_remote.sh` — instalador remoto (download + execução sem clone)
- `AGENTS.md` — guia para adicionar/remover módulos

Adicionar um módulo (resumido)
1. Criar `scripts/meu_modulo.sh` (idempotente, logs claros, `exit 0` em sucesso).
2. Tornar executável: `chmod +x scripts/meu_modulo.sh`.
3. Referenciar o script na posição desejada em `install_apps.sh`.
4. Testar isoladamente e depois com o instalador completo.

Boas práticas
- Evite interatividade em scripts que serão usados por instaladores automatizados.
- Forneça mensagens claras de início/fim e códigos de saída significativos.
- Use `install_apps.sh` como fonte da verdade para a ordem de execução.

Leitura recomendada
- `AGENTS.md` — procedimentos e convenções para agentes e contribuições.

Contribuições
- Abra uma issue para discutir mudanças maiores.
- Envie PRs com script testado + atualização em `install_apps.sh` e nota no README quando relevante.

Segurança
- Sempre inspecione scripts baixados antes de executar em sistemas de produção (use `--fetch-only --keep-temp`).
- Se quiser, posso adicionar verificação de checksums SHA256 para os scripts baixados pelo instalador remoto.