#  Как работать с репозиторием финального задания

## Что нужно сделать

Настроить запуск проекта Kittygram в контейнерах и CI/CD с помощью GitHub Actions

## Как проверить работу с помощью автотестов

В корне репозитория создайте файл tests.yml со следующим содержимым:
```yaml
repo_owner: ваш_логин_на_гитхабе
kittygram_domain: полная ссылка (http://<ip-адрес вашей ВМ>:<порт gateway>) на ваш проект Kittygram
dockerhub_username: ваш_логин_на_докерхабе
```

Скопируйте содержимое файла `.github/workflows/main.yml` в файл `kittygram_workflow.yml` в корневой директории проекта.

Для локального запуска тестов создайте виртуальное окружение, установите в него зависимости из backend/requirements.txt и запустите в корневой директории проекта `pytest`.

## Чек-лист для проверки перед отправкой задания

- Проект Kittygram доступен по ссылке, указанной в `tests.yml`.
- Пуш в ветку main запускает тестирование и деплой Kittygram, а после успешного деплоя вам приходит сообщение в телеграм.
- В корне проекта есть файл `kittygram_workflow.yml`.

## Terraform и деплой

Инфраструктура описана в директории `infra/`. Workflow `.github/workflows/terraform.yml`
запускается вручную и поддерживает операции `plan`, `apply` и `destroy`.

Перед запуском Terraform нужно заранее создать S3-бакет для state и добавить в
GitHub Secrets:

- `ACCESS_KEY` и `SECRET_KEY` — статический ключ Object Storage.
- `TF_STATE_BUCKET` — имя заранее созданного bucket для Terraform state.
- `YC_TOKEN`, `YC_CLOUD_ID`, `YC_FOLDER_ID` — доступ к Яндекс Облаку.
- `SSH_PUBLIC_KEY` — публичный SSH-ключ для пользователя `ubuntu`.
- `APP_BUCKET_NAME` — имя bucket, который Terraform создаст для проекта.

Для деплоя приложения нужны secrets:

- `SSH_KEY`, опционально `SSH_USER` и `SSH_PORT`.
- `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`.
- `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`.
- `TELEGRAM_TO`, `TELEGRAM_TOKEN`.

Перед первым деплоем запустите workflow `Terraform` с операцией `apply`.
После успешного `apply` workflow сохраняет публичный IP виртуальной машины в
artifact `vm-ip`, а workflow `.github/workflows/deploy.yml` запускается
автоматически, скачивает этот artifact и деплоит Kittygram на созданную VM.
