# Jogo Eduardo

Jogo 2D feito em Godot 4.7.1. Inimigos surgem aleatoriamente ao redor da arena, perseguem o jogador e são eliminados pelos tiros.

## Controles

- `W`, `A`, `S`, `D`: mover o jogador
- Mouse: mirar
- Botão esquerdo do mouse: atirar
- Celular: direcional na tela para mover; toque na arena para mirar e atirar

## Abrir o projeto

Abra `project.godot` com Godot 4.7.1 ou execute:

```bash
godot --path .
```

## Exportar para Web

Com os templates de exportação Web do Godot 4.7.1 instalados:

```bash
godot --headless --path . --export-release Web docs/index.html
```

O GitHub Pages publica automaticamente o conteúdo de `docs/` a cada push na branch `main`.
# jogo-eduardo
