# Dethroner

[![Build Status](https://travis-ci.org/Dethroner/practice-git.svg?branch=master)](https://travis-ci.org/Dethroner/practice-git)

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

    /github subscribe Dethroner/practice-git commits:all

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

11. Авторизуемся чезер утилиту travis

```shell
travis login --com
```

12. Теперь зашифруем токен с помощью утилиты travis. Мы должны находиться в папке с нашим репозиторием и в нем должен присутствовать файл `.travis.yml`

```shell
cd ~/Dethroner/practice-git
travis encrypt "testlanworkspace:<ваш_токен>#995" \
--add notifications.slack.rooms --com
```

13. travis автоматически добавит в файл `.travis.yml` шифрованый токен для уведомлений в slack. Остается только закоммитить изменения в файле.

</p>
</details>

<details><summary>Инструкция по интеграции со slack (для Windows):</summary>
<p>

Не завершена пока!!!

Устанавливаем [ruby](https://www.ruby-lang.org/ru/documentation/installation/), [rubygems](https://rubygems.org/pages/download) и с помощью gem установить [travis](https://github.com/travis-ci/travis.rb#installation).  

[Авторизируемся через утилиту travis](https://github.com/travis-ci/travis.rb#login).    
```
    travis login --com
```
[Шифруем пароль](https://github.com/travis-ci/travis.rb#encrypt).  
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

В данном домашнем задании было сделано:
- Создание учетной записи в GCP
- Создание ssh ключей для инстансов ВМ
- Создание инстансов ВМ из веб-интерфейса
- Подключение по ssh через бастион-хост
- Подклчюение по vpn через бастион-хост
- Настройка ssl сертификатов для vpn-сервера

### gcloud:

Устанавливаем по [инструкции](https://cloud.google.com/sdk/docs).

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
[Документация](https://cloud.google.com/sdk/gcloud/reference/).

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

Устанавливаем [Pritunl](https://docs.pritunl.com/docs/installation#section-linux-repositories).

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

### GCP:

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

<details><summary>06. Практика IaС. Знакомство с Terraform/</summary>
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



</p>
</details>
