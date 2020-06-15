# Dethroner

[![Build Status](https://travis-ci.org/Dethroner/practice-git.svg?branch=master)](https://travis-ci.org/Dethroner/practice-git)
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)

[Dockerhub](https://hub.docker.com/u/dethroner)

<details><summary>01. Система контроля версий. Принципы работы с Git.</summary>
<p>

## Git:

Знакомство с git [Инструкция](https://githowto.com/ru).

Канал с видеоматериалами по [git](https://www.youtube.com/playlist?list=PLg5SS_4L6LYstwxTEOU05E0URTHnbtA0l).
### 1. Установка в Debian из исходников:
```shell
cd /usr/src
apt install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev make binutils gcc
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz
tar -zxf git-2.9.5.tar.gz
cd git-2.9.5
make prefix=/usr/local all
make prefix=/usr/local install
```
### 2. Первые шаги после установки в Linux:
```
git config --global user.name "Your Name"
git config --global user.email "your_email@whatever.com"
git config --global core.editor nano
git config --global merge.tool vimdiff
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.quotepath off
```
и в Windows:
```
git config --global user.name "Your Name"
git config --global user.email "your_email@whatever.com"
git config --global core.autocrlf true
git config --global core.safecrlf false
```
Просмотреть настройки:
```
git config --list
```
### 3. Небольшой [тюнинг](https://natenka.gitbook.io/pyneng/part_i/02_git_github/git_basics/git_basics_bash_status) для Linux, отображает статуса репозитория в приглашении.

### 4. Работа с Git:
#### 1. Клонирую свой репозиторий (создан ранее через сайт) в домашний каталог:
```
git clone https://github.com/Dethroner/practice-git
```
#### 2. Перехожу в склонированную папку и инициализирую репозиторий:
```
cd ./practice-git
git init
```
#### 3. Копирую файл LICENSE (MIT Licence) в папку и добавляю под версионный контроль:
```
git add .
git commit -m 'Add LICENSE'
git push origin
```
запросит данные для подключения ввожу имя и пароль:
```
Username for 'https://github.com': Dethroner
Password for 'https://Dethroner@github.com':
```
#### 4. Если репозиторий ведут несколько человек или с разных устройств, перед началом изменений нужно запросить крайнюю версию репозитория:
```
git pull origin
```
 
</p>
</details>

<details><summary>02. Командные чаты и системы управления задачами.</summary> 
<p>

## ChatOps:

В данном домашнем задании было сделано:
- Добавлен функционал использования Pull Request Template
- Интеграция Slack с github
- Интеграция Репозитория и Slack с travis

### Использование Pull Request Template
Pull Request Template - это технология github для шаблонизироания Pull Request'а (PR).
Для его использования, необходимо в корне проекта создать папку `.github`, в которую поместить шаблон с именем `PULL_REQUEST_TEMPLATE.md`
### Интеграция Slack с github
Для интеграции slack с github Для начала необходимо добавить приложение github в slack [инструкция](https://get.slack.help/hc/en-us/articles/232289568-GitHub-for-Slack).
Далее, создать канал в в slack (мой канал: #995), после чего выполнить команаду:
```
 /github subscribe Dethroner/practice-git commits:all
 ```
### Интеграция репозитория и slack с travis
Для использования travis, необходимо в корень репозитория добавить файл `.travis.yml`, в котором описать инструкции по запуску сборки travis.
Для интеграции со slack необходимо добавить в slack приложение Travis CI, выбрать канал для уведомлений и сгенерировать токен.
Для обеспечения безопасности, данный токен необходимо зашифровать. Это можно сделать с помощью утилиты travis.
<details><summary>Инструкция по интеграции со slack (для Ubuntu 18.04):</summary>
<p>
1. Необходимо авторизоваться через github на сайте [travis](https://travis-ci.com).
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

</p>
</details>

<details><summary>Инструкция по интеграции со slack (для Windows):</summary>
<p>

Устанавливаем [ruby](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.5.5-1/rubyinstaller-devkit-2.5.5-1-x64.exe) и с помощью gem установить [travis](https://github.com/travis-ci/travis.rb#installation).  

</p>
</details>

### Шифруем информацию о чате
[Авторизируемся через утилиту travis](https://github.com/travis-ci/travis.rb#login). 
```shell
travis login --com
```
Или через плагин Travis в Slack. В плагине же будет сформирован токен и предложены команды для подключения к каналу в том числе команда для шифрования токена.
[Шифруем токен](https://github.com/travis-ci/travis.rb#encrypt) с помощью утилиты travis. Команду нужно запускать внутри репозитория и в нем должен присутствовать файл `.travis.yml`.
```shell
cd ~/Dethroner/practice-git
travis encrypt "testlanworkspace:<ваш_токен>#995" --add notifications.slack.rooms --com
```
travis автоматически добавит в файл `.travis.yml` шифрованый токен для уведомлений в slack. Остается только закоммитить изменения в файле.
### Проверка работы Travis
Проверить работу можно дописав код в [.travis.yml](https://raw.githubusercontent.com/Dethroner/practice-git/master/.travis.yml) перед шифрованым токеном.
На странице Travis-а содержится информация о статусе последнего билда. Нажмите на статусные иконки один раз. Выберите тип Markdown и скопируйте текст для вставки.Вставьте скопированный текст в начало файла README.md и обновите запушьте измнения на GitHub.
Можно вновь попытаться поломать тесты, чтобы посмотреть, как обновляются статусные иконки.
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

## Google Cloud Platform (GCP):

В данном домашнем задании было сделано:
- Создание учетной записи в GCP
- Установка gcloud
- Создание ssh ключей для инстансов ВМ
- Создание инстансов ВМ из веб-интерфейса
- Подключение по ssh через бастион-хост
- Подклчюение по vpn через бастион-хост
- Настройка ssl сертификатов для vpn-сервера

### Создание учетной записи в GCP
Регистрация производится по ссылке: https://cloud.google.com/free/
Лучше всего использовать отдельный аккаунт Gmail.
### Установка gcloud
Устанавливаем по [инструкции](https://cloud.google.com/sdk/docs).
[Инструкция по установке в Linux](https://cloud.google.com/sdk/docs/#deb)
Авторизируемся в системе:
```
gcloud init
gcloud auth application-default login
```
Создаём новый проект и переключаемся на него:
```
gcloud projects create infra-999999
gcloud config set project infra-999999
```
### Создание ssh ключей и добавление их в GCP
#### для Windows
Можно сгенерировать ключи с помощью puttygen
#### для Linux
Генерируем ключ для пользователя *gcloud-user*

```shell
ssh-keygen -t rsa -f ~/.ssh/gcloud -C gcloud-user -P ""
```
#### добавление ключей в GCP
Заходим в Compute Engine -> Metadata -> SSH Keys.
Добавляем туда публичные ключи
или добавим их в gcloud:
```
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=~/.ssh/gcloud.pub
```
### Создаём инстансы
```
gcloud compute instances create bastion --image-project ubuntu-os-cloud --image-family ubuntu-1604-lts  --zone west1-b --preemptible --machine-type f1-micro
...
gcloud compute instances create --image-project ubuntu-os-cloud --image-family ubuntu-1604-lts  --zone west1-b --preemptible --machine-type f1-micro --no-address
```
Открываем http & https на bastion:
```
gcloud compute instances add-tags bastion --tags http-server,https-server --zone west1-b
```
[Документация](https://cloud.google.com/sdk/gcloud/reference/).
### Подключение по [SSH](https://habr.com/ru/post/122445/)
#### Подключение с нестандартным ключем:
`ssh -i <path_to_key> <username>@<host>`
#### Настройка форвардинга ssh
Настраиваем формаврдинг с локальной машины.
Сначала запустим ssh-агент `eval "$(ssh-agent)"`
Теперь добаваил ключ в агент: `ssh-add ~/.ssh/gcloud`
#### Подключение через бастион-хост одной командой
Принцип следующий: Мы подключаемся через proxycommand к бастиону (35.228.209.11), после чего, тот проксирует нас на целевой сервер someinternalhost (10.166.0.5). Ключ `-W %h:%p` означает, что стандартный ввод и вывод будут форвардится на хост `%h` и порт `%p`. Эти переменные будут зарезолвены указаным хостом для подключения и портом.
```shell
ssh gcloud@10.166.0.5 -o "proxycommand ssh -W %h:%p -i ~/.ssh/gcloud gcloud@35.228.209.11"
```
#### Подключение через бастион-хост с использованием алиаса (*)
Для создания алиаса необходимо создать файл `~/.ssh/config` в котором прописать
``` shell
Host someinternalhost
  Hostname 10.166.0.5
  ForwardAgent yes
  User gcloud-user
  ProxyCommand ssh -W %h:%p -i ~/.ssh/gcloud gcloud@35.228.209.11

```
Или в случае, если версия openssh > 7.4, то можно использовать директиву ProxyJump. В таком случае конфиг будет выглядеть так:
```shell
Host someinternalhost
  Hostname 10.166.0.5
  ForwardAgent yes
  User gcloud-user
  ProxyJump gcloud@35.228.209.11
```
Теперь, что бы подключиться через бастион-хост нужно выполнить:
``` shell
ssh someinternalhost
```
### Подключение через VPN
#### Установка и первоначальная настройка VPN-сервера
Разрешим http/https трафик на машине bastion и установим vpn-server [Pritunl](https://pritunl.com/)
```shell
cat <<EOF> setupvpn.sh
#!/bin/bash
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list
echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get --assume-yes update
apt-get --assume-yes upgrade
apt-get --assume-yes install pritunl mongodb-org
systemctl start pritunl mongod
systemctl enable pritunl mongod
EOF
```
Выполним созданный скрипт. В результате мы получим установленный сервер pritunl и базу mongodb
```shell
sudo bash setupvpn.sh
```
Для настройки vpn необходимо через браузер зайти на https://<bastion_address>/setup и выполнить инструкции на экране. Далее, необходимо:
 - залогиниться (pritunl/pritunl), добавить организацию, тестового пользователя, сервер. 
 - Добавить сервер в организацию. 
 - Создать правило файрвола в GCP для порта на котором запустился сервер.
 - Добавить тег правила в инстанс ВМ
Теперь необходимо установить openvpn-client на машину, с которой будет производиться подключение.
#### Установка и настройка openvpn клиента на рабочую машину
##### Для Ubuntu 18
Установим openvpn
```shell
    sudo apt update
    sudo apt install openvpn
```
Скачиваем с сервера файл `*.ovpn`. Для этого необходимо нажать на иконку с цепочкой у пользователя, профиль которого мы хотим скачать, копируем ссылку из первого окошка и выполняем:
```shell
wget https://35.228.209.11/key/AwBbkqSZvBaMUZ8hC5YtcR7i85MAyAG5.tar --no-check-certificate
tar -xvf AwBbkqSZvBaMUZ8hC5YtcR7i85MAyAG5.tar
```
В результате в текущей директории мы получим ovpn-файл.
Запускаем соединение с vpn-сервером:

```shell
sudo openvpn --config <path_to_ovpn_file>
```
Предложит ввести логин и пароль. Используем логин test и PIN в качестве пароля.
Если на экране появится строка `Initialization Sequence Completed` значит соединение успешно установлено.
#### Проверка работоспособности VPN-сервера
Для проверки подключимся с рабочей машины к vpn-серверу и попробуем зайти по ssh на someinternalhost (Заходить нужно с другой консоли):

```shell
ssh -i ~/.ssh/gcloud gcloud@10.166.0.5
```
### Настройка сертификата для панели управления Pritunl (*)
Используемые сервисы:
- sslip.io
- Lets Encrypt
Для использования сервиса [sslip.io](https://sslip.io) достаточно обратиться к сервису с запросом по специальному dns-имени и он вернет в ответ ip-адрес. Работает это так: У нас есть внешний сервис на ip 35.228.209.11. Мы в браузере набираем 35-228-209-11.sslip.io и попадаем на веб-интерфейс нашего сервиса.
Для использования Lets Encrypt необходимо зайти в веб-интерфейс pritunl используя домен от sslip.io. Далее перейти в настройки и в поле Lets Encrypt Domain ввести адрес домена sslip.io.
После сохранения настроек страница обновится и подцепится валидный ssl-сертификат от Lets Encrypt
p.s. Возможно потребуется дополнительная установка certbot, который генерит сертификаты. Делается это следующим образом:
```shell
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo add-apt-repository universe
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt-get update

    sudo apt-get install certbot 
```

</p>
</details>

<details><summary>04. Основные сервисы Google Cloud Platform (GCP).</summary>
<p>

В данном домашнем задании было сделано:
- Установка тестового приложения с настройкой инфраструктуры
- Создание bash-скриптов для установки приложения и настройки инфраструктуры
- Создание startup script
- Создание правила фаервола с помощью gcloud
### Создание ВМ через gcloud
```shell
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
```
### Создание bash-скриптов для установки приложения и настройки инфраструктуры
Написаны простейшие скрипты для установки [ruby](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/install_ruby.sh), [mongodb](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/install_mongodb.sh), [puma_app](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/deploy.sh) и объединены в один скрипт [startup-script](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/startup-script.sh). 
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
Инструкция [gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

</p>
</details>


<details><summary>05. Работа с образами ОС.</summary>
<p>

## Packer:

В данном домашнем задании было сделано:
- Установка packer
- Предоставление доступа к GCP через ADC
- Создание образа ВМ через packer (fry подход)
- Создание полного образа ВМ (bake подход) (*)
- Создание скрипта создания ВМ из собранного образа (*)

### Установка packer
Для установки packer, необходимо скачать дистрибутив по [ссылке](https://www.packer.io/downloads.html), распаковать архив в папку `~/packer/`.
Далее, необходимо добавить путь к утилите packer в PATH. В `~/.bashrc` необходимо добавить строку в конец файла:
```shell
export PATH=$PATH:~/packer/
```
Применим изменения, что бы не перелогиниваться с новой сессией:
```shell
source ~/.bashrc
```
### Предоставление доступа к GCP через ADC
Для того, что бы packer мог подключаться к google cloud необходимо ему разрешить доступ. Это можно сделать через Application Default Credentials (ADC). Это позволяет приложениям работать с АПИ гугла используя credentals пользователя авторизованного через gcloud.
Выполним команду:
```shell
gcloud auth application-default login
```
### Создание образа ВМ через packer
Для работы через packer создадим файл шаблона ubuntu16.json, в котором будет описана конфигурация создаваемого нами образа.
Основные секции этого файла:
- variables - указываются переменные, которые имеют значения по умолчанию и не обязательны.
- builders - секция сборки образа. Для GCP тут указываются параметры временной виртуальной машины, на основе которой будет создан наш образ, а так же имя и семейство нашего образа
- provisioners - секция в которой указываются, что необходимо выполнить после запуска виртуальной машины, к примеру, установить необходимый софт.
Так же, создадим отдельный файл variables.json, в котором переопределим дефалтовые переменные, а так же обязательные переменные, которые нельзя определять в ubuntu16.json.
Поскольку данный файл нельзя пушить в репозиторий, т.к. он может содержать секреты, то создадим файл varibles.json.example, в котором опишем пример используемых параметров.
Для проверки корретности файла шаблона можно использовать:
```shell
packer validate ubuntu16.json
```
Что бы пакер зарезолвил все переменные, необходимо использовать синтаксис:
```shell
packer validate -var-file=variables.json ubuntu16.json
```
Если валидация прошла успешно, то запустить сборку можно командой:
```shell
packer build -var-file=variables.json ubuntu16.json
```
### Создание полного образа ВМ (bake подход) (*)
Для практики подхода immutable infrastructure, необходимо использовать подход к созданию образа именуемый bake.
Для этого был создан файл immutable.json, из которого packer собрал полный образ с уже установленным и добавленным в автозапуск приложением.
В качестве базового образа был выбран образ reddit-base, созданный на прошлом шаге. После скачивания git-репозитория и установки приложения, выполняется копирование подготовленного systemd unit во временную директорию, после чего юнит перемещается в целевую директорию и активируется автозапуск при загрузке.
Юнит запускает приложение из-под пользователя, поэтому, если используется другой пользователь, то его + пути к скачанному репозиторию необходимо поменять, перед пересборкой образа.
### Создание скрипта создания ВМ из собранного образа (*)
Для более быстрого создания и запуска ВМ из образа reddit-full был написан скрипт [create-reddit-vm.sh](https://raw.githubusercontent.com/Dethroner/practice-git/master/config-scripts/create-reddit-vm.sh), помещенный в директорию config-scripts.

</p>
</details>

<details><summary>06. Практика IaС. Знакомство с Terraform.</summary>
<p>

## Terraform:

В данном домашнем задании будет сделано:
- Установка terraform
- Организация структуры проекта в terraform
- Запуск проекта и основные команды
- Работа с ssh-ключами и пользователями в terraform (*)
- Созданние нескольких ресурсов и балансирование нагрузки (**)

### Установка terraform
Для установки terraform необходимо скачать дистрибутив с оффициального сайта [terraform](https://www.terraform.io/downloads.html). Т.к. домашнии задания адаптированы для версии 0.11.11, а последняя версия > 12, то для скачивания старой версии терраформа, необходимо найти её по следующей [ссылке](https://releases.hashicorp.com/terraform/0.11.11/). Скачанный архив необходимо распаковать в папку `~/terraform/`.
Далее, необходимо добавить путь к утилите packer в PATH. В `~/.bashrc` необходимо добавить строку в конец файла:
```shell
export PATH=$PATH:~/terraform/
```
Применим изменения, что бы не перелогиниваться с новой сессией:
```shell
source ~/.bashrc
```
### Структура проекта в terraform
При запуске терраформа, он будет считывать все файлы `.tf` из текущей директории. Структура проекта состоит из следующих файлов:
- main.tf
- variables.tf
- outputs.tf
- variables.tfvars
#### main.tf
Основной файл проекта. В нем указывается версия terraform, на которой будет работать проект, провайдер ресурсов, сами ресурсы. Внутри ресурсах могут быть указаны провижионеры. 
[Ссылка на документацию](https://www.terraform.io/docs/cli-index.html): Провизионеры, ресурсы, провайдеры и т.д.
#### variables.tf
В данном файле инициализируются переменные. У них указывается тип, описание, и значение по умолчанию (не обязательно).
Пример:
```
variable "region" {
  type        = "string"
  description = "region"
  default     = "europe-west1"
}
```
#### outputs.tf
В этом файле указываются выходные переменных, которые терраформ получает во время выполнения стейта. Эти переменные можно потом использовать для различных систем конфигурации.
#### variables.tfvars
Если в папке с проектом есть файл variables.tfvars то он тоже считывается автоматически терраформом. В противном случае, необходимо запускать терраформ с ключем `-var-file`, куда передавать путь к файлу с переменными.
В этом файле содержатся значения переменных, которые были определены в файле variables.tf.
Переменные указываются в формате ключ=значение.
### Запукс проекта и основные команды
Для запуска dry-run, необходимо выполнить команду
```shell
terraform plan
```
Терраформ покажет планируемые изменения, которые произойдут в инфраструктуре.
Для применения конфигурации, необходимо выполнить команду:
```shell
terraform apply
```
Терраформ покажет изменения и запросит подтверждение выполнения стейта. Для того, что бы терраформ не запрашивал подтверждение, а начинал выполнять стейт сам, необходимо запускать терраформ со специальным ключем:
```shell
terraform apply -auto-approve=true
```
При работе терраформ создает специальные файлы с расширением `.tfstate`. В них он хранит состояние применения конфигурации. Важно, что терраформ смотрит состояние только по этим файлам и не подключается к провайдеру, поэтому при использовании терраформа не следует править конфигурацию руками. Только через код терраформа.
Для просмотра и поиска по tfstate файлам, можно использовать команду:
```shell
terraform show
```
Если выходные переменные были добавлены после применения стейта, то занести в них информацию можно с помощью команды:
```shell
terraform refresh
```
Посмотреть значения выходных переменных можно командой:
```shell
terraform output
```
Для того, что бы терраформ заного пересоздал ресурс необходимо использовать команду:
```shell
terraform taint <тип_ресурса.имя_ресурса>
```
Это может потребоваться, к прирмеру, когда мы изменили провижионеры в ресурсе или добавили новых провижионеров, т.к. они запускаются только при создании ресурса или при удалении.
Для удаления ресурса используется следующая команда:
```shell
terraform destroy
```
### Работа с ssh-ключами и пользователями в terraform (*)
Для добавления ssh-ключа в метадату проекта, необходимо использовать отдельный ресурс `google_compute_project_metadata_item`. Этот ресурс добавляет 1 единицу метаданных в проект. Но для того, что бы можно было добавиь ssh ключ, необходимо указать **ssh-keys** в качестве значения у параметра **key**.
```
resource "google_compute_project_metadata_item" "appuser1" {
  key = "ssh-keys"
  value = "appuser1:${file(var.public_key_path)}"
  project = "${var.project}"
}
```
Для добавления сразу нескольких метаданных или нескольких ssh ключей, необходимо использовать другой ресурс: `google_compute_project_metadata`. Пример добавления нескольких ключей:
```
resource "google_compute_project_metadata" "many_keys" {
  project = "${var.project}"
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
```
Нельзя использовать сразу 2 этих ресурса, т.к. терраформ будет затирать данные, добавленные одним из ресурсов. Так же, добавленные через веб-интерфейс ключи тоже будут удалены, если терраформ управляет метадатой.

### Работа с Terraform
1. Создать папку terraform перейти в нее. Создать файл main.tf [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/1)
```
terraform {
  # версия terraform
  required_version = "~> 0.11.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"
  # id проекта
  project = "west-249106"
  region = "europe-west1-b"
}
```
2. Загрузить провайдер GCP:
```shell
terraform init
```
3.В файле main.tf после определения провайдера, добавить ресурс для создания инстанса VM в GCP:
```
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base-1565159335"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
}
```
4. Выполнить  команду  планирования  изменений.
5. Создать VM согласно описанию.
6. После удачного выполнения, посмотреть внешний IP:
```shell
terraform show | grep nat_ip
```
7. Добавить секци. с SSH key:
```
resource "google_compute_instance" "app" {
...
metadata {
    sshKeys = "appuser:${file("~/.ssh/appuser.pub")}"
  }
...
} 
```
8. Проверить SSH подключение:
```shell
ssh appuser@<внешний_IP>
```
9. Создать файл outputs.tf в директории terraform со следующим содержимым
```
output "app_external_ip" {
  value = "${google_compute_instance.app.network_interface.0.access_config.0.nat_ip}"
}
```
Используем команду для примениея и обновления
```shell
terraform refresh
```
10. Определить правило фаервола для нашего приложения. Добавим в main.tf следущий ресурс:
```
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
# Название сети, в которой действует правило
  network = "default"
# Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
# Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
# Правило применимо для инстансов с тегом …
  target_tags = ["reddit-app"]
}
```
Планируем и применяем изменения.
```shell
terraform plan
terraform apply
```
11. Добавить тег инстансу VM:
```
resource "google_compute_instance" "app" {
...
tags = ["reddit-app"]
```
Планируем и применяем изменения.
12. Определить параметры подключения провиженеров к VM.
```
  connection {
    type     = "ssh"
    user     = "appuser"
    agent = false
    private_key = "${file("~/.ssh/appuser")}"
  }
```
13. Внутрь ресурса, содержащего описание VM, вставить секцию провижинера типа ﬁle, который позволяет копировать содержимое файла на удаленную машину.
```
provisioner "file" {
 source      = "files/puma.service"
 destination = "/tmp/puma.service"
}
```
14. Добавить еще один провиженер для запуска скрипта деплоя приложения на создаваемом инстансе.
```
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
```
Планируем и применяем изменения.

15. Проверить работу перейдя по ссылке в браузере:
```
<IP_nat>:9292
```
### Параметризация переменных
1. [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/2) того как использовать входную переменную ее нужно сначала определить в одном из конфигурационных файлов. Создать для этих целей еще один конфиг файл variables.tf
```
variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default = "europe-west1-b"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
} 
```
2. Теперь можем использовать input переменные в определении других ресурсов. Чтобы получить значение пользовательской переменной внутри ресурса используется синтакс “${var.var_name}”.
Определить соответствующие параметры ресурсов main.tf через переменные:
```
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}
...
boot_disk {
  initialize_params {
    image = "${var.disk_image}"
  }
}
...
metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }
...

```
3. Определить переменные используя специальный файл terraform.tfvars, из которого тераформ загружает значения автоматически при каждом запуске. 
```
project = "Project_ID"
public_key_path = "~/.ssh/appuser.pub"
disk_image = "reddit-base-1565159335"
```
4. Планируем и применяем изменения.

5. Проверить работу перейдя по ссылке в браузере:
```
<IP_nat>:9292
```

</p>
</details>

<details><summary>07. Продолжение знакомства с Terraform.</summary>
<p>

В данном домашнем задании было сделано:
- Импорт существующего правила firewall
- Структуризация ресурсов
- Созданием модулей
- Параметризация модуля vpc
- Создание окружений stage и prod
- Работа с реестром модулей
- Хранение стейт-файлов в удаленном бекэнде (*)

### Импорт существующего правила firewall
По заданию, мы должны создать правило для фаервола, разрешающее подключение по ssh. Но в GCP оно уже создано по умолчанию. Однако, что бы мы могли управлять этим правилось через terraform, его нужно описать в main.tf, после чего выполнить импорт, что бы терраформ знал, что такое правило уже существует в GCP

```shell
terraform import google_compute_firewall.firewall_ssh default-allow-ssh
```
#### Взаимосвязи ресурсов.
- неявная: когда ресурc terraform'а ссылается на объект внутри другого ресурса `'nat_ip = "${google_compute_address.reddit-app-ip.address}"'`
- явная: в описании ресурса присутствует ссылка на другой ресурс  - `"depends_on = [
      "google_compute_instance.reddit-db",
  ]"`

#### Работа с модулями [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/4):
Модули позволяют разделять ресурсы и облегчают управление ими. Инфраструктура разбита на 3 модуля:
- [app](terraform/examples/4/modules/app) - web часть сервиса
- [db](terraform/examples/4/modules/db) - модуль для работы с базами данных
- [vpc](terraform/examples/4/modules/vpc) - модуль для управления доступом к проекту

Вынесем БД на отдельный инстанс ВМ. Для этого, для начала создадим 2 разных образа с помощью packer: db.json и app.json.

Далее разобьем файл main.tf на несколько конфигов, аналогично, как мы сделали с конфигурацией для packer. Создадим файлы app.tf с описанием приложения и db.tf с описанием базы. Так же, создадим файл vpc.tf, куда вынесем правило фаервола, которое применимо для всех инстансов (default-allow-ssh)

Перед тем, как создавать образы, необходимо проверить, что в GCP создано правило default-allow-ssh. Если его нет (возможно мы применили terraform destroy), то необходимо его создать, либо вручную, либо с помощью терраформа:
```shell
terraform apply -target=google_compute_firewall.firewall_ssh
```
После того, как разобьем файлы на несколько конфигов, сделаем сначала 2 новых образа:
```shell
packer build app.json
packer build db.json
```
### Создание модулей
Перед тем, как создавать модули, уничтожим текущую инфраструктуру:
```shell
terraform destroy
```
В дирректории terraform создадим папку modules. Создадим модуль для базы данных и для приложения.
#### Модуль для базы
Создадим папку db внутри папки modules. Внутри создадим 3 файла: main.tf, variables.tf и outputs.tf. В файл main.tf скопируем содержимое ранее созданного файла db.tf. В файле variables.tf опишем используемые переменные для модуля с базой: `public_key_path`, `zone` и `db_disk_image`

#### Модель для приложения
По аналогии с базой, создадим папку app внутри директории modules с 3-мя файлами main.tf, variables.tf и outputs.tf. В файл main.tf скопируем содержимое из файла app.tf. В файле variables.tf опишем используемые переменные для приложения: `public_key_path`, `zone`, `app_disk_image` и `instance_count`

#### Использование модулей
Перед тем, как использовать модули, необходимо удалить из папки terraform ранее созданные файлы db.tf и app.tf [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/3), а в файле main.tf прописать использование модулей:
```
module "app" {
  source = "modules/app"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  app_disk_image = "${var.app_disk_image}"
  instance_count = "${var.instance_count}"
}

module "db" {
  source = "modules/db"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  db_disk_image = "${var.db_disk_image}"
}
```
#### Модуль vpc
Аналогичным образом сделаем модуль для vpc. Создадим файл main.tf в папке vpc внутри папки modules. Создавать файлы outputs.tf и variables.tf пока нет необходимости, т.к. мы не получаем никаких входных и выходных данных. Добавим так же использование этого модуля в основной main.tf

### Параметризация модуля vpc
Для параметризации модуля vpc вынесем директиву source_ranges в отдельную переменную. После этого, мы сможем указывать source_ranges для ssh как параметр к модулю

### Создание окружений stage и prod
[Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/5)
Для создания разных окружений, создадим папки stage и prod внутри папки terraform, скопируем в них файлы main.tf, variables.tf, outputs.tf, а так же terraform.tfvars и terraform.tfvars.example

В файлах main.tf поменяем пути к модулям. Так же вынесем значение переменной source_ranges в terraform.tfvars, и для stage зададим `0.0.0.0/0` а для prod свой ip-адрес.
Удалим файлы main.tf, variables.tf, outputs.tf и terraform.tfvars из корневой папки terraform, т.к. они больше не нужны.

### Работа с реестром модулей
Модули можно брать из [реестра терраформа](https://registry.terraform.io/).
Воспользуемся модулем [storage-bucket](https://registry.terraform.io/modules/SweetOps/storage-bucket/google/0.2.0) для создания бакетов в GCP. 

### Хранение стейт-файлов в удаленном бекэнде (*) 

С помощью конфигурации storage-bucket создадим 2 бакета для stage (gsutil mb gs://dethroner-terraform-stage/) и prod (gsutil mb gs://dethroner-terraform-prod/)
Создадим файлы backend.tf для stage и prod, где опишем конфигурации бекэндов [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/6):

```
#stage terraform backend
terraform {
  backend "gcs" {
    bucket = "dethroner-terraform-stage"
    prefix = "reddit-stage"
  }
}

```
Командой `terraform init` инициализзируем бекенды и проверим, что файлы tfstate перенеслись в бакеты.

Теперь, если перенести конфигурацию с настроенным бекэндом в любое другое место, террафоорм будет искать бекэнд в бакетах гугла.
При запуске терраформа (`terraform apply`) в бакете создается файл блокировки `.tflock`. Этот файл существует, пока идет применение конфигурации, после чего удаляется. Если запустить одновременно 2 применения одной и той же конфигурации, то та, что была запущена позжеж упадет с ошибок о том, что состояние заблокировано.

</p>
</details>

<details><summary>08. Управление конфигурацией. Основные DevOps инструменты. Знакомство с Ansible.</summary>
<p>

## Ansible:

В данном задании сделано:
- Установка Ansible
- Terraform создает тестовую инфраструктуру
- Конфигурация Ansible
- Написание простого плейбука
- Написание более сложный playbook
- Использование шаблонов в ansible
- Создание ролей в ansible
- Использование внешних переменных
- Использование include
- Использование ansible vault

### Установка Ansible
Для начала необходимо установить python 2.7

```shell
$ sudo apt update
$ sudo apt install python dirmngr
```
#### Установка через apt

1. Добавить в /etc/apt/sources.list
```
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
```
2. Установка
```shell
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
$ sudo apt update
$ sudo apt install ansible
```
### Terraform создает тестовую инфраструктуру

[Тестовая инфраструктура](terraform\examples\7\) состоит из master-сервера (ansible) и двух нод на Debian (deb) и RedHat (rh).

1. После поднятия инфраструктуры подключаюсь к ansible:
```shell
ssh -i ~/.ssh/appuser appuser@<ip_ansible>
```
2. Перехожу в папку с ansible и впиcываю в inventory после ansible_host= ip-адреса нод.
```
cd /home/appuser/ansible
nano ./inventory
```
3. Проверяю соединение:
```
ansible all -m ping
```
### Конфигурация Ansible
Общие настройки для локального проека можно хранить в файле [ansible.cfg](ansible/ansible.cfg)

[Документация по переменным](https://docs.ansible.com/ansible/devel/reference_appendices/config.html#ansible-configuration-settings)

#### inventory файл
Описание управляемых хостов хранится в inventory файле [документация по инвентори](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html), в форматах .ini(ansible/inventory.ini), .yml(ansible/inventory.yml), .json(ansible/inventory.json) также есть возможность использовать JSON формат , из [динамического inventory файла](https://docs.ansible.com/ansible/2.8/dev_guide/developing_inventory.html).

Для взаимодействия с управляемыми машинами используются [модули](https://docs.ansible.com/ansible/2.8/modules/modules_by_category.html).

Для работы ansible, необходимо создать inventory файл, в котором будут указаны хосты, которыми будет управлять ансибл. Для того, что бы у каждого хоста не указывать пользователя, под которым подключается ансибл и ключ, занесем эту информацию в файл ansible.cfg в директории ansible. Это локальный файл конфигурации:

```
[defaults]
inventory = ./inventory
host_key_checking = False
retry_files_enabled = False
```
#### Написание простого плейбука
Написал простой плейбук [test.yml](ansible/examples/1/test.yml) .
```
---
- hosts: all
  become: yes
  tasks:
    - name: test connection
      ping:
```
Для выполнения плейбука выполняю команду:
```shell
ansible-playbook ./examples/1/test.yml
```
#### Написание более сложный playbook
Написал [playbook](ansible/examples/2/playbook.yml) который разворачивает на RedHat и Debian Apache и копирует туда минивебсайта. Запускаю:
```
ansible-playbook ./examples/2/playbook.yml
```
#### Использование шаблонов в ansible
Написал [playbook](ansible/examples/3/playbook.yml) который использует [шаблон](ansible/examples/3/website/index.j2) генерирующий index.html для минивебсайта. Запускаю:
```
ansible-playbook ./examples/3/playbook.yml
```
#### Создание ролей в ansible
1. Генерирую роль deploy_apache_web:
```
ansible-galaxy init deploy_apache_web
```
создасться пустая роль deploy_apache_web вида:
```shell
./deploy_apache_web
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
```
2. Взяв за основу предыдущий [playbook](ansible/examples/3/playbook.yml) начинаю заполнять роль:

- файлы *.png из website перенес => в директорию files;
- файл шаблона (index.j2) из website перенес => в директорию templates;
- далее разношу блоки из playbook.yml => в соответсвующие main.yml.

По итогу получаю [пример](ansible/examples/4/).

3. Запускаю и проверяю:
```
ansible-playbook ./examples/4/playbook.yml
```

#### Использование внешних переменных
Внес изменеия по сравнению с предыдущим примером в [playbook](ansible/examples/5/playbook.yml) добавив параметризацию ([тут](http://www.oznetnerd.com/ansible-extra-vars/) описано несколько более обширно).
```
---
- hosts: "{{ hosts }}"
  become: yes

  roles:
    - { role: deploy_apache_web, when: ansible_system == 'Linux' } 
```
Теперь при запуске playbook можно указав переменную запустить исполнени на определенной группе (all, PROD, STAGE) без постоянного изменения конфигурационного файла.

Запуск осуществляется таким образом (вместо сокращенного ключа -e, можно вводить его полную версию --extra-var или --extra-vars:
```
ansible-playbook ./examples/5/playbook.yml -e "hosts=PROD"
```
Введенная команда развернет в группе PROD Apache и минисайт.

Также можно передавать несколько параметров, переданные параметры будут иметь наивысший приоритет, например:
```
ansible-playbook ./examples/5/playbook.yml -e "hosts=STAGE owner=Test"
```
Помимо развворачивания в группе STAGE Apache и минисайта, будет также изменен владелец сервера c Ops на Test.

####  Использование include
Для работы с include решил разделить задачи из [примера](ansible/examples/2) на: 

- [установку](ansible/examples/6/install_apache.yml) Apache;
- [копирование](ansible/examples/6/copy_site.yml) минисайта.

И в [playbook](ansible/examples/6/playbook.yml) загрузить задачи через include.

Запуск и проверка:
```
ansible-playbook ./examples/6/playbook.yml
```
#### Использование ansible vault
Начиная с версии 1.5 в Ansible была доабвлена возможность хранения секретных данных, таких как пароли или RSA ключи, в зашифрованных файлах — vault («хранилище»).

<b>!!! Важно!!!</b> В пределах одного playbook все шифруемые переменные лучше кодировать <i>одним паролем</i>.
##### Шифрование файлов
1. Создания хранилища с запросом пароля:
```
ansible-vault create file.yml
```
2. Зашифровать уже имеющий файл:
```
ansible-vault encrypt file.yml
```
3. Расшифровать файл:
```
ansible-vault decrypt file.yml
```
4. Редактировать файл, по умолчанию (vi):
```
ansible-vault edit file.yml
```
Файл расшифровывается во временный файл, открывается для редактирования, после завершения — снова шифруется и сохраняется в старом месте.

5. Просмотр файла:
```
ansible-vault view file.yml
```
6. Смена пароля:
```
ansible-vault rekey file.yml
```
Можно применять к нескольким файлам сразу, если они зашифрованы одним ключём (паролем).
##### Шифрование переменных
1. Шифрование переменной через конструктор:
```
ansible-vault encrypt_string
```
После задания пароля будет вводим шифруеые данные, по окончании ввода жмем два раза Ctrl+d для получения зашифрованного контента. Т.е. видим что-то типа:
```
New Vault password:
Confirm New Vault password:
Reading plaintext input from stdin. (ctrl-d to end input)
This is Text String
!vault |
ANSIBLE_VAULT;1.1;AES256
38363965343563353962666264646337613464663263663632626264373563633430323633356639
3737333233393662336533376661333163653035333334370a373565343330633537363563656430
37363632636664353864353532633030326231356238643634623033396539656164666437343565
3964653033343136620a356438316635663561313665323739353766383233656261646538616165
66313237633635646265653633323635333861636539313937343363666539366465
Encryption successful
```
2. Шифрование переменной одной строкой:
```
echo -n "secretword" | ansible-vault encrypt_string
```
3. Использование шифрованных перемеых

Далее это может использоваться в переменной.

Например: добавить новый файл vars/strings.yml с переменной encrypted_data_string:
```
---
encrypted_data_string: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          38363965343563353962666264646337613464663263663632626264373563633430323633356639
          3737333233393662336533376661333163653035333334370a373565343330633537363563656430
          37363632636664353864353532633030326231356238643634623033396539656164666437343565
          3964653033343136620a356438316635663561313665323739353766383233656261646538616165
          66313237633635646265653633323635333861636539313937343363666539366465
```

##### Использование зашифрованных данных в playbook
1. Запустить выполнение зашифровнного playbook:
```
ansible-playbook playbook.yml --ask-vault-pass
```
Перед выполнением спросит пароль для шифтрованного контента.

2. Пароль ля шифтрованного контента можно сохранить в файл и запускать исползуя его вместо ввода пароля:
```
ansible-playbook playbook.yml --vault-password-file pass.txt 
```
3. В Ansible 2.4 и выше вместо --ask-vault-pass и --vault-password-file можно использовать --vault-id, который позволяет использовать разные пароли для разных файлов.
```
ansible-playbook playbook.yml --vault-id pass1.txt --vault-id pass2.txt
```
</p>
</details>

<details><summary>09. Локальная разработка с Vagrant.</summary>
<p>

## Vagrant:

В данном домашнем задании сделано:
- Установка Vagrant
- Конфигурация Vagrantfile
- Некоторые команды Vagrant

### Установка Vagrant

1. Необходимо установить [VirtualBox](https://www.virtualbox.org/wiki/Downloads) и [расширение](https://download.virtualbox.org/virtualbox/6.0.10/Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack). VritualBox - один из провайдеров, которым Vagrant 
может управлять для создания VMs. Он будет использован для локального запуска VM.

2. Установить [Vagrant](https://www.vagrantup.com/downloads.html). Проверить установку можно:
```
vagrant -v
```
### Конфигурация Vagrantfile

Описание характеристик VMs, которые мы хотим создать, должно содержаться в файле с названием [Vagrantﬁle](vagrant/Vagrantfile.example).

1. Создаю инфраструктуру, которую создавал до этого в GCE при помощи Terraform, на локальной машине, используя Vagrant. !!!Чтобы написаная конфигурация работала необходимо произвести предварительные [настройки](https://github.com/Dethroner/test/blob/master/README).

2. Перехожу в [инфраструктуру](vagrant/examples/1) инициализирую Vagrant и разворачиваю:
```
cd ./vagrant/examples/1
vagrant init
vagrant up
```
3. После поднятия инфраструктуры подключаюсь к ansible:
```shell
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
4. Перехожу в папку с ansible правлю inventory. 
```
cd /home/appuser/ansible
nano ./inventory
```
```
[PROD]
deb ansible_host=10.50.10.20. owner=Dev

[STAGE]
rh ansible_host=10.50.10.30 owner=Ops

[MAIN:children]
PROD
STAGE 
```
!!!Пришлось переместить ansible.cfg заменив установленый в /etc/ansible, и переписать путь до inventory!!!

5. Проверяю соединение:
```
ansible all -m ping
```
6. Проверяю работу предыдущего задания (в RedHat для Vagrant урезанны репозитории, не доступен httpd).

### Некоторые команды Vagrant

- Иниализировать проект:
```
vagrant init
```
- Развернуть инфраструктуру:
```
vagrant up
```
- Удалить инфраструктуру:
```
vagrant destroy
```
- Выключить инфраструктуру:
```
vagrant halt
```
- Просмотреть статус:
```
vagrant status
```
- Подключиться по внутреннему SSH:
```
vagrant ssh hostname
```

</p>
</details>

<details><summary>10. Технология контейнеризации. Введение в Docker</summary>
<p>

## Docker:

В данном задании сделано:<br>
- Введение в Docker<br>
- Установка Docker<br>
- Запуск Wordpress c mysql<br>
- Запуск Wordpress c mysql с использованием хостовых папок<br>
- Оптимизация создаваемых образов<br>
- Драйвера сети в Docker<br>
- Работа с сетями<br>

### Введение в [Docker](docker/README.md)
Инструмент для создания образов и развертывания из них контейнеров. Используется для поставки ПО. 
Для изоляции процессов использует [namespaces](https://habr.com/ru/post/458462/).
Для ограничения ограничения ресурсов [cgroups](https://habr.com/ru/company/selectel/blog/303190/)

#### Dockerfile
Файл содержащий инструкции для создания образа  
[Документация](https://docs.docker.com/engine/reference/builder/)

#### Docker-machine
Docker-machine - это встроенный в докер механизм для создания хостов и установки на них docker engine (server).<br>
Команда создания - docker-machine create <имя>. Имен может быть много, переключение между ними через eval $(docker-machine env <имя>). Переключение на локальный докер - eval $(docker-machine env --unset). Удаление - docker-machine rm <имя>. docker-machine создает хост для докер демона со указываемым образом в --googlemachine-image, в ДЗ используется ubuntu-16.04. Образы которые используются для построения докер контейнеров к этому никак не относятся. Все докер команды, которые запускаются в той же консоли после eval $(docker-machine env <имя>) работают с удаленным докер демоном в GCP.<br>
Инструмент для установки Docker engine на удалённом сервере и управления им.  
[Документация](https://docs.docker.com/machine/overview/)<br>

Создание удаленного хоста с docker команду:
```
export GOOGLE_PROJECT=docker-248611
docker-machine create --driver google \
--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
--google-machine-type n1-standard-1 \
--google-zone europe-west1-b \
docker-host
```
Проверим, что наш хост успешно создан:
```
docker-machine ls
```
Переключимся на удаленный хост:
```
eval $(docker-machine env docker-host)
```
Теперь все дальнейшие команды docker будут выполняться на удаленном хосте.

### Установка Docker
1. [Инструкция](https://docs.docker.com/install/linux/docker-ce/debian/) по установке Docker.<br>
2. Создаю [VM](vagrant/examples/2) Docker средствами Vagrant и разворачиваю:
```
cd ./vagrant/examples/2
vagrant init
vagrant up
```
3. После поднятия инфраструктуры подключаюсь:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
4. Проверяю:
```
docker -v
```

### Запуск [Wordpress](docker/examples/1/README.md) c mysql
1. Запускаю базу данных (mysql):
```
docker run -d --name=db -e MYSQL_ROOT_PASSWORD=password mysql
```
2. Запускаю Wordpress, подключаю его к бд:
```
docker run -d --name=wp --link=db -p 80:80 -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_PASSWORD=password wordpress
```
3. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10).

### Запуск [Wordpress](docker/examples/2/README.md) c mysql с использованием хостовых папок
1. Запускаю базу данных (mysql):
```
docker run -d --name=db -e MYSQL_ROOT_PASSWORD=password -v $(pwd)/db-mysql:/var/lib/mysql mysql
```
Просто монтирую папку db-mysql к /var/lib/mysql, и теперь mysql данные находятся в относительной безопасности хостовой файловой системы.<br>
Если такой контейнер удалить, то с его данными ничего не случится.<br>
Если запустить новый mysql, подключив папку к тому же пути (повторить команду), то новый контейнер продолжит с того же места, где остановился старый.

2. Запускаю Wordpress, подключаю его к бд, так же подключаю хостовую папку где у меня лежит дополнительная тема:
```
docker run -d --name=wp --link=db -p 80:80 -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_PASSWORD=password wordpress
```
3. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10).

4. Удаляю работающий контейнер с бд:
```
docker stop db
docker rm db
```
5. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10). Сайт недоступен.

6. Запускаю бд:
```
docker run -d --name=db -e MYSQL_ROOT_PASSWORD=password -v $(pwd)/db-mysql:/var/lib/mysql mysql
```
7. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10). Сайт работает как ни вчем не бывало.

### Запуск [Reddit](docker/examples/3) с созданием docker образов

Приложение состоит из [трех](https://github.com/express42/reddit/archive/microservices.zip) компонент:
- post-py - сервис отвечающий за написание постов;
- comment - сервис отвечающий за написание комментариев;
- ui - веб-интерфейс для других сервисов;
- для работы ему требуется mongodb.

1. Скачал последний образ mongod:
```
docker pull mongo:latest
```
2. Создаю Dockerﬁle образов и собираю их:
- [./post-py/Dockerﬁle](docker/examples/3/post-py/Dockerﬁle)
- [./comment/Dockerﬁle](docker/examples/3/comment/Dockerﬁle)
- [./comment/Dockerﬁle](docker/examples/3/comment/Dockerﬁle)
```
docker build -t test/post:1.0 ./post-py
docker build -t test/comment:1.0 ./comment
docker build -t test/ui:1.0 ./ui
```
3. Создаю специальную сеть для объединения компонентов (чтобы не использовать --link=):
```
docker network create reddit
```
4. Запускаю контейнеры из созданных образов (данные бд положу в контейнер reddit_db): 
```
docker run -d --network=reddit -v reddit_db:/data/db --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post test/post:1.0
docker run -d --network=reddit --network-alias=comment test/comment:1.0
docker run -d --network=reddit -p 9292:9292 test/ui:1.0
```
5. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10:9292). Все работает.

6. Останавливаю контейнеры:
```
docker stop $(docker ps -q) && docker rm $(docker ps -q)
```
### Оптимизация создаваемых образов

1. Если проверить размеры образов, можно увидеть что они достаточно объемные:
```
docker images ls
```
```
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
test/comment        1.0                 99dbbce0f6e7        25 minutes ago      773MB
test/ui             1.0                 a0faa528a3df        23 minutes ago      778MB
test/post           1.0                 28cc2313afa8        34 minutes ago      102MB
```
2. Как добиться уменьшения образов?

Нужно помнить что:<br>
- размер образа зависит от размера базового образа (к которому можно добавить нужные утилиты и пакеты);
```
ruby                2.2                 6c8e6f9667b2        16 months ago       715MB
ubuntu              16.04               5e13f8dd4c1a        6 weeks ago         120MB
ruby                2.4-alpine3.9       ea8b14b30914        11 days ago         54.4MB
```
- каждая команда в Dockerﬁle - это новый образ, а соответсвенно дополнительный размер к базовому образу;
```
ENV myvar true                                          <- image!
RUN apt-get install -y nginx                            <- image!
RUN apt-get install -y php-fpm                          <- image!
RUN apt-get install -y imagemagick                      <- image!
ADD https://some-site.com/soft/master.tar.gz /bin/      <- image!
CMD ["/bin/cool-soft"]                                  <- image!
```
можно к примеру уменьшить вот так:
```
ENV myvar true                                          <- image!
RUN apt-get install -y nginx /                          <- image!
    apt-get install -y php-fpm /
    apt-get install -y imagemagick
ADD https://some-site.com/soft/master.tar.gz /bin/      <- image!
CMD ["/bin/cool-soft"]                                  <- image!
```
- также важно удалять за собой архивы и временные файлы;
```
COPY <filename>.zip <copy_directory>                    <- image!
RUN unzip <filename>.zip                                <- image!
RUN rm <filename>.zip                                   <- image!
```
желательно это делать в одной команде иначе останутся наследуемые images с zip архивом:
```
RUN curl <file_download_url> -O <copy_directory> \                  <- image!
    && unzip <copy_directory>/<filename>.zip -d <copy_directory> \
    && rm <copy_directory>/<filename>.zip

```
3. Пересобираю образ заменив образ ruby:2.2 на ubuntu:16.04:
```
cp -R ./ui/2/Dockerfile ./ui
docker build -t test/ui:2.0 ./ui
```
Останавливаю контейнеры 'docker kill $(docker ps)'. Повторив пп.4-6 проверяю работу, с той лишь разницей, что запускаю новую версию:
```
docker run -d --network=reddit -p 9292:9292 test/ui:2.0
```
4. А если пересобрать все на базе alpine? Пробую:<br>
comment:
```
cp -R ./comment/2/Dockerfile ./comment/
docker build -t test/comment:2.0 ./comment
```
ui:
```
cp -R ./ui/3/Dockerfile ./ui
docker build -t test/ui:3.0 ./ui
```
Останавливаю контейнеры 'docker kill $(docker ps)'. Повторив пп.4-6 проверяю работу, с той лишь разницей, что запускаю новую версию:
```
docker run -d --network=reddit --network-alias=comment test/comment:2.0
docker run -d --network=reddit -p 9292:9292 test/ui:3.0
```
5. Проверяю все образы:
```
docker images ls
```
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
test/post           1.0                 28cc2313afa8        34 minutes ago      102MB
test/ui             1.0                 a0faa528a3df        23 minutes ago      778MB
test/ui             2.0                 7b1d2c287492        7 minutes ago       227MB
test/ui             3.0                 b65e1d57ff83        19 minutes ago      72.4MB
test/comment        1.0                 99dbbce0f6e7        25 minutes ago      773MB
test/comment        2.0                 da2ca248f9b7        30 minutes ago      70.3MB
mongo               latest              cdc6740b66a7        3 weeks ago         361MB
ruby                2.2                 6c8e6f9667b2        16 months ago       715MB
ruby                2.4-alpine3.9       ea8b14b30914        11 days ago         54.4MB
python              3.6.0-alpine        cb178ebbf0f2        2 years ago         88.6MB
ubuntu              16.04               5e13f8dd4c1a        6 weeks ago         120MB
```
### Драйвера сети в Docker
[bridge](https://docs.docker.com/network/bridge/) - мост между несколькими контейнерами. без явного указания, будет использоваться этот драйвер.
[host](https://docs.docker.com/network/host/) - подключение к сети, машины, на которой запущен контейнер
[overlay](https://docs.docker.com/network/overlay/) - для соединения docker демонов запущенных на разных машинах
[macvlan](https://docs.docker.com/network/macvlan/) - назначает каждому контейнеру MAC
[none](https://docs.docker.com/network/none/) - Отключает локальный контейнер от сети, оставляя только localhost
[Network plugin](https://docs.docker.com/engine/extend/plugins_services/) - см. документацию

### Работа с сетями

Запускаю проект в 2-х bridge сетях. Так, чтобы сервис ui не имел доступа к базе данных. Т.е. ui должен подключаться к comment и post (сеть - front-net), но сами comment и post должны иметь подключение к бд (сеть - back_net).

1. Запускаю [Reddit](docker/examples/4) и удаляю все созданные и скачанные образы.
```
cd /home/appuser/docker/examples/4
docker stop $(docker ps -q) && docker rm $(docker ps -q)
```
2. Скачал последний образ mongod:
```
docker pull mongo:latest
```
3. Собрал образы:
```
docker build -t test/post:1.0 ./post-py
docker build -t test/comment:1.0 ./comment
docker build -t test/ui:1.0 ./ui
```
4. Создаю docker-сети:
```
docker network create back_net --subnet=10.50.20.0/24
docker network create front_net
```
5. Запускаю контейнеры:
```
docker run -d --network=front_net -p 9292:9292 --name ui  test/ui:1.0 
docker run -d --network=back_net --name comment  test/comment:1.0
docker run -d --network=back_net --name post  test/post:1.0
docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db mongo:latest
```
Docker при инициализации контейнера может подключить к нему только 1 сеть. <br>
При этом контейнеры из соседних сетей не будут доступны как в DNS, так и для взаимодействия по сети.<br>
Поэтому нужно поместить контейнеры post и comment в обе сети. <br>
6. Подключаю контейнеры ко второй сети:
```
docker network connect front_net post
docker network connect front_net comment
```
7. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10:9292). Все работает.<br>
8. Смотрю как выглядит [сетевой стек](https://developer.ibm.com/recipes/tutorials/networking-your-docker-containers-using-docker0-bridge):
- выполняю:
```
docker network ls
```
- нахожу ID сетей, созданных в рамках проекта;
- Выполняю:
```
sudo apt-get -y install net-tools bridge-utils
sudo ifconfig | grep br
```
```
br-7c6b2561bf15: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.50.20.1  netmask 255.255.255.0  broadcast 10.50.20.255
br-7e8177681195: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet 10.50.10.10  netmask 255.255.255.0  broadcast 10.50.10.255
```
- Нахожу bridge-интерфейсы для каждой из сетей. Смотрю информацию о каждом.
```
sudo brctl show <interface>
```
```
bridge name     bridge id               STP enabled     interfaces
br-7c6b2561bf15         8000.0242714854d5       no      veth2f35054
                                                        veth3ade9ea
                                                        vethf40c161

```
Отображаемые veth-интерфейсы - это те части  виртуальных пар интерфейсов, которые лежат в сетевом пространстве хоста и также отображаются в ifconﬁg. Вторые их части лежат внутри контейнеров. <br>
- Смотрю как выглядит iptables:
```
 sudo iptables -nL -t nat
```
```
Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  172.17.0.0/16        0.0.0.0/0
MASQUERADE  all  --  172.18.0.0/16        0.0.0.0/0
MASQUERADE  all  --  10.50.20.0/24        0.0.0.0/0
```
Данные правила отвечают за выпуск во внешнюю сеть контейнеров из bridge-сетей.<br>
- В ходе работы у необходимо было прокинуть порт контейнера UI (9292) для доступа к нему снаружи. <br>
Вот что Docker при этом сделал.<br> 
Снова смотрю в iptables на таблицу nat цепочка DOCKER и правила DNAT в ней. <br>
```
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:9292 to:172.18.0.4:9292
```
Они отвечают за перенаправление трафика на адреса уже конкретных контейнеров.<br>
- Также выполняю:
```
sudo ps ax | grep docker-proxy
```
```
 3075 ?        Sl     0:00 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9292 -container-ip 172.18.0.4 -container-port 9292
```
Должны быть хотя бы 1 запущенный процесс docker-proxy.<br>
Этот процесс в данный момент слушает сетевой tcp-порт 9292.<br>
8. Останавливаю контейнеры:
```
docker stop $(docker ps -q) && docker rm $(docker ps -q)
```

</p>
</details>

<details><summary>11. Технология контейнеризации. Docker-compose</summary>
<p>

## Docker-compose:

Docker-compose это простой инструмент, который позволяет настроить и запустить несколько контейнеров одной командой. Код каждого сервиса находится в своей директории и имеет Dockerfile. Пример структуры проекта можно посмотреть [здесь](https://docs.docker.com/compose/gettingstarted/).
Вся конфигурация для docker-compose описывается в файле docker-compose.yml, который обычно лежит в корне проекта.

В данном задании сделано:<br>
- Установка Docker + Docker-compose
- Запуск Reddit
- Запуск Reddit с множеством сетей
- Именование проекта в docker-compose
- Переопределение docker-compose.yml

### Установка Docker + Docker-compose
1. Создаю [VM](vagrant/examples/3) Docker + Docker-compose средствами Vagrant и разворачиваю:
```
cd ./vagrant/examples/3
vagrant init
vagrant up
```
2. После поднятия инфраструктуры подключаюсь:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
3. Проверяю:
```
docker-compose -v
```
### Запуск [Reddit](docker/examples/5)
1. В директории с проектом создаю файл [docker-compose.yml](docker/examples/5/docker-compose.yml), его [синтаксис](https://docs.docker.com/compose/compose-file/). Важно, чтобы папки ui, comment, post находились рядом.
```
cd /home/appuser/docker/examples/5
```
2. Docker-compose поддерживает интерполяцию(подстановку) переменных окружения.<br>
В данном случае это переменная USERNAME.<br>
Поэтому перед запуском необходимо экспортировать значения данных переменных окружения:
```
export USERNAME=test
docker-compose up -d
```
3. Проверяем произошел ли запуск:
```
docker-compose ps
```
```

```
4. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10:9292). Все работает.<br>
5. Останавливаю контейнеры:
```
docker-compose down
```
### Запуск [Reddit](docker/examples/6) с множеством [сетей](docker/examples/4)
1. Чтобы не осуществлять экспорт переменных создаю файл c расширением .env содержащий переменные.<br>
Без использования команд source и export docker-compose должен подхватить переменные из этого файла.<br>
P.S. В  git лучше коммитить файл с расширением вроде .env.example, в будущем от него продуцировать файл с расширением .env.
```
cd /home/appuser/docker/examples/6
```
2. Запускаю проект:
```
docker-compose up -d
```
3. Проверяю, что получилось пройдя по ссылке в [браузере](http://10.50.10.10:9292). Все работает.<br>
4. Останавливаю контейнеры:
```
docker-compose down
```
### Именование проекта в docker-compose
По-умолчанию докер композ составляет имена запущеных контейнеров по следующей схеме:
```
БазовоеИмяПроекта_ИмяСервиса_НомерИнстанса
```
БазовоеИмяПроекта по-умолчанию определяется как имя каталога, в котором находится docker-compose.yml. Это имя можно изменить, при запуске композа:
```
docker-compose -p <БазовоеИмяПроекта> up
docker-compose -p <БазовоеИмяПроекта> down
```
Либо задав переменную окружения COMPOSE_PROJECT_NAME

### Переопределение docker-compose.yml
Docker-compose во время запуска считывает файлы:

docker-compose.yml - основной файл<br>
docker-compose.override.yml - перопределяет переменные<br>
.env - файл переменных окружения

Если он находит docker-compose.yml и docker-compose.override.yml, то мержит их в один (обычно override перезаписывает стандартный файл) по [правилам](https://docs.docker.com/compose/extends/#adding-and-overriding-configuration).

Создаю файл docker-compose.override.yml, который позволит:<br>
- Изменять код каждого из приложений, не выполняя сборку образа<br>
- Запускать puma для руби приложений в дебаг режиме с двумя воркерами (флаги --debug и -w 2)<br>

Поскольку используется bind для подключения папок в override файле, то папки с содержимым должны существовать на удаленном хосте docker-host, либо следует запускать композ локально.

</p>
</details>

<details><summary>12. Устройство Gitlab CI. Построение процесса непрерывной интеграции.</summary>
<p>

## Gitlab CI:<br>

В данном задании сделано:<br>
- Устройство Gitlab CI. Построение процесса непрерывной интеграции.
- Установка Gitlab CI в Docker.
- Настройка Gitlab CI.
- Настройка Gitlab CI Pipeline.
- Приложение reddit.
- Автоматизация развертывания gitlab-ci runner.
- Интеграция pipeline со slack.
- Установка Gitlab CI + runner в Vagrant.

### Устройство Gitlab CI. Построение процесса непрерывной интеграции.

Gitlab CI - инструмент построения пайплайна непрерывной поставки\развертывания. Разделён на 2 части: Сервер управления и Раннеры, на которых проходит сборка и тестирование кода.<br>
Во время сборки есть возможность использовать [Предопределенные переменные](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) или [назначить переменные](https://docs.gitlab.com/ee/ci/variables/)

Есть возможность интегрировавть различные [сервисы](https://docs.gitlab.com/ee/user/project/integrations/project_services.html)

Ссылки:<br>
[quick_start](https://docs.gitlab.com/ee/ci/quick_start/)  
[Небольшой How-to по установке](https://www.howtoforge.com/tutorial/how-to-install-and-configure-gitlab-ce-on-centos-7/)  
[Omnibus](https://docs.gitlab.com/omnibus/docker/README.html#install-gitlab-using-docker-compose)  
[Документация](https://docs.gitlab.com/ee/ci/)  
[Разветрывание контейнера gitlab-ci](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html)

### Установка Gitlab CI в Docker.<br>
#### Подготовка инфраструктуры.

CI-сервис является одним из ключевых инфраструктурных сервисов в процессе выпуска ПО и к его доступности, бесперебойной работе и безопасности должны предъявляться повышенные требования.

Gitlab CI состоит из множества компонент и выполняет ресурсозатратную работу, например, компиляция приложений. 

Потребуется создать новую виртуальную машину со следующими параметрами:
- 1 CPU<br> 
- 3.75GB RAM<br>
- 100 GB HDD<br>
- Linux (я взял Debian 9)

На локальной машине таких ресурсов нет, буду создавать в Google Cloud.

В официальной документации описаны [рекомендуемые характеристики](https://docs.gitlab.com/ce/install/requirements.html) сервера.

Так же нужно разрешить подключение по HTTP/HTTPS/SSH.

На сервере для Gitlab CI ставлю Docker и Docker-compose, создаю необходимые директории, назначаю права, копирую docker-compose.yml устанавливающий Gitlab в Docker.

Запускаю [инфраструктуру](terraform/examples/8)
```
cd terraform/examples/8
terraform init
terraform apply
```
#### Запуск Gitlab CI в Docker.

После поднятия инфраструктуры подключаюсь по SSH:
```
ssh -i ~/.ssh/appuser appuser@35.187.72.40
```
Перехожу в папку с проектом. В docker-compose.yml заменяю <YOUR-VM-IP> внешним IP адресом, который Google присвоил серверу, строка - external_url ‘http://<YOUR-VM-IP>’<br>  
и запускаю Gitlab CI:
```
cd /srv/gitlab
nano ./docker-compose.yml
sudo docker-compose up -d
```
### Настройка Gitlab CI.
Открываю в браузере http://35.187.72.40, и Gitlab CI предложит изменить пароль от встроенного пользователя root. Далее, вхожу и правлю глобальные настройки. Выбрав Admin area -> Settings -> Sign-up restrictions и снимаю галочку с sign-up enabled.

Создаю группу homework, а внутри неё репозиторий example.

Клонирую репозиторий и перехожу в него:
```
cd ./gitlab
git clone http://<YOUR-VM-IP>/homework/example.git
cd example
```
### Настройка Gitlab CI Pipeline.
1. В корне репозитория создаю тестовый файл .gitlab-ci.yml, в котором описываю используемые stages и тестовые задания.
```
nano ./.gitlab-ci.yml
```
```
stages: 
  - build 
  - test 
  - deploy 
build_job: 
  stage: build 
  script: 
    - echo 'Building' 
test_unit_job: 
  stage: test 
  script: 
    - echo 'Testing 1' 
test_integration_job: 
  stage: test 
  script: 
    - echo 'Testing 2' 
deploy_job: 
  stage: deploy 
  script: 
    - echo 'Deploy'
```
2. Сохраняю файл и пушу в репозиторий Gitlab CI:
```
git add .gitlab-ci.yml
git commit -m "add pipeline definition"
git push origin
```
3. Зайдя в репозиторий Gitlab CI в CI/CD -> Pipelines вижу, что пайплайн готов, но в статусе pending, т.к. нет ранера В репозитории иду в settings -> CI/CD -> Runner settings и нахожу токен для ранера. Запоминаю его - он понадобится для регистрации ранера.

4. Делаю ранер. На сервере где запущен контейнер с гитлабом выполнию команду:
```
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlab-runner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
```
5. После запуска контейнера регистрирую раннер:
```shell
root@gitlab-ci:~# docker exec -it gitlab-runner gitlab-runner register --run-untagged --locked=false
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://<YOUR-VM-IP>/
Please enter the gitlab-ci token for this runner:
<TOKEN>
Please enter the gitlab-ci description for this runner:
[38689f5588fe]: my-runner
Please enter the gitlab-ci tags for this runner (comma separated):
linux,xenial,ubuntu,docker
Please enter the executor:
docker
Please enter the default Docker image (e.g. ruby:2.1):
alpine:latest
Runner registered successfully.
```
6. Делаю некоторые правки раннера Admin Area -> Runners созданный ранее my-runner Edit и проверяю чтобы:
- Run untagged jobs было true (стоит птичка)<br>
- Lock to current projects было false (не стоит птичка)

7. Проверяю, что Pipeline заработал и выполняется.

### Приложение reddit.
Создаю новый проект для reddit в той же группе.<br>
Переношу в него код reddit app (ветка monolith).
```
cd ./gitlab
git clone https://github.com/Artemmkin/reddit.git 
cd reddit 
git remote add gitlab http://<YOUR-VM-IP>/homework/reddit.git 
git push -u gitlab
```
Добавляю в репозиторий файл с описанием пайплайна. Создав файл .gitlab-ci.yml с содержимым в репозитории reddit.
```
nano ./.gitlab-ci.yml
```
```
image: ruby:2.4.2 
stages: 
  - test 
variables: 
  DATABASE_URL: 'mongodb://mongo/user_posts' 
before_script: 
  - bundle install 
test: 
  stage: test 
  services: 
    - mongo:latest 
  script: 
    - ruby simpletest.rb
```
В описании pipeline есть вызов теста в файле simpletest.rb, создаю его в корне репозитория.
```
nano ./simpletest.rb
```
```
require_relative './app' 
require 'test/unit' 
require 'rack/test' 
set :environment, :test 
class MyAppTest < Test::Unit::TestCase 
  include Rack::Test::Methods 
  def app 
    Sinatra::Application 
  end 
  def test_get_request 
    get '/' 
    assert last_response.ok? 
  end 
end
```
Добавляю библиотеку для тестирования (после gem 'mongo') в Gemﬁle приложения (в корне репозитория reddit):
```
nano ./Gemfile
```
```
gem 'rack-test'
```
Отправляю изменения в репозиторий и вижу на странице CI/CD, что для этого проекта, так же не включен раннер.
```
git add .
git commit -m "Add tests."
git push -u gitlab
```
Включаю раннер в настройках проекта settings -> CI/CD -> Runner settings -> Enable for this project.<br>
Теперь на каждое изменение в коде приложения будет запущен тест.

### Автоматизация развертывания gitlab-ci runner.
Для автоматизации развертывания и регистрации раннера будет использоваться ансибл. Создаю папку [ansible](gitlab/ansible).

Для установки и регистрации раннера на виртуальных машинах будет использоваться роль из ansible-galaxy `riemers.gitlab-runner`. Создаю файл requirements.yml в котором опишу используемую роль.

Теперь достаточно выполнить команду

``` shell
asible-galaxy install -r requiements.yml
```
Для установки роли.

Создаю папку playbooks, а в ней файл gitlab-runner.yml в котором опишу установку раннера через используемую роль. Переменные, которые описывают усановку и регистрацию ранера помещаю в файл `vars/gitlab-runner.yml`

Теперь для установки и регистрации раннера на хосты, достаточно выполнить команду:

```shell
ansible-playbook playbooks/gitlab-runner.yml
```

### Интеграция pipeline со slack.

Перехожу по ссылке:

Нажимаю кнопку **Add Configuration**. Выбираю свой канал и нажимаю на кнопку **Add Intergration**. Копирую ссылку из поля **Webhook URL**. Нажимаю **Save Settings**.

Иду в гитбал в проект settings -> integration и нахожу там пункт **slack notification**.
Проверяю Active. В поле Webhook вставляю скопированную ссылку. В поле Username пишу Gitlab. Снимаю галочку "Notify only default branch" а так же снимаю "Notify only broken pipelines". В списке оставляю с галочками только то, что нужно и указываю канал.

### Установка Gitlab CI + runner в [Vagrant](vagrant/examples/4)

1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/4
vagrant init
vagrant up
```
2. Делаю операции из <b>Настройка Gitlab CI</b>.<br>
3. После запуска инфраструктуры подлючаюсь к ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
и регистрирую ранер см. пп.3,5-7 <b>Настройка Gitlab CI Pipeline</b>. После регистрации выхожу с SSH-сессии.

4. Gitlab CI готов к работе.

</p>
</details>

<details><summary>13. Мониторинг.</summary>
<p>

## Prometheus:<br>

[Документация](https://prometheus.io/docs/prometheus/latest/getting_started/)<br>
[Прометеус](https://prometheus.io/docs/introduction/overview/) - [tsdb](https://en.wikipedia.org/wiki/Time_series_database) использующая язык запросов [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).

В данном задании сделано:<br>
- Prometheus: запуск и знакомство
- Мониторинг состояния микросервисов

### Prometheus: запуск и знакомство
#### Подготовка окружения

1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/2
vagrant init
vagrant up
```
2. После запуска инфраструктуры подлючаюсь к ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
#### Запуск Prometheus в контейнере.

Запускаю готовый образ с докер-хаба.
```
docker run --rm -p 9090:9090 -d --name prometheus  prom/prometheus
```

#### Знакомство с Prometheus

1. Открываю веб интерфейс и знакомлюсь с системой
```
http://10.50.10.10:9090/
```
2. Останавливаю контейнер
```
docker stop prometheus
```

### Мониторинг состояния микросервисов<br>
#### Подготовка инфраструктуры

1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/3
vagrant init
vagrant up
```
2. После запуска инфраструктуры подлючаюсь к ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
#### Простая проверка работы

1. Создаю Docker образ через [Dockerfile](docker/example/8/prometheus/Dockerﬁle) который будет копировать файл конфигурации внутрь контейнера.<br>
2. Конфигурация Prometheus, в отличие от многих других систем мониторинга, происходит через файл конфигурации [prometheus.yml](docker/example/8/prometheus/prometheus.yml) и опции командной строки. <br>
В код микросервисов добавил healthcheck-и для проверки работоспособности приложения.<br>
3. Поднимаю сервисы:
```
cd /home/appuser/docker/example/8
docker-compose up -d
```
4. Открываю веб интерфейс
```
http://10.50.10.10:9090/
```
5. Смотрю список endpoint-ов (вкладка Status->Targets), с которых собирается информация. Помимо самого Prometheus, я определил в конфигурации мониторинг ui и comment сервисы. Endpoint-ы должны быть в состоянии UP.<br>
Healthcheck-и представляют собой проверки того, что сервис здоров и работает в ожидаемом режиме. В данном случае healthcheck выполняется внутри кода микросервиса и выполняет проверку того, что все сервисы, от которых зависит его работа, ему доступны. Если требуемые для его работы сервисы здоровы, то healthcheck проверка возвращает status = 1, что соответсвует тому, что сам сервис здоров. Если один из нужных ему сервисов нездоров или недоступен, то проверка вернет status = 0.<br>
6. Проверка состояния сервиса UI. Ввести в поиск ***ui_health*** нажать Execute, мониторинг выведет что-то похожее:
```
ui_health{branch="build_info_missing",commit_hash="build_info_missing",instance="ui:9292",job="ui",version="0.0.1"}
```
!!! Помимо имени метрики и ее значения, мы также видим информацию в лейблах о версии приложения, комите и ветке кода в Git-е. 

Нажав Graph получим графическое распределение метрики системы. Видно, что статус UI сервиса был стабильно 1, что означает, что сервис работал.<br>
Попробую остановить сервис post на некоторое время и пронаблюдаю, как изменится статус ui сервиса, который зависим от post:
```
docker-compose stop post
```
Метрика изменила свое значение на 0, что означает, что UI сервис стал нездоров.<br>
7. Поиск проблемы. Помимо статуса сервиса, мы также собираем статусы сервисов, от которых он зависит. Набираю в строке выражений ui_health_ и монитоинг предлагает дополнить названия метрик.<br>
Проверил comment сервис. Вижу, что сервис свой статус не менял в данный промежуток времени. <br>
А с post сервисом все плохо.<br>
8. Чиню созданную самим же проблему ;)
```
docker-compose start post
```
Post сервис поправился.<br>
UI сервис тоже.<br>
9. Останавливаю сервисы и очищаю
```
docker-compose down
docker system prune
```


#### Проверка работы с использованием экспортеров.
##### Общая информация

Экспортер похож на вспомогательного агента для сбора метрик. В ситуациях, когда не возможно реализовать отдачу метрик мониторингу в коде приложения, можно использовать экспортер, который будет транслировать метрики приложения или системы в формате доступном для чтения Prometheus.

Prometheus:
- настраиваю через [конфигурационные файлы](docker/example/9/monitoring/prometheus/prometheus.yml) и опции запуска
- для сбора метрик использую [экспортеры](https://prometheus.io/docs/instrumenting/exporters/)
- для информирования можно использовать [Алертменеджер](https://prometheus.io/docs/alerting/configuration/). 

Пишу[конфигурационный файл](docker/example/9/monitoring/prometheus/prometheus.yml) для прометеуся и [Dockerfile](docker/example/9/monitoring/prometheus/Dockerfile) для сборки кастомного образа.

Для сборки метрик хоста ,с запущенными контейнерами, буду использовать [node-exporter](https://github.com/prometheus/node_exporter)

Метрики с базы данных буду собирать с помощью [mongodb_exporter](https://github.com/percona/mongodb_exporter) и [Dockerfile](docker/example/9/monitoring/mongodb_exporter/Dockerfile) для сборки контейнера.

Для проверки доступности контейнеров и страниц с метриками буду использовать [blackbox_exporter](https://github.com/prometheus/blackbox_exporter). Пишу [конфигурацию](docker/example/9/monitoring/blackbox_exporter/blackbox.yml) (Более подробно см. [тут](https://github.com/prometheus/blackbox_exporter/blob/master/example.yml)), и [Dockerfile](docker/example/9/monitoring/blackbox_exporter/Dockerfile) для сборки контейнера.

Пишу в [docker-compose.yml](docker/example/9/docker/docker-compose.yml) описание сервисов монитормнга.

##### Проверка
1. Поднимаю сервисы:
```
cd /home/appuser/docker/example/9/docker
docker-compose up -d
```
2. Открываю веб интерфейс
```
http://10.50.10.10:9090/
```
3. Смотрю, список endpoint-ов - должны появится еще endpoit-ы. <br>
Нпример, получаю информацию об использовании CPU (node_cpu) на хостовой машине.

#### Prometheus и Grafana красивые dashboard'ы
1. Поднимаю сервисы:
```
cd /home/appuser/docker/example/10/docker
docker-compose up -d
```
2. Открываю веб интерфейс Grafana
```
http://10.50.10.10:3000
```
3. Вижу что Prometeus уже подключен, но нет dashboard'ов, [импортирую](docker/example/10/monitoring/grafana/dashboards):
- DockerMonitoring.json
- UI_Service_Monitoring.json <br>
при импорте подтверждаю имя и выбираю источник (Prometeus server).

4. Вижу подключенные dashboard'ы.

</p>
</details>

<details><summary>14. Логирование.</summary>
<p>

## Elastic Stack:

В данном задании сделано:
- Подготовка окружения
- Elastic Stack
- Структурированные логи
- Неструктурированные логи
- Разбор логов с помощью grok-шаблонов
- Распределенный трейсинг

### Подготовка окружения

1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/3
vagrant init
vagrant up
```
2. После запуска инфраструктуры подлючаюсь к ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
3. Поднимаю сервисы:
```
cd /home/appuser/docker/example/11/docker
docker-compose up -d
```
### Elastic Stack
[Elasticsearch](https://www.elastic.co/products/) — тиражируемая свободная программная поисковая система. вместе со связанными проектами — механизмом сбора данных и анализа журналов Logstash и платформой аналитики и визуализации Kibana; эти три продукта предназначены для использования в качестве интегрированного решения, называемого «Elastic Stack». <br>

Поднимаю центральную систему логирования на Elastic. Однако, вместо стандартного для Logstash использую fluentd.<br>
В директории logging создаю папку fluentd, в которой простой докер-файл для сборки образа fluentd с его конфигурационным файлом fluent.conf.

!!! При запуске Elasticsearch может возникнуть ошибка и контейнер вылетит:
```
max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```
Для исправления, необходимо поправить параметры ядра linux на хосте с докер-контейнерами:
```shell
docker-machine ssh logging
sudo vim /etc/sysctl.conf
```
Необходимо добавить параметр:
```
vm.max_map_count = 262144
```
И применить параметры ядра:
```shell
sudo sysctl -p
```

### Структурированные логи
#### Предварительная подготовка
Подключаюсь к сервису post для проверки:
```
docker-compose logs -f post
```
#### Отправка логов в Fluentd
Для отправки логов в fluentd использую докер-драйвер [fluentd](https://docs.docker.com/config/containers/logging/fluentd/). Добавив его в докер-композ файл.
На примере post:
```
...
  post:
...
    logging:
      driver: "fluentd"
      options:
        fluentd-address: 10.50.10.10:24224
        tag: service.post 
```
#### Использование фильтров в fluentd
Для парсинга JSON в логе, определил фильтры в конфигурации fluentd. Файл `logging/fluentd/fluent.conf`

```
<filter service.post>
  @type parser
  format json
  key_name log
</filter>
```

### Неструктурированные логи
Неструктурированные логи - это логи, формат которых не подстроен под систему централизованного логирования. Они не имеют четкой структуры

#### Логирование UI сервиса
Добавил драйвер fluentd к сервису UI по аналогии с сервисом post.

Перезапустил сервис и смотрю в kibana на неструктурированные логи.

Для того, что бы распарсить такой лог, необходимо использовать регулярные выражения. Добавили фильтр с ними в fluent.conf

```
<filter service.ui>
  @type parser
  format /\[(?<time>[^\]]*)\]  (?<level>\S+) (?<user>\S+)[\W]*service=(?<service>\S+)[\W]*event=(?<event>\S+)[\W]*(?:path=(?<path>\S+)[\W]*)?request_id=(?<request_id>\S+)[\W]*(?:remote_addr=(?<remote_addr>\S+)[\W]*)?(?:method= (?<method>\S+)[\W]*)?(?:response_status=(?<response_status>\S+)[\W]*)?(?:message='(?<message>[^\']*)[\W]*)?/
  key_name log
</filter>
```

### Разбор логов с помощью grok-шаблонов
Чтобы не писать регулярные выражения самому, можно использовать grok-шаблоны. По сути это именнованные шаблоны регулярных выражений.

Заменил их на grok-шаблон:
```
<filter service.ui>
  @type parser
  key_name log
  format grok
  grok_pattern %{RUBY_LOGGER}
</filter>
```
Это grok-шаблон, зашитый в плагин для fluentd. В развернутом виде он выглядит вот так:
```
%{RUBY_LOGGER} [(?<timestamp>(?>\d\d){1,2}-(?:0?[1-9]|1[0-2])-(?:(?:0[1-9])|(?:[12][0-9])|(?:3[01])|[1-9])[T ](?:2[0123]|[01]?[0-9]):?(?:[0-5][0-9])(?::?(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?))?(?:Z|[+-](?:2[0123]|[01]?[0-9])(?::?(?:[0-5][0-
9])))?) #(?<pid>\b(?:[1-9][0-9]*)\b)\] *(?<loglevel>(?:DEBUG|FATAL|ERROR|WARN|INFO)) -- +(?<progname>.*?): (?<message>.*)
```
Для полноценного парсинга использую несколько grok-шаблонов. Добавив еще секцию с фильтром в конфиг fluentd
```
<filter service.ui>
  @type parser
  format grok
  grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| request_id=%{GREEDYDATA:request_id} \| message='%{GREEDYDATA:message}'
  key_name message
  reserve_data true
</filter>
```
Часть логов сервиса ui осталось неразобранной. Необходимо разобрать их через grok-шаблоны.

Добавил новый фильтр после предыдущего:
```
<filter service.ui>
  @type parser
  format grok
  grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{URIPATH:path} \| request_id=%{GREEDYDATA:request_id} \| remote_addr=%{IPORHOST:remote_addr} \| method=%{GREEDYDATA:method} \| response_status=%{NUMBER:response_status}
  key_name message
  reserve_data false
</filter>
```

### Распределенный трейсинг
Добавил в докер-композ файл для логирования сервис zipkin, который нужен для сбора информации о распределенном трейсинге.
```
...
services: 
...
  zipkin:
    image: openzipkin/zipkin
    container_name: zipkin
    ports:
      - "9411:9411"
    networks:
      - front_net
      - back_net   
```
Отрыл порт

Так же, для каждого сервиса добавл переменную ***ZIPKIN_ENABLED***, а в `.env` файле указал:
```
ZIPKIN_ENABLED=true
```
Что бы зипкин получал трассировку, он должен быть в одной сети с микросервисами. Поэтому добавил в эти сети zipkin.

#### Сломанное приложение (Решение взял у [SJay3](https://github.com/otus-devops-2019-05/SJay3_microservices))
Задание заключается в следующем:

С приложением происходит что-то странное.
Пользователи жалуются, что при нажатии на пост они вынуждены долго ждать, пока у них загрузится страница с постом. Жалоб на загрузку других страниц не поступало. Нужно выяснить, в чем проблема, используя Zipkin.
[сломанное приложение](https://github.com/Artemmkin/bugged-code).

Для начала подготовим инфраструктуру. Что бы не ломать уже существующее приложение, скачаем сломанное в отдельную папку и соберем сервисы с тегом bug
```shell
git clone https://github.com/Artemmkin/bugged-code reddit_bug && rm -rf ./reddit_bug/.git
```
Отредактируем файлы docker_build.sh внутри каждого из микросервисов, добавив тег bug, после чего выполним скрипты, что бы собрались образы.
```shell
export USER_NAME=sjotus
for i in ui post-py comment; do cd reddit_bug/$i; bash docker_build.sh; cd -; done

```

Т.к. в докерфайлах приложения не указаны переменные окружения, то укажем их в докер-композ файле.

Для ui:
```
- POST_SERVICE_HOST=post
- POST_SERVICE_PORT=5000
- COMMENT_SERVICE_HOST=comment
- COMMENT_SERVICE_PORT=9292
```

Для post:
```
- POST_DATABASE_HOST=post_db
- POST_DATABASE=posts
```

Для comment:
```
- COMMENT_DATABASE_HOST=comment_db
- COMMENT_DATABASE=comments
```

Далее отредактируем .env файл, проставив тег bug у приложений и запустим инфраструктуру:
```shell
docker-compose -f docker-compose.yml -f docker-compose-logging.yml up -d
```
Попытаемся загрузить страницу с постом и заметим, что она долго загружается. Переключимся в зипкин и посмотрим трейсы. Можем увидеть трейс, который выполнялся 3с. Если мы взгянем на него подробнее, то увидим, что основное время запроса занял поиск поста в БД, значит проблема в запросах к БД.

Заглянем в исходный код сервиса post в файл `post_app.py` и найдем функцию отвечающую за поиск одного поста. Увидим, что в условии, если пост найден стоит задержка (`time.sleep(3)`).

Закомментируем этот кусок кода, пересоберем приложение для проверки и увидим, что запросы теперь выполняются намного быстрее.

</p>
</details>

<details><summary>15. Оркестрация.</summary>
<p>
 <details><summary>15.1 Docker Swarm.</summary>
 <p>

## Docker Swarm:
Что такое Docker Swarm можно почитать [тут](https://habr.com/ru/company/redmadrobot/blog/318866/) ,посмотреть примеры применения [тут](https://dotsandbrackets.com/quick-intro-docker-swarm-mode-ru/).

В данном задании сделано:
- Подготовка окружения
- Активация Swarm-режима и создание кластера
- Stack
- Labels
- Размещение сервисов
- Масштабирование сервисов
- Rolling Update
- Resources limits
- Restart policy
- docker-compose.infra.yml

### Подготовка окружения
1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/5
vagrant init
vagrant up
```

### Активация Swarm-режима и создание кластера
2. После запуска инфраструктуры подлючаюсь к первой ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
3. Инициализирую Swarm-mode:
```
docker swarm init --advertise-addr 10.50.10.10
```
P.S. если на сервере несколько сетевых интерфейсов или сервер находится за NAT, то необходимо указывать флаг --advertise-addr с конкретным адресом публикации.<br>
По-умолчанию это будет <адрес интерфейса>:2377

В результате выполнения docker swarm init:
- Текущая нода переключается в Swarm-режим
- Текущая нода назначается в качестве Leader менеджера кластера
- Ноде присваивается хостнейм машины
- Менеджер конфигурируется для прослушивания на порту 2377
- Текущая нода получает статус Active, что означает возможность получать задачки от планировщика
- Запускается внутреннее распределенное хранилище данных Docker для работы оркестратора
- Генерируется самоподписный корневый (CA) сертификат для Swarm
- Генерируются токены для присоединения Worker и Manager нод к кластеру
- Создается Overlay-сеть Ingress для публикации сервисов наружу

Кластер создан, в нем теперь есть 1 manager и можно добавить к нему новые ноды. Сгенерированная команда с токеном для присоединения нод выглядит примерно так:
```
docker swarm join --token SWMTKN-1-5b2e8dgiyxepljikd7jvjjrkio3inbtvk2qtezl5obqh5iv5yt-2j2jo8wf82yspzo5dxu05f729 10.50.10.10:2377
```
4. Захожу на вторую ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.11
```
И ввожу команду для присоединения ее к кластеру введя сгенерированную ранее команду:
```
docker swarm join --token SWMTKN-1-5b2e8dgiyxepljikd7jvjjrkio3inbtvk2qtezl5obqh5iv5yt-2j2jo8wf82yspzo5dxu05f729 10.50.10.10:2377
```
Получаю ответ:
```
This node joined a swarm as a worker.
```
5. Добавляю в кластер третью ВМ по аналогии.<br>
6. Закрываю соединения и возвращаюсь к первой ВМ. Дальше работать буду только с ней. Команды в рамках Swarm-кластера можно запускать только на Manager-нодах.<br>
7. Проверяю состояние кластера:
```
docker node ls
```
Вижу такой ответ:
```shell
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
uqw8jlf34krhkevrkq6tfi0k3 *   sw0                 Ready               Active              Leader              19.03.5
qanpoexi6gqx9bk01e0wry0se     sw1                 Ready               Active                                  19.03.5
ltkdrao7zjxhrxtlocma4gsyt     sw2                 Ready               Active                                  19.03.5
```
8. Создаю сервис визуализации кластера (см. п.2 [тут](https://dotsandbrackets.com/quick-intro-docker-swarm-mode-ru/)):
```
docker service create \
	--name=viz \
	--publish=8080:8080 \
	--constraint=node.role==manager \
	--mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	dockersamples/visualizer
```
Просматривать что происходит в кластере можно теперь по ссылке:
```
http://10.50.10.10/
```

### Stack
- Сервисы и их зависимости объединяются в Stack<br>
- Stack описываю в формате docker-compose (YML)<br>
- Управляется стек с помощью команд:
```
docker stack deploy/rm/services/ls STACK_NAME
```
- Данная команда не поддерживает переменные окружения .env, для этого нужно использовать следующую запись:
```
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
9. Запускаю приложения с [примера](docker/example/12):
```
cd ./docker/example/12
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
Смотрю состояние стека:
```
docker stack services DEV
```
Вижу такой ответ (своданая информация по сервисам, а не по контейнерам):
```shell
ID                  NAME                MODE                REPLICAS            IMAGE                 PORTS
dmmj8pngbj43        DEV_ui              replicated          1/1                 chromko/ui:1.0        *:9292->9292/tcp
s54n0nm06d65        DEV_post            replicated          1/1                 chromko/post:1.0      
wbxzxavu7ntk        DEV_post_db         replicated          1/1                 mongo:3.2             
y6xhj09k7c4c        DEV_comment         replicated          1/1                 chromko/comment:1.0   
```
В визуализаторе видно куда разместились контейнеры в кластере.

После чего удаляю сборку:
```
docker stack rm DEV
```

### Labels
Ограничения размещения определяются с помощью логических действий  со значениями label-ов (медатанных) нод и docker-engine’ов.<br>
Обращение к встроенным label’ам нод - node.*<br>
Обращение к заданным вручную label’ам нод - node.labels*<br>
Обращение к label’ам engine - engine.labels.*<br>

Примеры:
- node.labels.reliability == high
- node.role != manager
- engine.labels.provider == google

1. Предположим, что нода sw0 надежнее и дороже, чем worker-ноды поэтому добавлю label к ноде:
```
docker node update --label-add reliability=high sw0
```
Просмотреть label к ноде:
```
docker node ls -q | xargs docker node inspect   -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'
```

### Размещение сервисов
2. Укажу каким сервисам на какой ноде работать, для чего:<br>
- Помещу на sw0 (как на наиболее надежную) базу дописав в ***docker-compose.yml***:
```shell
...
    image: mongo:3.2
    deploy:
      placement:
        constraints:
          - node.labels.reliability == high
... 
```
- Каждому сервису (ui, post, comment) добавлю placement чтобы не перегружать manager с помощью label node.role:
```shell
...
    image: ${USERNAME}/ui:1.0
    deploy:
      placement:
        constraints:
          - node.role == worker
...
```
3. Запуск сборки:
```
cd ./docker/example/13
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
Проверка:
```
docker stack ps DEV
```
Ответ:
```shell
ID                  NAME                IMAGE                 NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
qeu3qfs5ej8m        DEV_comment.1       chromko/comment:1.0   sw1                 Running             Running 2 minutes ago                       
n9w9206zeq7t        DEV_ui.1            chromko/ui:1.0        sw2                 Running             Running 2 minutes ago                       
jonpcvxco153        DEV_post_db.1       mongo:3.2             sw0                 Running             Running 2 minutes ago                       
v12tjsbzvt4f        DEV_post.1          chromko/post:1.0      sw1                 Running             Running 2 minutes ago                       
```
Отобразились 4 задачи. Как видно в поле Node и визуализаторе (http://10.50.10.10/) задачи размещены согласно наложенным условиям:<br>
- mongo - на manager;<br>
- ui,post,comment - на worker-нодах.<br>

4. Удаляю сборку:
```
docker stack rm DEV
```

### Масштабирование сервисов
Для горизонтального масшатбирования и большей отказоустойчивости запустим микросервисы в нескольких экземплярах.<br>
Существует 2 варианта запуска:<br>
- replicated mode - запустить определенное число задач (default);<br>
- global mode - запустить задачу на каждой ноде.

<b>!!! Нельзя</b> заменить replicated mode на global mode ( и обратно) без удаления сервиса.

#### Replicated mode
1. Каждому сервису (ui, post, comment) добавлю Replicated mode в количестве 2-х экземпляров:
```shell
...
    image: ${USERNAME}/ui:1.0
    deploy:
	  mode: replicated
	  replicas: 2
...
```
2. Запуск сборки:
```
cd ./docker/example/14
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
3. Проверка:
```
docker stack services DEV
```
``` shell
ID                  NAME                MODE                REPLICAS            IMAGE                 PORTS
90v3na3my14e        DEV_ui              replicated          2/2                 chromko/ui:1.0        *:9292->9292/tcp
mtepcefhv7x5        DEV_post            replicated          2/2                 chromko/post:1.0      
pamvh44fkjcb        DEV_post_db         replicated          1/1                 mongo:3.2             
r9ijqi5xrq39        DEV_comment         replicated          2/2                 chromko/comment:1.0   
```
Сервисы распределились равномерно по кластеру (стратегия spread) хорошо видно в визуализаторе, и в выводе команды:
```
docker stack ps DEV
```
``` shell
ID                  NAME                IMAGE                 NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
i0bzgp095e3m        DEV_post_db.1       mongo:3.2             sw0                 Running             Running 2 minutes ago                       
q1117b2npu4x        DEV_post.1          chromko/post:1.0      sw2                 Running             Running 2 minutes ago                       
w6bxsw1u4xa1        DEV_comment.1       chromko/comment:1.0   sw1                 Running             Running 2 minutes ago                       
pb5ff4owzcj8        DEV_ui.1            chromko/ui:1.0        sw2                 Running             Running 2 minutes ago                       
i20nd4rbh5hu        DEV_post.2          chromko/post:1.0      sw1                 Running             Running 2 minutes ago                       
rbqq9mdfs63l        DEV_comment.2       chromko/comment:1.0   sw2                 Running             Running 2 minutes ago                       
7sccrn8agtg4        DEV_ui.2            chromko/ui:1.0        sw1                 Running             Running 2 minutes ago                       
```
4. Можно управлять количеством запускаемых сервисов в “на лету”:
```
docker service scale DEV_ui=3
```
Или
```
docker service update --replicas 3 DEV_post
```
Выключить все задачи сервиса:
```
docker service update --replicas 0 DEV_ui
```
5. Удаляю сборку:
```
docker stack rm DEV
```

#### Global mode
Для задач мониторинга кластера нам понадобится запустить node_exporter (только в 1-м экземпляре). Использую global mode.

1. Добавляю в ***docker-compose.yml***:
```shell
...
  node-exporter:
    image: prom/node-exporter:v0.15.2
	deploy:
	  mode: global
    user: root
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.ignored-mount-points="^/(sys|proc|dev|host|etc)($$|/)"'
    networks:
      - front_net
      - back_net
...
```
2. Запуск сборки:
```
cd ./docker/example/15
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
3. Проверка:
```
docker stack services DEV
docker stack ps DEV
```

#### Работа с контейнерами
Внутренний механизм Routing mesh обеспечивает балансировку запросов пользователей между контейнерами UI-сервиса.<br>
1) В независимости от того, на какую ноду прийдет запрос, мы попадем на приложение (которое было опубликовано).<br>
2) Каждое новое TCP/UDP-соединение будет отправлено на следующий endpoint (round-robin балансировка).

Смотрю, где запущен UI-сервис:
```
docker service ps DEV_ui
```
```shell
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
ax02e85usquk        DEV_ui.1            chromko/ui:1.0      sw1                 Running             Running 18 minutes ago                       
iv283e3ld9yh        DEV_ui.2            chromko/ui:1.0      sw2                 Running             Running 18 minutes ago                       
```
Если заходить в браузере на сайт приложения (http://10.50.10.10:9292/) (с интервалом в 10-15с) или обновляя по Ctrl+F5, можно заметить что ID контейнеров меняется.<br>
ID не сходятся, потому что рамках кластера минимальная единица - это задача (task). Контейнер - лишь конкретный экземпляр задачи.<br>
ID контейнера можно посмотреть задав в фильтре имя контейнера (--filter "<b>Name=DEV_ui.1</b>"):
```
docker inspect $(docker stack ps DEV -q --filter "Name=DEV_ui.1") --format "{{.Status.ContainerStatus.ContainerID}}"
```
4. Удаляю сборку:
```
docker stack rm DEV
```

### Rolling Update
Чтобы обеспечить минимальное время простоя приложения во время обновлений (zero-downtime), сконфигурируем параметры деплоя параметром update_conﬁg:
```
service:
    image: svc
    deploy:
      update_config:
        parallelism: 2 
        delay: 5s
        failure_action: rollback
        monitor: 5s
        max_failure_ratio: 2
        order: start-first
```
где: <br>
1) parallelism - cколько контейнеров (группу) обновить одновременно <br>
2) delay - задержка между обновлениями групп контейнеров <br>
3) order - порядок обновлений (сначала убиваем старые и запускаем новые или наоборот) (только в compose 3.4) <br>

Обработка ошибочных ситуаций: <br>
4) failure_action - что делать, если при обновлении возникла ошибка <br>
5) monitor - сколько следить за обновлением, пока не признать его удачным или ошибочным <br>
6) max_failure_ratio - сколько раз обновление может пройти с ошибкой перед тем, как перейти к failure_action <br>

1. <i> Допустим </i> приложение UI должно обновляться группами по 1 контейнеру с разрывом в 5 секунд. <br>
В случае возникновения проблем деплой останавливается (Старые и новые версии работают вместе). <br>
```
...
  ui:
    image: ${USERNAME}/ui:1.0
    deploy:
      mode: replicated
      replicas: 2
      update_config:
        delay: 5s
        parallelism: 1
        failure_action: pause
...
```
Что делать, если обновление прошло с ошибкой?<br>
Отвечает параметр failure_action имеющий следующие параметры:<br>
- pause (default) -  приостановить обновление<br>
- rollback - откатить все задачи на предыдущую версию<br>
- continue - продолжить обновление<br>

!!! Если перезаписать тег работающего приложения, то откатить его не получится!!! Приложение будет сломано!!!

2. Запуск сборки:
```
cd ./docker/example/16
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
3. Проверка:
```
docker service ps DEV_ui
```
4. Удаляю сборку:
```
docker stack rm DEV
```

### Resources limits
С помощью resources limits описываем максимум потребляемых приложениями CPU и памяти. <br>
Это обеспечит:<br>
- представление о том, сколько ресурсов нужно приложению;<br>
- контроль Docker за тем, чтобы никто не превысил заданного порога (с помощью cgroups);<br>
- защиту сторонних приложений от неконтролируемого расхода ресурса контейнером. <br>

1. Ограничу UI, максимум 150М памяти и 25% процессорного времени:
```
...
  ui:
    image: ${USERNAME}/ui:1.0
    deploy:
...
      resources:
        limits:
          cpus: '0.25'
          memory: 150M
...
```
2. Запуск сборки:
```
cd ./docker/example/17
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
3. Проверка:
```
docker service ps DEV_ui
```
4. Удаляю сборку:
```
docker stack rm DEV
```

### Restart policy
Если контейнер в рамках задачи завершит свою работу, то планировщик Swarm автоматически запустит новый (даже если он вручную остановлен).<br>
Можно поменять это поведение (для целей диагностики, например) так, чтобы контейнер перезапускался только при падении контейнера (on-failure).<br>

1. По-умолчанию контейнер будет бесконечно перезапускаться. Это может оказать сильную нагрузку на машину в целом. Ограничим число попыток перезапуска 3-мя с интервалом в 3 секунды.
```
...
  ui:
    image: ${USERNAME}/ui:1.0
    deploy:
...
      restart_policy:
        condition: on-failure
        max_attempts: 3
        delay: 3s
...
```
2. Запуск сборки:
```
cd ./docker/example/18
docker stack deploy --compose-file=<(docker-compose -f docker-compose.yml config 2>/dev/null) DEV
```
3. Проверка:
```
docker service ps DEV_ui
```
4. Удаляю сборку:
```
docker stack rm DEV
```

### docker-compose.infra.yml
Помимо сервисов приложения, может присутствовать инфраструктура, описанная в compose-файле (prometheus, node-exporter, grafana …)<br>
Нужно выделить ее в отдельный compose-файл. С названием  docker-compose.infra.yml.<br>
В него выносится все что относится к этим сервисам (volumes, services).<br>
Запускать приложение вместе с инфрой можно командой:
```
docker stack deploy --compose-file=<(docker-compose -f docker-compose.infra.yml -f docker-compose.yml config 2>/dev/null)  DEV
```

 </p>
 </details>
 <details><summary>15.2 Kubernetes.</summary>
 <p>
 
## Kubernetes:
Что такое [Kubernetes](https://ru.wikipedia.org/wiki/Kubernetes) + общая [информация](https://habr.com/ru/post/258443/).

В данном задании сделано:
- Подготовка окружения
- Запуск приложения в локальном кластере
- Запуск приложения на реальном кластере Kubernetes

### Подготовка окружения
#### Одноузловой кластер с помощью Minikube

Подготовка подразумевает установку некоторых инструментов:<br>
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (если не установлен);<br>
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (интерфейс командной строки для Kubernetes);<br>
- [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/).<br>

В Windows:<br>
- скачать [Kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/windows/amd64/kubectl.exe) и [Minikube](https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe);<br>
- переименовываю в minikube.exe и добавить в PATH-переменную окружения (или в папку, которая уже в ней прописана).<br>
!!! Я просто скинул их в c:\windows
Проверяю работу:
```
kubectl version
```
Вижу:
```
Client Version: version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.0", GitCommit:"70132b0f130acc0bed193d9ba59dd186f0e634cf", GitTreeState:"clean", BuildDate:"2019-12-07T21:20:10Z", GoVersion:"go1.13.4", Compiler:"gc", Platform:"windows/amd64"}
```
2. Запускаю Minukube-кластер:
```
minikube start
```
Вижу:
```
* minikube v1.6.2 on Microsoft Windows 10 Enterprise 10.0.18363 Build 18363
* Selecting 'virtualbox' driver from existing profile (alternates: [])
* Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
...
```
PS. Если нужна конкретная версия kubernetes, указывайте флаг --kubernetes-version <version> (v1.17.0).<br> 
PPS.По-умолчанию используется VirtualBox. Если у вас другой гипервизор, то ставьте флаг --vm-driver=<hypervisor>.

Minikube-кластер развернут. При этом автоматически был настроен конфиг kubectl.

!!! Если во время развертывания произошли ошибки, можно попробовать разобраться добавив флаг ***--alsologtodtderr***, тобы сделать их более подробными.

Таким образом в процессе поднятия кластера было выпогенно следующее:<br>
- запуск ВМ VirtualBox;<br>
- созданы сертификаты для локального системы и ВМ;<br>
- загружен образ;<br>
- установлено соединение между локальной системой и ВМ;<br>
- запущен локальный клвстер Kubernetes внутри ВМ;<br>
- настроен кластер;<br>
- запущены все компоненты панели управления Kubernetes;<br>
- настроена утилита kubectl, чтобы она могла общаться с кластером.

Проверяю кластер:<br>
Подключаюсь к ВМ по ssh:
```
minikube ssh
```
Вижу приветствие в псевдографике.

Проверяю состояние кластера:
```
kubectl cluster-info
```
```
Kubernetes master is running at https://192.168.99.101:8443
KubeDNS is running at https://192.168.99.101:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```
Главный узел Kubernetes работает по адресу https://192.168.99.101:8443 <br>
KubeDNS находится по адресу https://192.168.99.101:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy <br>
Для отладки и диагностики можно использовать команду:
```
kubectl cluster-info dump
```
Проверяю узлы кластера
```
kubectl get nodes
```
```
NAME       STATUS    ROLES     AGE       VERSION
minikube   Ready     <none>    30m        1.17.0
```
Итак, имеется один узел с именем minikube. Более подробную информацию можно получить введя:
```
kubectl descibe node minikube
```
Minikube также имеет в комплекте несколько стандартных аддонов (расширений) для Kubernetes (kube-dns, dashboard, monitoring,…). Каждое расширение - это такие же PODы и сервисы, какие создавались нами, только они еще общаются с API самого Kubernetes.<br>
Посмотрел список расширений:
```
minikube dashboard
```
```shell
- addon-manager: enabled
- dashboard: disabled
- default-storageclass: enabled
- efk: disabled
- freshpod: disabled
- gvisor: disabled
- helm-tiller: disabled
- ingress: disabled
- ingress-dns: disabled
- logviewer: disabled
- metrics-server: disabled
- nvidia-driver-installer: disabled
- nvidia-gpu-device-plugin: disabled
- registry: disabled
- registry-creds: disabled
- storage-provisioner: enabled
- storage-provisioner-gluster: disabled
```
Dashboard - это веб-интерфейс для работы с kubernetes. В целом, он отображает всю ту же информацию, которую можно достать с помощью kubectl.<br>
В самом Dashboard можно: 
- отслеживать состояние кластера и рабочих нагрузок в нем 
- создавать новые объекты (загружать YAML-файлы) 
- Удалять и изменять объекты (кол-во реплик, yaml-файлы) 
- отслеживать логи в Pod-ах 
- при включении Heapster-аддона смотреть нагрузку на Pod-ах 
- и т.д.<br>
Запустил веб-интерфейс:
```
minikube addons enable dashboard
minikube dashboard
```
Браузеры от Microsoft невсегда могут отобразить [minikube](https://192.168.99.101:30000), лучше воспользоваться каким-нибудь сторонним.

Останавливаю minikube:
```
minikube stop
```
И удаляю созданную ВМ:
```
minikube delete
```
#### Многоузловой кластер с помощью kubeadm
Kubeadm работает на готовом устройстве (физическом или виртуальном). Перед созданием кластера нужно подготовить несколько ВМ и установить базовое ПО, такое как Docker, kubelet, kubeadm и kubectl (последняя утилита нужна только на ведущем узле).

1. Запускаю развертывание инфраструктуры:
```
cd vagrant/examples/6
vagrant init
vagrant up
```
2. После запуска инфраструктуры подлючаюсь к ВМ:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
3. Проверяю состояние кластера:
```
kubectl cluster-info
```
```
Kubernetes master is running at https://10.50.10.10:6443
KubeDNS is running at https://10.50.10.10:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```
```
kubectl get nodes
```
```
NAME         STATUS   ROLES    AGE     VERSION
k8s-master   Ready    master   83m     v1.17.0
node-1       Ready    <none>   3m50s   v1.17.0
node-2       Ready    <none>   39m     v1.17.0
node-3       Ready    <none>   47m     v1.17.0
```
#### Создание кластера в облаке GCP вручную
Есть хорошая инструкция по ручной установке основных компонентов Kubernetes-кластера в GCP: [Kubernetes The Hard way](https://github.com/kelseyhightower/kubernetes-the-hard-way), разработанная инженером Google Kelsey Hightower.

#### Создание кластера в облаке GCP с помощью платформы Google Kubernetes Engine
1. Захожу в gcloud console, иду в "Kubernetes Engine" -> "Кластеры".<br>
2. Нажимаю "Создать кластер" и указываю следующие настройки кластера: 
- Размер - 3
- Версия кластера  - 1.13.11-gke.14 
- Тип машины - g1-small небольшая машина (1,7 ГБ) (для экономии ресурсов) 
- Размер загрузочного диска - 20 ГБ  (для экономии)
- Размер - 3 
- Базовая аутентификация - отключена 
- Устаревшие права доступа - отключено 
- Панель управления Kubernetes - отключено <br>
3. Жму “Создать” и жду, пока поднимется кластер.<br>

#### Развернуть кластер в облаке GCP через terraform (*)
Поместил файлы конфигурации терраформа [тут](terraform/examples/9), для развертывания кластера kubernetes в GCP (используя Google Kubernetes Engine).

Для полноценной работы, обязательно использовать версию провайдер > 2.3.0
При развертывании кубернетис кластера через террформ с использованием GKE, сначала будет развернут кластер с дефолтными нодами, т.к. нельзя развернуть кластер без нод. После этого, дефолтный node-pool будет удален и вместо него создастся описаный в `google_container_node_pool` пул нод.
Важно, что если в свойстве location кластера указать зону, то будет развернута только 1 мастер в указанной зоне. Если указать регион, то будет развернуто по экземпляру мастера в каждой зоне региона. Аналогичная ситуация со свойством location в пуле нод. Если указать зону, то в зоне будет развернуто указанной в `node_count` колличество нод. Но если указать регион, то в каждой зоне указанного региона будет развернуто колличество нод, указанное в `node_count`

### Запуск приложения в локальном кластере

#### Запуск приложения в одноузловом кластере с помощью Minikube
1. Запускаю кластер minikube выделив под ВМ 4 CPU и 8 Гб RAM:
```
minikube start --vm-driver=virtualbox --cpus 4 --memory 8192
```
Проверяю, что все поднялось:
```
minikube status
```
2. Запустил 3 реплики сервиса ui (указав файл [ui-deployment.yml](k8s/examples/1/ui-deployment.yml))
```
cd k8s/examples/1/
kubectl apply -f ui-deployment.yml
```
Проверяю, что деплоймент запустился и существует 3 реплики сервиса ui:
```
kubectl get deployment
```
```shell
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
ui        3/3     3            3           61m
```
3. Пробрасываю порт на локальную машину для теста (напримере первого пода), но сначала нахожу ID подов по селектору:
```
kubectl get pods --selector component=ui
```
```shell
NAME                 READY   STATUS             RESTARTS   AGE
ui-5fbcbf86d-k6p28   1/1     Running            0          65m
ui-5fbcbf86d-wpp62   1/1     Running            0          65m
ui-5fbcbf86d-zqj4g   1/1     Running            0          65m
```
```
kubectl port-forward ui-5fbcbf86d-k6p28 8080:9292
```
Захожу в браузере на http://localhost:8080 и вижу UI сервис.

4. По аналогии запускаю comment и post:
```
kubectl apply -f comment-deployment.yml
kubectl apply -f post-deployment.yml
```
Проверяю, что все запустилось:
```
kubectl get deployment
```
```shell
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
comment   3/3     3            3           73m
post      3/3     3            3           72m
ui        3/3     3            3           72m
```
Тетсирую работу пробросив порты:
```
kubectl get pods
```
```shell
NAME                       READY   STATUS             RESTARTS   AGE
comment-77857f8dd8-5kck6   1/1     Running            0          74m
comment-77857f8dd8-n7jtv   1/1     Running            0          74m
comment-77857f8dd8-zzhrw   1/1     Running            0          74m
post-988799f76-24ptb       1/1     Running            0          74m
post-988799f76-jnzcb       1/1     Running            0          74m
post-988799f76-pm274       1/1     Running            0          74m
ui-5fbcbf86d-k6p28         1/1     Running            0          74m
ui-5fbcbf86d-wpp62         1/1     Running            0          74m
ui-5fbcbf86d-zqj4g         1/1     Running            0          74m
```
```
kubectl port-forward comment-77857f8dd8-5kck6 9292:9292
```
Захожу в браузере на http://localhost:9292/healthcheck и вижу ответ.
```
kubectl port-forward post-988799f76-24ptb 5000:5000
```
Захожу в браузере на http://localhost:5000/healthcheck и вижу ответ.

5. Разворачиваю БД на mongo, примонтировав стандартный Volume для хранения данных вне контейнера:
```
kubectl apply -f mongo-deployment.yml
```
Проверяю:
```
kubectl get pods
```
```shell
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
comment-77857f8dd8-5kck6   1/1     Running            0          84m
comment-77857f8dd8-n7jtv   1/1     Running            0          84m
comment-77857f8dd8-zzhrw   1/1     Running            0          84m
mongo-6fbb94b746-lbt8x     1/1     Running            0          84m
post-988799f76-24ptb       1/1     Running            0          84m
post-988799f76-jnzcb       1/1     Running            0          84m
post-988799f76-pm274       1/1     Running            0          84m
ui-5fbcbf86d-k6p28         1/1     Running            0          84m
ui-5fbcbf86d-wpp62         1/1     Running            0          84m
ui-5fbcbf86d-zqj4g         1/1     Running            0          84m
```
##### Использование сервисов
В текущем состоянии приложение не будет работать, т.к. его компоненты ещё не знают как найти друг друга.<br>
Для связи компонент между собой и с внешним миром используется объект Service - абстракция, которая определяет набор POD-ов (Endpoints) и способ доступа к ним.<br>

6. Для связи ui с post и comment создаю и запускаю им по объекту Service:
```
kubectl apply -f ui-service.yml
kubectl apply -f post-service.yml
kubectl apply -f comment-service.yml
```
Post и Comment также используют mongo, следовательно ей тоже нужен объект Service:
```
kubectl apply -f mongodb-service.yml
```
Проверяю log:
```
kubectl logs comment-77857f8dd8-5kck6
```
Вижу ошибки типа:
```
DEBUG -- : MONGODB | Server comment_db:27017 initializing.
DEBUG -- : MONGODB | getaddrinfo: Name does not resolve
```
Приложение ищет совсем другой адрес: comment_db, а не mongodb. <br>
Аналогично и сервис post ищет post_db.<br>
Для решения этой проблемы, создаю Service для БД comment (файл comment-mongodb-service.yml).<br>
Так же изменил деплоймент для mongo, добавив туда теги `comment-db:"true"`, а в деплойменте сервиса comment добавил переменную окружения с именем БД.<br>

Аналогичным образом поступил с сервисом post, добавив для него лейблы в деплоймент mongo, создав отдельный сервис и прописав переменную окружения в деплоймент post. Имя базы должно быть post-db.

Измененные конфиги лежат [тут]((k8s/examples/2).<br>
Для начала убираю все предыдущие объекты:
```
cd ..
kubectl delete -f ./1
```
Запускаю новые:
```
kubectl apply -f ./2
```
Повторяю п.3 и проверяю что приложение и все его компоненты работают.

7. По-умолчанию все сервисы имеют тип ClusterIP - это значит, что сервис распологается на внутреннем диапазоне IP-адресов кластера. Снаружи до него нет доступа.<br>
Чтобы обеспечить доступ к ui-сервису снаружи, понадобится для UI-компоненты Service типа **NodePort**.

Тип NodePort - на каждой ноде кластера открывает порт из диапазона 30000-32767  и переправляет трафик с этого порта на тот, который указан в targetPort Pod (похоже на стандартный expose в docker).

Теперь на сервис можно попасть по пути <Node-IP>:<NodePort> <br>
Также можно указать конкретный NodePort (но все равно из диапазона).

Т.е. в описании service:<br> 
- <b>NodePort</b> - для доступа снаружи кластера; <br>
- <b>port</b> - для доступа к сервису изнутри кластера.

Измененные конфиги лежат [тут]((k8s/examples/3).<br>
Убираю все предыдущие объекты:
```
kubectl delete -f ./2
```
Запускаю новые:
```
kubectl apply -f ./3
```
Minikube может перенаправлять на web-странцы с сервисами которые были помечены типом NodePort.<br>
Смотрю на список сервисов:
```
minikube service list
```
```shell
|-------------|------------|-----------------------------|-----|
|  NAMESPACE  |    NAME    |         TARGET PORT         | URL |
|-------------|------------|-----------------------------|-----|
| default     | comment    | No node port                |     |
| default     | comment-db | No node port                |     |
| default     | kubernetes | No node port                |     |
| default     | post       | No node port                |     |
| default     | post-db    | No node port                |     |
| default     | ui         | http://192.168.99.108:30491 |     |
| kube-system | kube-dns   | No node port                |     |
|-------------|------------|-----------------------------|-----|
```
Зайти на сервис можно по указанному адресу - http://192.168.99.108:30491 <br>
Также minikube может выдавать web-странцы с сервисами которые были помечены типом NodePort:
```
minikube service ui
```
введенная команда выдаст общую информацию и откроет в браузере тот же адрес, предварительно об этом оповестив :
```shell
|-----------|------|-------------|-----------------------------|
| NAMESPACE | NAME | TARGET PORT |             URL             |
|-----------|------|-------------|-----------------------------|
| default   | ui   |             | http://192.168.99.108:30491 |
|-----------|------|-------------|-----------------------------|
* Opening service default/ui in default browser...
```
Убираю все предыдущие объекты:
```
kubectl delete -f ./3
```
##### Использование Namespace в kubernetes
**Namespace** - это, по сути, виртуальный кластер внутри кластера кубернетиса. Неймспейсы можно использовать для создания различных окружений внутри кластера или же для какого-либо логического разделения работающих сервисов. Внутри каждого такого кластера находятся свои объекты (POD-ы, Service-ы, Deployment-ы и т.д.), кроме объектов, общих на все namespace-ы (nodes, ClusterRoles, PersistentVolumes).

В разных нейспейсах могут находиться объекты с одинковым именем, но в рамках одного namespace имена объектов должны быть уникальны.

По-умолчанию в кластере кубернетес уже существует 3 неймспейса:
- default - Для объектов для которых не определен другой неймспейс;
- kube-system - для объектов созданных кубером и для управления им;
- kube-public - для объектов к которым нужен доступ из любой точки кластера.

###### Создание среды для разработки
Отделяю среду для разработки от всего остального кластера, создав dev namespace.

Описываю этот неймспейс в файле [dev-namespace.yml](k8s/examples/dev-namespace.yml)
```
---
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```
Создаю dev namespace и запускаю в нем приложение:
```
kubectl apply -f dev-namespace.yml
kubectl apply -n dev -f ./3
```
Проверяю результат:
```
kubectl get pods -n dev
```
Убираю все предыдущие объекты:
```
kubectl delete -f ./3 -n dev
```
Для возможности запуска по отдельным компонентам разнес их по соответвующим [папкам](k8s/examples/4).<br>
Добавил информацию об окружении в контейнер, определив переменную окружения ENV в [ui-deployment.yml](k8s/examples/4/ui/ui-deployment.yml).<br>
Запускаю и проверяю:
```
kubectl apply -n dev -f ./4/comment
kubectl apply -n dev -f ./4/mongo
kubectl apply -n dev -f ./4/post
kubectl apply -n dev -f ./4/ui
```
Проверяю результат:
```
kubectl get pods -n dev
minikube service ui -n dev
```
Теперь в заголовке UI отображается информация о среде в которой работает приложение.

Таким образои было подготовлено и отлажено приложение в одноузловом кластере с помощью minikube. <br>
Локальный кластер свою роль сыграл и больше не нужен, завершаю его работу:
```
minikube stop
minikube delete
```
Теперь самое время запустить его на реальном кластере Kubernetes.

### Запуск приложения на реальном кластере Kubernetes

#### Многоузловой кластер Kubernetes
1. Создаю кластер с помощью Vagrant и Ansible.
```
cd vagrant/examples/6
vagrant init
vagrant up
```
2. После запуска инфраструктуры подлючаюсь к master-node:
```
ssh -i ~/.ssh/appuser appuser@10.50.10.10
```
3. Запускаю приложение:
- Создаю dev namespace:
```
cd k8s/examples
kubectl apply -f dev-namespace.yml
```
- Запускаю деплой всех компонентов приложения в namespace dev:
```
kubectl apply -n dev -f ./4/comment
kubectl apply -n dev -f ./4/mongo
kubectl apply -n dev -f ./4/post
kubectl apply -n dev -f ./4/ui
```
4. Проверяю IP-адреса нод из кластера: 
```
kubectl get nodes -n dev -o wide
```
```shell
NAME         STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
k8s-master   Ready    master   42h   v1.17.0   10.50.10.10   <none>        Ubuntu 18.04.3 LTS   4.15.0-70-generic   docker://19.3.5
node-1       Ready    <none>   41h   v1.17.0   10.50.10.21   <none>        Ubuntu 18.04.3 LTS   4.15.0-70-generic   docker://19.3.5
node-2       Ready    <none>   41h   v1.17.0   10.50.10.22   <none>        Ubuntu 18.04.3 LTS   4.15.0-70-generic   docker://19.3.5
node-3       Ready    <none>   41h   v1.17.0   10.50.10.23   <none>        Ubuntu 18.04.3 LTS   4.15.0-70-generic   docker://19.3.5
```
а также порт публикации сервиса ui:
```
kubectl describe service ui  -n dev  | grep NodePort
```
```shell
Type:                     NodePort
NodePort:                 <unset>  32092/TCP
```
5. Захожу на сервис по указанному адресу - http://INTERNAL-IP:NodePort

#### Кластер Kubernetes платформа Google Kubernetes Engine
1. Создаю кластер в облаке GCP с помощью платформы Google Kubernetes Engine.
```
cd terraform/examples/9
terraform init
terraform apply
```
После создания кластера иду в gcloud console, иду в "Kubernetes Engine" -> "Кластеры" и жму кнопку "Подключится" и копирую команду подключения к кластеру. Затем ввожу ее в консоли ПК.<br>
В результате в файл ~/.kube/config будут добавлены user, cluster и context для подключения к кластеру в GKE. Также текущий контекст будет выставлен для подключения к этому кластеру. <br>
Проверяю:
```
kubectl config current-context
```
```shell
gke_west-249106_europe-west1-b_standard-cluster-1
```
2. Запускаю приложение в GKE
- Создаю dev namespace
```
cd k8s/examples
kubectl apply -f dev-namespace.yml
```
- Запускаю деплой всех компонентов приложения в namespace dev:
```
kubectl apply -n dev -f ./4/comment
kubectl apply -n dev -f ./4/mongo
kubectl apply -n dev -f ./4/post
kubectl apply -n dev -f ./4/ui
```
3. Открываю приложение для внешнего мира(terraform создает правило автоматически):
3.1 иду в "Сеть VPC" -> "правила брандмауэра";
3.2 жму "Создать правила брандмауэра" и настраиваю:
- Название - произвольно, но понятно 
- Целевые экземпляры - все экземпляры в сети 
- Диапазоны IP-адресов источников  - 0.0.0.0/0
- Протоколы и порты - Указанные протоколы и порты tcp:30000-32767
3.3 жму "Создать"
4. Ищу внешний IP-адрес любой ноды из кластера либо в веб-консоли, либо External IP в выводе: 
```
kubectl get nodes -o wide
```
```shell
NAME                                                STATUS   ROLES    AGE   VERSION           INTERNAL-IP   EXTERNAL-IP     OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-default-pool-b8d3a11d-82xr   Ready    <none>   29m   v1.13.11-gke.14   10.132.0.34   35.189.255.89   Container-Optimized OS from Google   4.14.138+        docker://18.9.7
gke-standard-cluster-1-default-pool-b8d3a11d-8rqt   Ready    <none>   29m   v1.13.11-gke.14   10.132.0.37   104.199.27.54   Container-Optimized OS from Google   4.14.138+        docker://18.9.7
gke-standard-cluster-1-default-pool-b8d3a11d-c0hf   Ready    <none>   29m   v1.13.11-gke.14   10.132.0.35   34.77.29.62     Container-Optimized OS from Google   4.14.138+        docker://18.9.7

```
а также порт публикации сервиса ui:
```
kubectl describe service ui  -n dev  | grep NodePort
```
```shell
Type:                     NodePort
NodePort:                 <unset>  32092/TCP
```
5. Захожу на сервис по указанному адресу - http://EXTERNAL-IP:NodePort

#### Кластер Kubernetes платформа Google Kubernetes Engine + LoadBalancer
Тип NodePort хоть и предоставляет доступ к сервису снаружи, но открывать все порты наружу или искать IP-адреса нод (которые вообще динамические) не очень удобно.<br>
Тип LoadBalancer позволяет нам использовать внешний облачный балансировщик нагрузки как единую точку входа в наши сервисы, а не полагаться на IPTables и не открывать наружу весь кластер.

Для его работы надо настроить соответствующим образом раздел spec: [ui-service.yml](k8s/examples/5/ui/ui-service.yml)

Проверяю как это будет выглядеть.<br>
1. Создаю кластер в облаке GCP с помощью платформы Google Kubernetes Engine.
```
cd terraform/examples/9
terraform init
terraform apply
```
После создания кластера иду в gcloud console, иду в "Kubernetes Engine" -> "Кластеры" и жму кнопку "Подключится" и копирую команду подключения к кластеру. Затем ввожу ее в консоли ПК.<br>
2. Запускаю приложение в GKE<br>
- Создаю dev namespace
```
cd k8s/examples
kubectl apply -f dev-namespace.yml
```
- Запускаю деплой всех компонентов приложения в namespace dev:
```
kubectl apply -n dev -f ./5/comment
kubectl apply -n dev -f ./5/mongo
kubectl apply -n dev -f ./5/post
kubectl apply -n dev -f ./5/ui
```
3. Проверяю, как работает:
```
kubectl get service  -n dev --selector component=ui
```
```shell
NAME   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ui     LoadBalancer   10.27.248.120   <pending>     80:32092/TCP   3s
```
идет настройка ресурсов GCP, пробую попозже перепроверить:
```
kubectl get service  -n dev --selector component=ui
```
```shell
NAME   TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
ui     LoadBalancer   10.27.248.120   35.227.164.74   80:32092/TCP   65s
```
Все отработало, пробую зайти на адрес http://35.227.164.74 и вижу работающее приложение.

4. А что за кулисами? Открываю консоль GCP жму "Сетевые сервисы" -> "Балансировка нагрузки" и вижу созданное правило для балансировки:
```
ad5250515382511eab26f42010a8a001
Интерфейсная ВМ
Протокол	IP-адрес: порт	Уровень сети 
TCP	35.227.164.74:80	Премиум
Серверная ВМ
Название: ad5250515382511eab26f42010a8a001 Регион: us-west1 Привязка сеанса: Не указано Проверка состояния: k8s-bae873c372ced1d3-node
Экземпляры	Зона	35.227.164.74
gke-cluster-reddit-pool-1329f9b4-k7b7	us-west1-b	
gke-cluster-reddit-pool-1329f9b4-b7qw	us-west1-b	
```

Балансировка с помощью Service типа LoadBalancing имеет ряд недостатков: 
• нельзя управлять с помощью http URL ...
• используются только облачные балансировщики (AWS, GCP и тп.)
• нет гибких правил работы с трафиком

#### Кластер Kubernetes платформа Google Kubernetes Engine + Ingress
Для более удобного управления входящим снаружи трафиком и решения недостатков LoadBalancer можно использовать другой объект Kubernetes - Ingress.<br>
Ingress – это набор правил внутри кластера Kubernetes, предназначенных для того, чтобы входящие подключения могли достичь сервисов (Services).<br>
Сами по себе Ingress’ы это просто правила. Для их применения нужен Ingress Controller.<br>
В отличие остальных контроллеров k8s - он не стартует вместе с кластером.

Ingress Controller - это скорее плагин (а значит и отдельный POD), который состоит из 2-х функциональных частей: 
- Приложение, которое отслеживает через k8s API новые объекты Ingress и обновляет конфигурацию балансировщика;
- Балансировщик (Nginx, haproxy, traeﬁk,…), который и занимается управлением сетевым трафиком.

Основные задачи, решаемые с помощью Ingress’ов: 
- Организация единой точки входа в приложения снаружи;
- Обеспечение балансировки трафика;
- Терминация SSL;
- Виртуальный хостинг на основе имен и т.д.

Google в GKE уже предоставляет возможность использовать их собственные решения балансирощик в качестве Ingress controller-ов.

1. Перехожу в настройки кластера в веб-консоли gcloud и проверяю что встроенный Ingress включен. 

2. Создаю Ingress для сервиса UI [ui-ingress.yml](k8s/examples/6/ui/ui-ingress.yml) и запускаю:
- Создаю dev namespace
```
cd k8s/examples
kubectl apply -f dev-namespace.yml
```
- Запускаю деплой всех компонентов приложения в namespace dev:
```
kubectl apply -n dev -f ./6/comment
kubectl apply -n dev -f ./6/mongo
kubectl apply -n dev -f ./6/post
kubectl apply -n dev -f ./6/ui
```
2.1. Singe Service Ingress - значит, что весь ingress контроллер будет просто балансировать нагрузку на Node-ы для одного сервиса очень похоже на Service LoadBalancer).

Зайдя в консоль GCP и вижу правило.<br>
Это NodePort опубликованного сервиса.<br>
Т.е. для работы с Ingress в GCP нам нужен минимум Service с типом NodePort (он уже есть).

2.2. Заставляю работать Ingress Controller как классический веб [ui-ingress.yml](k8s/examples/7/ui/ui-ingress.yml)
```
kubectl apply -n dev -f ./7/ui
```
2.3. Защищаю сервис с помощью TLS.
- Смотрю Ingress IP
```
kubectl get ingress -n dev
```
```shell

```
- Генерирую сертификат используя IP как CN
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN= 35.190.66.90"
```
- Гружу сертификат в кластер kubernetes
```
kubectl create secret tls ui-ingress --key tls.key --cert tls.crt -n dev
```
- Проверяю
```
kubectl describe secret ui-ingress -n dev
```
- Настроил Ingress на прием только HTTPS-траффика [ui-ingress.yml](k8s/examples/8/ui/ui-ingress.yml)
```
kubectl apply -n dev -f ./8/ui
```
Зайдя на страницу web console вижу в описании балансировщика только один протокол HTTPS.<br>
Иногда протокол HTTP может не удалиться у существующего Ingress правила, тогда нужно его вручную удалить и пересоздать:
```
kubectl delete ingress ui -n dev
kubectl apply -f ui-ingress.yml -n dev
```
Захожу на страницу приложения по https, подтверждаю исключение безопасности (сертификат самоподписанный) и вижу что все работает.

- Создаю объект Secret в виде Kubernetes-манифеста [ui-secret-ingress.yml](k8s/examples/9/ui/ui-secret-ingress.yml)
 </p>
 </details>
</p>
</details>
<details><summary>16. Основные сервисы Amazon Web Services (AWS).</summary>
<p>

## Amazon Web Services (AWS):

Наиболее часто используемые сервисы, на мой взгляд: <br>
- virtual servers        -> EC2 Instances<br>
- virtual networks       -> VPC<br>
- web space              -> S3 Bucket<br>
- web Sites Hosting      -> S3 Web Hosting<br>
- DNS                    -> Route 53<br>
- SQL & noSQL DB         -> RDS, Dynamo DB<br>
- Infrastructure as Code -> CloudFormation<br>
- Automation             -> Elastic Beanstalk<br>

В данном домашнем задании было сделано:<br>
- Создание учетной записи в AWS<br>
- Первичные настройки учетной записи после регистрации<br>
- Установка aws cli

### Создание учетной записи в AWS
Регистрация производится по ссылке: https://aws.amazon.com/ru/
Нажав кнопку ***Создайте бесплатный аккаунт*** заполняю регистрационную формуа, в процессе регистрации необходимы:<br> 
1. Номер кредитной карты с возможностью оплаты через Интернет (будет списан 1$ проверка ее работоспособности);<br>
2. Номер реального телефона (у меня автоматическая проверка телефона не сработала, пришлось завершать регистрацию через службу поддержки).

### Первичные настройки учетной записи после регистрации
Делал настройки по [инструкции](https://www.youtube.com/watch?v=NBBIjFUQ2W0&list=PLg5SS_4L6LYsxrZ_4xE_U95AtGsIB96k9&index=5).<br>
1. Настроил алиас ссылки для входа в консоль, чтобы был не цифровой ID, а нормальное имя: <br>
Services -> IAM -> IAM users sign-in link:(Cusomize) <br>
2. Создал рабочего пользователя с подключением по ключу (ключи сохранил в файле):<br>
Services -> IAM -> Create individual IAM users -> Add user -> admin (Create access key)<br>
3. В процессе создания пользователя параллельно создал группу Administrators:<br>
Create group -> Administrators -> AdminAccess (роль)<br>
4. Включил двухфакторную аутентификацию.

### Установка aws cli
Устанавливал по [инструкции](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
[Инструкция по установке в Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)
Авторизировался в системе:
```
aws configure
```
Ответив на вопросы (ключи взял из файла пользователя), пример:
```
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: ENTER
```
### запуск простого EC2 инстанса
```
cd ./terraform/examples/10
terraform init
terraform apply
```
Проверяю через aws cli:
```
aws ec2 describe-instances
```
получаю ответ:
```
{
    "Reservations": [
        {
            "Groups": [],
            "Instances": [
                {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-0a9e2b8a093c02922",
                    "InstanceId": "i-086dab84cf90e1f50",
                    "InstanceType": "t2.micro",
                    "LaunchTime": "2020-06-12T07:28:39.000Z",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Placement": {
                        "AvailabilityZone": "eu-central-1c",
                        "GroupName": "",
                        "Tenancy": "default"
                    },
                    "PrivateDnsName": "ip-172-31-3-33.eu-central-1.compute.internal",
                    "PrivateIpAddress": "172.31.3.33",
                    "ProductCodes": [],
                    "PublicDnsName": "ec2-18-196-129-234.eu-central-1.compute.amazonaws.com",
                    "PublicIpAddress": "18.196.129.234",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
...
```
### запуск EC2 инстанса с доступом по SSH
```
cd ./terraform/examples/11
terraform init
terraform apply
```
После запуска ВМ выведется информация:
```
external-ip = [
  "18.157.84.232",
]
```
Соответственно, подключаюсь к этому адресу по SSH исполььзуя имя ***ec2-user*** согласно [инструкции](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html) для выбранного типа ami образа:
```
ssh -i ~/.ssh/key.pem ec2-user@18.157.84.232
```
и вижу приветствие ВМ:
```

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/
5 package(s) needed for security, out of 7 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-172-31-4-7 ~]$
```

</p>
</details>
 