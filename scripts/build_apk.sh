#!/usr/bin/env bash
set -euo pipefail

# Script interativo para gerar APK
# - Pergunta versão e modo
# - Atualiza pubspec.yaml
# - Roda `flutter build apk --{mode}`
# - Renomeia APK para artriapp-v{version}-{mode}.apk

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PUBSPEC="$ROOT_DIR/pubspec.yaml"

echo "Gerador de APK - artri-app"

read -r -p "Número da versão (ex: 1.2.3+1): " VERSION
while [[ -z "${VERSION// /}" ]]; do
  read -r -p "Versão vazia — informe a versão (ex: 1.2.3+1): " VERSION
done

read -r -p "Modo (release/debug) [release]: " MODE
MODE=${MODE:-release}
if [[ "$MODE" != "release" && "$MODE" != "debug" ]]; then
  echo "Modo inválido: $MODE" >&2
  exit 1
fi

echo "Atualizando version em $PUBSPEC -> $VERSION"
if [[ ! -f "$PUBSPEC" ]]; then
  echo "Arquivo pubspec.yaml não encontrado em: $PUBSPEC" >&2
  exit 2
fi

# Substitui a linha que começa com 'version:' ou adiciona se inexistente
if grep -qE '^version:' "$PUBSPEC"; then
  # faz backup por precaução
  cp "$PUBSPEC" "$PUBSPEC.bak"
  sed -E -i "s/^version: .*/version: $VERSION/" "$PUBSPEC"
else
  echo "version: $VERSION" >> "$PUBSPEC"
fi

echo "Executando: flutter build apk --$MODE"
flutter build apk --$MODE

SRC="$ROOT_DIR/build/app/outputs/flutter-apk/app-$MODE.apk"
DEST="$ROOT_DIR/build/app/outputs/flutter-apk/artriapp-v${VERSION}-${MODE}.apk"

if [[ -f "$SRC" ]]; then
  mv -f "$SRC" "$DEST"
  echo "APK renomeado: $DEST"
else
  echo "Arquivo gerado não encontrado: $SRC" >&2
  echo "Verifique se o build do Flutter teve sucesso." >&2
  exit 3
fi

# Commit automático da alteração de versão (pubspec.yaml)

pushd "$ROOT_DIR" > /dev/null

echo "Comitando alteração em pubspec.yaml..."
git add pubspec.yaml
if git commit -m "Bump version to $VERSION" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"; then
  echo "Commit criado para pubspec.yaml"
else
  echo "Nenhuma alteração para commitar ou o commit falhou." >&2
fi

read -r -p "Deseja dar push para o remote atual? (y/N): " PUSH_ANS
PUSH_ANS=${PUSH_ANS:-N}
if [[ "$PUSH_ANS" =~ ^[Yy]$ ]]; then
  git push
fi

popd > /dev/null

cat <<EOF

Próximos passos:
1) (Opcional) Confirme no GitHub que o commit e o push foram feitos.

2) Criar uma release no GitHub:
   - Tag: v$VERSION
   - Título: v$VERSION - $MODE
   - Use o botão "Generate release notes" e anexe: $DEST

Link direto (substitua owner/repo):
https://github.com/<owner>/<repo>/releases/new?tag=v$VERSION

EOF
