# 🤝 Contribuindo para Artri App

Obrigado por querer contribuir para o Artri App! Aqui estão as diretrizes para colaborar com nosso projeto.

## 📦 Gerando APK

Se você precisa gerar um APK da aplicação, **siga obrigatoriamente as instruções em [`.github/RELEASE_APK.md`](.github/RELEASE_APK.md)**.

### Processo rápido:
1. Determine a versão desejada (ex: `1.2.3+1`)
2. Escolha o modo: `release` ou `debug`
3. Use o script helper:
   ```bash
   ./scripts/build_apk.sh
   ```
   Ou siga os passos manuais em [`.github/RELEASE_APK.md`](.github/RELEASE_APK.md)

### O que o script faz:
- ✅ Atualiza `pubspec.yaml` com a versão
- ✅ Executa o build do Flutter
- ✅ Renomeia o APK conforme convenção
- ✅ Fornece instruções para criar release no GitHub

## 🐛 Reportando Bugs

Abra uma [issue](../../issues/new) com:
- Descrição clara do problema
- Passos para reproduzir
- Versão do app e dispositivo/SO usado

## 💡 Sugestões de Funcionalidades

Abra uma [discussion](../../discussions/new) para debater ideias antes de implementar.

## 📝 Commits

Use mensagens descritivas em português ou inglês.

---

**Dúvidas?** Consulte a documentação em [`.github/RELEASE_APK.md`](.github/RELEASE_APK.md)
