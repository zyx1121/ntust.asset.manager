# NTUST Asset Management Plugin for Redmine

## 插件安裝

```bash
cd /path_to_redmine/plugins
git clone https://github.com/zyx1121/ntust.asset.manager ntust_asset_manager
```
```bash
bundle exec rake redmine:plugins:migrate
```

## 新增資產

```bash
bundle exec rails console
```
```ruby
Asset.create(name: "Laptop", description: "A very nice laptop.", status: "Available")
```
