1. Bug encontrado:
Login não funcionava corretamente

Os campos email e password estavam indo para o backend vazios. 
Foi obrigatório corrigir isso antes de continuar os testes porque seria impossível testar o restante da interface sem fazer login.

Logs dos testes: 
``` 
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  ENTRAR button pressed
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  Email: 
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  Password: 
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  Error on user login, FormatException: Unexpected character (at character 1)
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  <!DOCTYPE html>
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  ^
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  
2026-06-27 20:19:34.431  7182-7182  ImeTracker              com.example.artriapp                 I  com.example.artriapp:65d80cc4: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
```

Fixes realizados:
1. InputText: virou StatefulWidget para não apagar o texto ao abrir o teclado.
2. LoginViewModel: adicionado notifyListeners() para a interface reconhecer o que foi digitado.
3. Removidos o espaço e as aspas do .env


2. Problema de Usabilidade: Na tela inicial do aplicativo após o login, a principal funcionalidade
do app (capturar os dados do paciente diariamente para análise médica) está em uma zona mais díficil de
se tocar num dispositivo móvel, por conta do princípio da thumb zone (https://www.shortcut.io/news-events/the-thumb-is-critical-for-business)

Proposta: Alteração da ordem dos botões, alterando a funcionalidade adicional (quiz sobre artrite) 
para a parte superior da tela, onde é mais díficil de tocar, e movendo os botões de "Como você está hoje"
para a parte mais acessível.
Recomendo a alteração das telas em geral para seguir esse princípio, ao invés de fixar o conteúdo do topo
para baixo, seguir a parte inferior central como sendo a localização das ações mais importantes.


3. Problema de visibilidade de erros no app: Ao clicar no botão de login não existe mensagem de senha / usuário inválido.
4. Botão de voltar não funciona, e tem telas sem botão de voltar, quando voltamos pelo gesto / botão de voltar do android, o app fecha apenas.

5. Problema na API do backend - email hardcodado para apenas printar no console
6. Selecionando mais de 2 tipos de dor, o botão de salvar some (na verdade ele ainda é acessível scrollando mas apenas no topo da tela)
```dart
// Em lib/views/user_diary/widgets/user_level_selection_with_options.dart
ConfirmationButtons(
  onButtonClicked: (action) =>
      action == ConfirmationAction.canceled ? context.pop() : null, // O 'null' aqui ignora o clique em 'Salvar'
), 
```
A correção seria simples, apenas conectar a funcionalidade já existente nos métodos de enviar relatório à interface.
7. Botão de Salvar (Dor, Fadiga, Sono, Inchaço) não funciona aparentemente 
8. Toda vez que o app é fechado precisamos relogar, o ideal seria poder guardar o estado de logado para evitar esse atrito do usuário
9. Inconsistencia de cores / design entre as páginas - o ideal é utilizar um tema constante e apenas chamar as cores desse tem

