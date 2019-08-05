# Dethroner

<details><summary>01. Система контроля версий. Принципы работы с Git.</summary>
<p>
Знакомство с [git:](https://githowto.com/ru)
Канал с видеоматериалами по [git:](https://www.youtube.com/playlist?list=PLg5SS_4L6LYstwxTEOU05E0URTHnbtA0l)
</p>
</details>

<details><summary>02. Командные чаты и системы управления задачами.</summary>
<p>

### ChatOps:

В данном домашнем задании было сделано:
- Добавлен функционал использования Pull Request Template
- Интеграция Slack с github
- Интеграция Репозитория и Slack с travis

### Использование Pull Request Template
Pull Request Template - это технология github для шаблонизироания Pull Request'а (PR).
Для его использования, необходимо в корне проекта создать папку `.github`, в которую поместить шаблон с именем `PULL_REQUEST_TEMPLATE.md`

### Интеграция Slack с github
Для интеграции slack с github Для начала необходимо добавить приложение github в slack. [Инструкция:](https://get.slack.help/hc/en-us/articles/232289568-GitHub-for-Slack)
Далее, создать канал в в slack (мой канал: #995), после чего выполнить команаду:

    /github subscribe Dethroner/practice-git commits:all

### Интеграция репозитория и slack с travis
Для использования travis, необходимо в корень репозитория добавить файл `.travis.yml`, в котором описать инструкции по запуску сборки travis.
Для интеграции со slack необходимо добавить в slack приложение Travis CI, выбрать канал для уведомлений и сгенерировать токен.
Для обеспечения безопасности, данный токен необходимо зашифровать. Это можно сделать с помощью утилиты travis.
<details><summary>Инструкция по интеграции со slack (для Ubuntu 18.04):</summary>
<p>
1. Необходимо авторизоваться через github на сайте [travis:](https://travis-ci.com)
2. Удаляем стандартый ruby из ubuntu, т.к. он немного кривой.

```shell
sudo apt-get remove ruby
```

3. Установим дополнительные пакеты

```shell
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
```

4. Установим rbenv

```shell
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
```

5. Проверим, что все установилось корректно

```shell
source ~/.bashrc
type rbenv
```
На экран выведется:

```shell
Output
rbenv is a function
rbenv ()
{
    local command;
    command="${1:-}";
    if [ "$#" -gt 0 ]; then
        shift;
    fi;
    case "$command" in
        rehash | shell)
            eval "$(rbenv "sh-$command" "$@")"
        ;;
        *)
            command rbenv "$command" "$@"
        ;;
    esac
}
```

6. Усстановим ruby-build plugin. Он необходим для использования команды `rbenv install`

```shell
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

7. Выведем список того, что мы можем установить

```shell
rbenv install -l
```

8. Выберем необходимую версию руби (я выбрал 2.6.3), установим её, сделаем используемой по умолчанию и проверим, что версия установилась корректно

```shell
rbenv install 2.6.3
rbenv global 2.6.3
ruby -v
```

9. Устанавливать утилиту travis необходимо через gem (это утилита управления библиотеками и пакетами ruby). Для начала установим bundler, который необходим для управления зависимостями пакетов

```shell
gem install bundler
```

10. Теперь установим travis

```shell
gem install travis
```

11. Авторизуемся чезер утилиту travis

```shell
travis login --com
```

12. Теперь зашифруем токен с помощью утилиты travis. Мы должны находиться в папке с нашим репозиторием и в нем должен присутствовать файл `.travis.yml`

```shell
cd ~/otus/SJay3_infra
travis encrypt "devops-team-otus:<ваш_токен>#dmitriy_usachev" \
--add notifications.slack.rooms --com
```

13. travis автоматически добавит в файл `.travis.yml` шифрованый токен для уведомлений в slack. Остается только закоммитить изменения в файле.

</p>
</details>

<details><summary>Инструкция по интеграции со slack (для Windows):</summary>
<p>

Не завершена пока!!!

Устанавливаем [ruby:](https://www.ruby-lang.org/ru/documentation/installation/), [rubygems:](https://rubygems.org/pages/download) и с помощью gem установить [travis:](https://github.com/travis-ci/travis.rb#installation).  

[Авторизируемся через утилиту travis:](https://github.com/travis-ci/travis.rb#login)    
```
    travis login --com
```
[Шифруем пароль:](https://github.com/travis-ci/travis.rb#encrypt)  
```
    travis encrypt "<команда>:<токен>#<имя_канала>" --add notifications.slack.rooms --com
```

</p>
</details>


### Самостоятельная работа (Добиться успешного билда)
В файле `play-travis/test.py` была допущена ошибка в 6 строке.

```python
self.assertEqual(1 + 1, 1)
```
Эта функция всегда будет возвращать false по скольку, проверяем равнество 2-х чисел. В данном случае 2 не равно 1.
Необходимо исправить эту строку приведя её к виду:

```python
self.assertEqual(1, 1)
```

</p>
</details>

<details><summary>03. Знакомство с облачной инфраструктурой и облачными сервисами.</summary>
<p>
### Поиграемся с gcloud

Устанавливаем по [инструкции:](https://cloud.google.com/sdk/docs)

Авторизируемся в системе:
```
gcloud init
```
Создаём новый проект и переключаемся на него:
```
gcloud projects create infra-999999
gcloud config set project infra-999999
```
Сгенерируем ключи `ssh-keygen -t rsa -f ~/.ssh/gcloud-iowa-key1 -C gcloud-test-usr`,
Добавим приватный ключ в агент: `ssh-add ~/.ssh/gcloud-iowa-key1`
приведём публичную часть к виду:
```
[USERNAME]:ssh-rsa [KEY_VALUE] [USERNAME]
```
и добавим их в gcloud:

```
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=~/.ssh/gcloud-iowa-key1.pub
```

Создаём инстансы:
```
gcloud compute instances create bastion --image-project ubuntu-os-cloud --image-family ubuntu-1604-lts  --zone west1-b --preemptible --machine-type f1-micro
...
gcloud compute instances create --image-project ubuntu-os-cloud --image-family ubuntu-1604-lts  --zone west1-b --preemptible --machine-type f1-micro --no-address
```
Открываем http & https на bastion:

```
gcloud compute instances add-tags bastion --tags http-server,https-server --zone west1-b
```
[документация:](https://cloud.google.com/sdk/gcloud/reference/)

### SSH:

для удобного подключения 
добавляем в файл `~/.ssh/config` информацию о серверах:

```
Host bastion
  Hostname 34.66.166.158
  IdentityFile  ~/.ssh/gcloud-iowa-key1
  User gcloud-test-usr

Host someinternalhost
  Hostname 10.128.0.10
  IdentityFile  ~/.ssh/gcloud-iowa-key1
  ForwardAgent yes
  User gcloud-test-usr
  ProxyCommand ssh -W %h:%p gcloud-test-usr@bastion

```

теперь к someinternalhost можно подключиться командой: `ssh someinternalhost`

### VPN:

Устанавливаем [Pritunl:](https://docs.pritunl.com/docs/installation#section-linux-repositories)

Создаём правило для фаервола и применяем к хосту bastion

```
gcloud compute firewall-rules create pritunl --allow udp:15526 --target-tags pritunl
gcloud compute instance add-tags bastion --zone west1-b --tags pritunl
```

### Lets encrypt для Pritunl:

В настройках Pritunl в поле `Lets Encrypt Domain` вводим: `34.66.166.158.sslip.io`, сохраняем настройки и обращаемся по адресу `https://34.66.166.158.sslip.io`. Теперь панелька секьюрна.

</p>
</details>

<details><summary>04. Основные сервисы Google Cloud Platform (GCP)</summary>
<p>


Написаны простейшие скрипты для установки [ruby:](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/install_ruby.sh), [mogodb:](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/install_mongodb.sh), [puma_app:](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/deploy.sh) и объединены в один скрипт [startup-script:](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/startup-script.sh)  

Пример отправки скрипта в GCP хранилище:

```
gsutil mb gs://gcloud-test-user-bckt/  
gsutil cp startup-script.sh gs://gcloud-test-user-bckt/
```

Создаём правило в фаерове:

```
gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --target-tags=puma-server
```
Создаём инстанс cо скриптом автозапуска и открываем порт: 

```
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image=ubuntu-1604-xenial-v20170815a \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --zone west1-b \
  --metadata startup-script-url='wget -O -  https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/startup-script.sh | bash'

```

Инструкция [gsutil:](https://cloud.google.com/storage/docs/quickstart-gsutil)

</p>
</details>
