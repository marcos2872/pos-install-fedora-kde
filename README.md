# pos-install-fedora-kde

README em Português — colecção de scripts e recursos para configurar temas e aparência no Fedora com KDE.

## Visão geral
Este repositório contém scripts de instalação e arquivos auxiliares para aplicar temas, ícones e ajustes visuais no ambiente KDE (Fedora). Os scripts são simples utilitários que automatizam a cópia/instalação de temas e configurações visuais, além de fornecer links e recursos usados durante o processo.

## Estrutura do repositório
- `KdeTahoe.sh` — Script principal para aplicar o tema/visual "Tahoe" no KDE.
- `alacritty.sh` — Script com configurações para o Alacritty (estética macOS).
- `links.txt` — Lista de links úteis (temas, ícones, tutoriais).

## Requisitos
- Sistema: Fedora (ou outra distro com KDE Plasma).
- Permissões: alguns passos podem requerer privilégios de administrador dependendo do que os scripts fazem (instalar pacotes no sistema).
- Recomendação: revise o conteúdo dos scripts antes de executar.

## Como usar
1. Abra um terminal na pasta do projeto:
   - Exemplo:
     - `cd pos-install-fedora-kde`

2. Torne os scripts executáveis (se ainda não estiverem):
   - `chmod +x KdeTahoe.sh alacritty.sh`

3. Execute o script desejado:
   - `./KdeTahoe.sh`
   - `./alacritty.sh`

Observações:
- Leia `links.txt` para referências externas e dependências que podem ser necessárias.
- Sempre verifique o conteúdo dos scripts antes de executar, especialmente se forem baixar ou instalar pacotes.

## Descrição rápida dos scripts
- `KdeTahoe.sh`
  - Automatiza a instalação/aplicação do tema "Tahoe" no KDE Plasma.
  - Pode copiar arquivos de temas para `~/.local/share/plasma/` ou diretórios similares.
- `alacritty.sh`
  - Fornece configurações (ex.: `alacritty.toml`) para deixar o terminal Alacritty com aparência semelhante ao macOS.
- `links.txt`
  - Coleção de URLs úteis (temas, ícones, tutoriais e fontes).

## Personalização
- Os scripts podem ser editados para ajustar caminhos, nomes de temas e opções específicas do usuário.
- Para mudanças persistentes no Plasma, use também as configurações do sistema (Configurações do Sistema → Aparência).

## Contribuições
Contribuições são bem-vindas:
- Abra uma issue para discutir mudanças ou problemas.
- Envie pull requests com descrições claras do que está sendo alterado.
- Mantenha scripts legíveis e com comentários quando fizer alterações significativas.

## Segurança
- Nunca execute scripts de fontes desconhecidas sem revê-los.
- Scripts que alteram arquivos de sistema podem requerer `sudo` — tenha cuidado com comandos que modificam permissões/arquivos em `/usr` ou `/etc`.

## Licença
Este repositório não possui uma licença explícita (a menos que adicionada). Se pretende usar ou redistribuir, confirme a licença com o autor ou adicione uma apropriada (por exemplo, MIT, GPL).

---
Se quiser, posso:
- Gerar um `LICENSE` (por exemplo, MIT).
- Adicionar instruções detalhadas passo-a-passo para cada script.
- Traduzir trechos técnicos para deixar o README ainda mais claro.