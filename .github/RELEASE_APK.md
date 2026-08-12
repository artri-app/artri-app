# Instruções para gerar o APK (Android)

Este documento descreve os passos para gerar o APK do app e publicar uma release no GitHub.

Opções rápidas
- Há um script helper em `scripts/build_apk.sh` que automatiza o processo (interativo).

Passos manuais
1. Perguntar ao usuário qual o número da versão será gerado o apk (ex.: `1.2.3+1`).
2. Perguntar ao usuário se o APK será gerado em `release` ou `debug`.

Após receber as informações:

1. Atualizar o campo `version:` no arquivo `pubspec.yaml` para o valor informado pelo usuário.

   Exemplo da linha no `pubspec.yaml`:
   version: 1.2.3+1

2. Rodar o comando Flutter apropriado a partir da raiz do projeto:
   - Modo release: `flutter build apk --release`
   - Modo debug: `flutter build apk --debug`

3. O APK gerado ficará em `build/app/outputs/flutter-apk/app-{modo}.apk` (onde `{modo}` é `release` ou `debug`).
   Renomeie-o para `artriapp-v{versao}-{modo}.apk`. Exemplo:
   - `artriapp-v1.2.3+1-release.apk`

4. Criar uma nova release no GitHub:
   - Tag: `v{versao}`
   - Título: `v{versao} - {modo}`
   - Usar o botão "Generate release notes" do GitHub
   - Anexar o APK renomeado e publicar a release

Observações
- O script `scripts/build_apk.sh` faz as etapas acima interativamente e atualiza `pubspec.yaml` localmente. Depois de conferir, lembre-se de commitar e dar push nas mudanças (por exemplo, a alteração de `pubspec.yaml`).
- O script não cria a release no GitHub automaticamente; faça isso pela interface do GitHub e anexe o APK.

Uso do script helper

Na raiz do projeto execute:

```bash
./scripts/build_apk.sh
```

Siga os prompts: informe a versão e o modo. O script atualizará `pubspec.yaml`, rodará o build, renomeará o APK e mostrará instruções para criar a release.
