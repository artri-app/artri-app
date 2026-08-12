# 📋 Regras do Repositório

Este documento define as regras e processos que todos os colaboradores devem seguir.

## 🚀 Gerando APK para Release

### ⚠️ OBRIGATÓRIO

Sempre que alguém quiser gerar um APK da aplicação, **DEVE seguir as instruções em [`.github/RELEASE_APK.md`](.github/RELEASE_APK.md)**.

**Resumo do processo:**

1. **Defina a versão** (ex: `1.2.3+1`)
2. **Escolha o modo:** `release` ou `debug`
3. **Execute o script helper:**
   ```bash
   ./scripts/build_apk.sh
   ```
   Ou siga os [passos manuais](.github/RELEASE_APK.md)

4. **Crie uma release no GitHub** com o APK renomeado anexado

### Convenção de nomeação
```
artriapp-v{versao}-{modo}.apk
```

Exemplos:
- `artriapp-v1.2.3+1-release.apk`
- `artriapp-v0.3.0-debug.apk`

### Validação

Para PR relacionadas a APK:
- [ ] Versão em `pubspec.yaml` foi atualizada
- [ ] O APK foi renomeado corretamente
- [ ] Release foi criada no GitHub
- [ ] APK foi anexado à release

---

## 🤝 Contribuições Gerais

Leia [CONTRIBUTING.md](../CONTRIBUTING.md) para diretrizes de contribuição.

## 🐛 Issues

- Use [labels apropriadas](../../labels)
- Forneça informações detalhadas do bug
- Inclua versão do app, dispositivo e SO

## 📚 Documentação

- Mantenha a documentação atualizada
- Documente novas funcionalidades
- Use markdown para formatação

---

**Dúvidas?** Abra uma [discussion](../../discussions/new)
