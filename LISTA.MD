## Bugs

- Remoçao do seguinte trecho no backend
- Cliquei em esqueci minha senha e nao aconteceu nada
- Cadastrar nao funciona
- O botao de voltar do cadastrar nao funciona
- Na tela inicial ao fazer o scroll está esticando os elementos da tela
- Tela de diario dor, nao aparece o botao para confirmar as respostas
- Nenhum formulário na pagina inicial funciona
- Parte de medicamentos nao funciona ou nao está implementada
- Ao fechar app sou deslogado da minha conta
- Informacoes sobre atividade fisica botao está com overflow
- Na parte de relaxamento tanto em relaxamento guiado quanto em tecnicas de respiracao existe uma exception que nao faz a exibicao do conteudo. Provalmente é por causa que alguma mudanca feita no models do django nao foi refletida nas migrations e por causa disso a coluna especifica "column authentication_exercise.sets_reps does not exist" nao existe no banco de dados. Para resolver isso, é necessario criar uma migration para essa coluna e depois rodar o comando "python manage.py migrate" para atualizar o banco de dados com a nova coluna.
- Fui em alterar email e foi redirecionado para uma tela de erro "GoException: no routes for location: /" e tbm nao tem uma forma de voltar para a tela anterior e por causa disso fico preso nessa tela
- Fui em alterar senha e fui redirecionado para uma tela de erro "GoException: no routes for location: configuration/change-password" e tbm nao tem uma forma de voltar para a tela anterior e por causa disso fico preso nessa tela
- Algumas mensagens de erro estao expondo as falhas diretas tanto do backend quanto do frontend nas mensagens. O que pode ser considerado um problema de seguranca. Exemplo: "GoException: no routes for location: /" e "column authentication_exercise.sets_reps does not exist" como tambem um problema de UX para o usuario final. O ideal é que essas mensagens de erro sejam tratadas e exibidas de uma forma mais amigavel para o usuario final, sem expor detalhes internos do sistema.
- No login ao colocar uma senha/username incorreto, o sistema nao exibe uma mensagem de erro amigavel para o usuario final. O ideal é que o sistema exiba uma mensagem de erro clara e amigavel, informando que o login falhou devido a credenciais incorretas, sem expor detalhes internos do sistema.

```python
ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'myproject',
        'USER': 'myprojectuser',
        'PASSWORD': 'teste',
        'HOST': 'localhost',
        'PORT': '',
    }
}

STATIC_URL = 'static/'

# Default primary key field type
# https://docs.djangoproject.com/en/4.0/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
```

## Melhorias

- Colocar no gitignore o diretório `artri-app-api/artri_app_api/static/*` para não subir arquivos estáticos no repositório.
- Adicionar no README.md instruções para criar um super usuário do Django, como por exemplo: docker-compose -f docker/docker-compose-local.yml exec artriapp-django python manage.py createsuperuser
- Adicionar um botao de logout
- Melhorar os feedbacks das acoes de prenchimento de formularios, como por exemplo, quando o usuario clica em "Enviar" e o sistema demora para processar, mostrar um feedback visual de que a acao esta sendo processada.
- Na parte de medicamentos nao tem um botão para voltar a tela anterior. Dica adicionar um botão de voltar no canto superior esquerdo da tela, como nas outras telas do app.
- Ao clicar no mito ou verdade em uma das opcoes ele so me da o feedback, mas ele nao some ou troca por outro pergunta
- Na parte configuracoes colocar um botao de voltar no canto superior esquerdo da tela, como nas outras telas do app.
