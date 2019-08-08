# Dethroner					[![Build Status](https://travis-ci.org/Dethroner/practice-git.svg?branch=master)](https://travis-ci.org/Dethroner/practice-git)

<details><summary>01. Система контроля версий. Принципы работы с Git.</summary>
<p>

### Git:
Знакомство с git [Инструкция](https://githowto.com/ru).
Канал с видеоматериалами по [git](https://www.youtube.com/playlist?list=PLg5SS_4L6LYstwxTEOU05E0URTHnbtA0l).

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

В данном домашнем задании было сделано:
- Создание учетной записи в GCP
- Установка gcloud
- Создание ssh ключей для инстансов ВМ
- Создание инстансов ВМ из веб-интерфейса
- Подключение по ssh через бастион-хост
- Подклчюение по vpn через бастион-хост
- Настройка ssl сертификатов для vpn-сервера

### Регистрация учетной записи в GCP
Регистрация производится по ссылке: https://cloud.google.com/free/
Лучше всего использовать отдельный аккаунт Gmail.
### Установка gcloud
Устанавливаем по [инструкции](https://cloud.google.com/sdk/docs).
[Инструкция по установке в Linux](https://cloud.google.com/sdk/docs/#deb)
Авторизируемся в системе:
```
gcloud init
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

<details><summary>04. Основные сервисы Google Cloud Platform (GCP)</summary>
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
    ssh-keys = "appuser2:${file(var.public_key_path)} \nappuser3:${file(var.public_key_path)}"
  }
}
```
Нельзя использовать сразу 2 этих ресурса, т.к. терраформ будет затирать данные, добавленные одним из ресурсов. Так же, добавленные через веб-интерфейс ключи тоже будут удалены, если терраформ управляет метадатой.

### Работа с Terraform
1. Создать папку terraform перейти в нее. Создать файл main.tf
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
1. [Пример](https://github.com/Dethroner/practice-git/tree/master/terraform/examples/1) того как использовать входную переменную ее нужно сначала определить в одном из конфигурационных файлов. Создать для этих целей еще один конфиг файл variables.tf
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
- Добавление provisioner в модули приложения (**)

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

#### Работа с модулями:
Модули позволяют разделять ресурсы и облегчают управление ими. Инфраструктура разбита на 3 модуля:
- [app](terraform/modules/app) - web часть сервиса
- [db](terraform/modules/db) - модуль для работы с базами данных
- [vpc](terraform/modules/vpc) - модуль для управления доступом к проекту


</p>
</details>
