# NTUST Asset Management Plugin for Redmine

## Redmine 架設
```yml
# docker-compose.yml

version: '3.1'
services:
  postgres:
    image: postgres:latest
    restart: always
    networks:
      - redmine
    environment:
      - 'POSTGRES_PASSWORD=password'
      - 'POSTGRES_DB=redmine'
  redmine:
    image: redmine:3.3.2
    restart: always
    networks:
      - redmine
    ports:
      - 80:3000
    environment:
      - 'REDMINE_DB_POSTGRES=postgres'
      - 'REDMINE_DB_DATABASE=redmine'
      - 'REDMINE_DB_PASSWORD=password'
networks:
  redmine:
    driver: bridge
```
```bash
docker-compose up
```

## 插件安裝
```bash
cd /path/to/redmine/plugins
git clone https://github.com/zyx1121/ntust.asset.manager ntust_asset_manager
```
```bash
bundle exec rake redmine:plugins:migrate
```

## 新增資產
```bash
rails console
```
```ruby
Asset.create(name: "Laptop", description: "A very nice laptop.", status: "Available")
```
